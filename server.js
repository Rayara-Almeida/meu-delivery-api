const express = require('express');
const pool = require('./database');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const autenticarToken = require('./autenticador');
const verificarPerfil = require('./verificarPerfil');

const app = express();
const JWT_SECRET = 'chave-secreta-meu-delivery'

app.use(express.json());

app.get('/', async (req, res) => {
    try {
        const resultado = await pool.query('SELECT NOW()');

        res.json({
            mensagem: 'API funcionando e conectada ao PostgreSQL!',
            horario_banco: resultado.rows[0].now
        });

    } catch (erro) {
        console.error(erro);

        res.status(500).json({
            mensagem: 'Erro ao conectar com o banco de dados.'
        });
    }
});
app.post('/usuarios', async (req, res) => {
    try {
        const { nome, email, telefone, senha, id_perfil } = req.body;

        if (!nome || !email || !senha || !id_perfil) {
            return res.status(400).json({
                mensagem: 'Nome, e-mail, senha e perfil são obrigatórios.'
            });
        }

        const senhaHash = await bcrypt.hash(senha, 10);

        const resultado = await pool.query(
            `INSERT INTO usuario 
            (nome, email, telefone, senha, id_perfil)
            VALUES ($1, $2, $3, $4, $5)
            RETURNING id_usuario, nome, email, telefone, id_perfil`,
            [nome, email, telefone, senhaHash, id_perfil]
        );

        res.status(201).json({
            mensagem: 'Usuário cadastrado com sucesso!',
            usuario: resultado.rows[0]
        });

    } catch (erro) {
        console.error(erro);

        if (erro.code === '23505') {
            return res.status(409).json({
                mensagem: 'E-mail já cadastrado.'
            });
        }

        if (erro.code === '23503') {
            return res.status(400).json({
                mensagem: 'Perfil informado não existe.'
            });
        }

        res.status(500).json({
            mensagem: 'Erro ao cadastrar usuário.'
        });
    }
});
app.post('/clientes', async (req, res) => {
    try {
        const { nome, email, telefone, senha } = req.body;

        if (!nome || !email || !senha) {
            return res.status(400).json({
                mensagem: 'Nome, e-mail e senha são obrigatórios.'
            });
        }

        const senhaHash = await bcrypt.hash(senha, 10);

        const resultado = await pool.query(
            `INSERT INTO usuario
            (nome, email, telefone, senha, id_perfil)
            VALUES ($1, $2, $3, $4, 3)
            RETURNING id_usuario, nome, email, telefone, id_perfil`,
            [nome, email, telefone, senhaHash]
        );

        res.status(201).json({
            mensagem: 'Cliente cadastrado com sucesso!',
            usuario: resultado.rows[0]
        });

    } catch (erro) {
        console.error(erro);

        if (erro.code === '23505') {
            return res.status(409).json({
                mensagem: 'E-mail já cadastrado.'
            });
        }

        res.status(500).json({
            mensagem: 'Erro ao cadastrar cliente.'
        });
    }
});
app.post('/login', async (req, res) => {
    try {
        const { email, senha } = req.body;

        if (!email || !senha) {
            return res.status(400).json({
                mensagem: 'E-mail e senha são obrigatórios.'
            });
        }

        const resultado = await pool.query(
            `SELECT id_usuario, nome, email, telefone, senha, id_perfil
             FROM usuario
             WHERE email = $1`,
            [email]
        );

        if (resultado.rows.length === 0) {
            return res.status(401).json({
                mensagem: 'E-mail ou senha inválidos.'
            });
        }

        const usuario = resultado.rows[0];

        const senhaCorreta = await bcrypt.compare(senha, usuario.senha);

        if (!senhaCorreta) {
            return res.status(401).json({
                mensagem: 'E-mail ou senha inválidos.'
            });
        }

        const token = jwt.sign(
            {
                id_usuario: usuario.id_usuario,
                id_perfil: usuario.id_perfil
            },
            JWT_SECRET,
            {
                expiresIn: '1h'
            }
        );

        res.json({
            mensagem: 'Login realizado com sucesso!',
            token: token,
            usuario: {
                id_usuario: usuario.id_usuario,
                nome: usuario.nome,
                email: usuario.email,
                telefone: usuario.telefone,
                id_perfil: usuario.id_perfil
            }
        });

    } catch (erro) {
        console.error(erro);

        res.status(500).json({
            mensagem: 'Erro ao realizar login.'
        });
    }
});
app.get('/loja/status', autenticarToken, verificarPerfil(2), async (req, res) => {
    try {
        const resultado = await pool.query(
            `SELECT 
                l.id_loja,
                l.nome,
                l.aberta,
                h.hora_abertura,
                h.hora_fechamento
             FROM loja l
             LEFT JOIN horario_funcionamento h
                ON l.id_loja = h.id_loja
                AND h.dia_semana = LOWER(
                    CASE EXTRACT(DOW FROM CURRENT_DATE)
                        WHEN 0 THEN 'domingo'
                        WHEN 1 THEN 'segunda'
                        WHEN 2 THEN 'terça'
                        WHEN 3 THEN 'quarta'
                        WHEN 4 THEN 'quinta'
                        WHEN 5 THEN 'sexta'
                        WHEN 6 THEN 'sábado'
                    END
                )
             WHERE l.id_usuario = $1`,
            [req.usuario.id_usuario]
        );

        if (resultado.rows.length === 0) {
            return res.status(404).json({
                mensagem: 'Loja não encontrada.'
            });
        }

        const loja = resultado.rows[0];

        const agora = new Date();
        const horaAtual = agora.toTimeString().slice(0, 8);

        const dentroHorario = Boolean(
            loja.hora_abertura &&
            loja.hora_fechamento &&
            horaAtual >= loja.hora_abertura &&
            horaAtual <= loja.hora_fechamento
        );

        const estaAberta = loja.aberta && dentroHorario;

        res.json({
            id_loja: loja.id_loja,
            nome: loja.nome,
            aberta: estaAberta,
            interruptor_aberto: loja.aberta,
            dentro_horario: dentroHorario
        });

    } catch (erro) {
        console.error(erro);

        res.status(500).json({
            mensagem: 'Erro ao verificar status da loja.'
        });
    }
});
app.get('/lojas', async (req, res) => {
    try {
        const { nome, categoria } = req.query;

        const parametros = [];
        const filtros = [];

        if (nome) {
            parametros.push(`%${nome}%`);
            filtros.push(`LOWER(l.nome) LIKE LOWER($${parametros.length})`);
        }

        if (categoria) {
            parametros.push(categoria);
            filtros.push(`LOWER(l.categoria) = LOWER($${parametros.length})`);
        }

        const filtroSQL = filtros.length > 0
            ? `WHERE ${filtros.join(' AND ')}`
            : '';

        const resultado = await pool.query(
            `
            SELECT
                l.id_loja,
                l.nome,
                l.foto,
                l.categoria,
                l.tempo_estimado,
                l.taxa,
                l.aberta,
                h.hora_abertura,
                h.hora_fechamento
            FROM loja l
            LEFT JOIN horario_funcionamento h
                ON l.id_loja = h.id_loja
                AND h.dia_semana = LOWER(
                    CASE EXTRACT(DOW FROM CURRENT_DATE)
                        WHEN 0 THEN 'domingo'
                        WHEN 1 THEN 'segunda'
                        WHEN 2 THEN 'terça'
                        WHEN 3 THEN 'quarta'
                        WHEN 4 THEN 'quinta'
                        WHEN 5 THEN 'sexta'
                        WHEN 6 THEN 'sábado'
                    END
                )
            ${filtroSQL}
            ORDER BY l.nome
            `,
            parametros
        );

        const agora = new Date();
        const horaAtual = agora.toTimeString().slice(0, 8);

        const lojas = resultado.rows.map(loja => {

            const dentroHorario = Boolean(
                loja.hora_abertura &&
                loja.hora_fechamento &&
                horaAtual >= loja.hora_abertura &&
                horaAtual <= loja.hora_fechamento
            );

            const estaAberta = loja.aberta && dentroHorario;

            return {
                id_loja: loja.id_loja,
                nome: loja.nome,
                foto: loja.foto,
                categoria: loja.categoria,
                tempo_estimado: loja.tempo_estimado,
                taxa: loja.taxa,
                aberta: estaAberta
            };
        });

        res.json(lojas);

    } catch (erro) {
        console.error(erro);

        res.status(500).json({
            mensagem: 'Erro ao buscar lojas.'
        });
    }
});
app.get('/perfil', autenticarToken, async (req, res) => {
    try {
        const resultado = await pool.query(
            `SELECT id_usuario, nome, email, telefone, id_perfil
             FROM usuario
             WHERE id_usuario = $1`,
            [req.usuario.id_usuario]
        );

        if (resultado.rows.length === 0) {
            return res.status(404).json({
                mensagem: 'Usuário não encontrado.'
            });
        }

        res.json({
            mensagem: 'Acesso autorizado!',
            usuario: resultado.rows[0]
        });

    } catch (erro) {
        console.error(erro);

        res.status(500).json({
            mensagem: 'Erro ao buscar perfil.'
        });
    }
});
app.get('/admin', autenticarToken, verificarPerfil(1), (req, res) => {
    res.json({
        mensagem: 'Acesso autorizado! Você é administrador.'
    });
});
app.get('/loja', autenticarToken, verificarPerfil(2), (req, res) => {
    res.json({
        mensagem: 'Acesso autorizado! Você é da loja.'
    });
});
app.post('/loja/faixas-entrega', autenticarToken, verificarPerfil(2), async (req, res) => {
    try {
        const { distancia_maxima_km, taxa } = req.body;

        if (!distancia_maxima_km || taxa === undefined) {
            return res.status(400).json({
                mensagem: 'Distância máxima e taxa são obrigatórias.'
            });
        }

        const loja = await pool.query(
            `SELECT id_loja
             FROM loja
             WHERE id_usuario = $1`,
            [req.usuario.id_usuario]
        );

        if (loja.rows.length === 0) {
            return res.status(404).json({
                mensagem: 'Loja não encontrada.'
            });
        }

        const resultado = await pool.query(
            `INSERT INTO faixa_entrega
                (id_loja, distancia_maxima_km, taxa)
             VALUES ($1, $2, $3)
             RETURNING id_faixa, id_loja, distancia_maxima_km, taxa`,
            [
                loja.rows[0].id_loja,
                distancia_maxima_km,
                taxa
            ]
        );

        res.status(201).json({
            mensagem: 'Faixa de entrega cadastrada com sucesso!',
            faixa: resultado.rows[0]
        });

    } catch (erro) {
        console.error(erro);

        res.status(500).json({
            mensagem: 'Erro ao cadastrar faixa de entrega.'
        });
    }
});
app.get('/loja/faixas-entrega', autenticarToken, verificarPerfil(2), async (req, res) => {
    try {
        const resultado = await pool.query(
            `SELECT
                id_faixa,
                id_loja,
                distancia_maxima_km,
                taxa
             FROM faixa_entrega
             WHERE id_loja = (
                 SELECT id_loja
                 FROM loja
                 WHERE id_usuario = $1
             )
             ORDER BY distancia_maxima_km`,
            [req.usuario.id_usuario]
        );

        res.json(resultado.rows);

    } catch (erro) {
        console.error(erro);

        res.status(500).json({
            mensagem: 'Erro ao buscar faixas de entrega.'
        });
    }
});
app.post('/loja/categorias', autenticarToken, verificarPerfil(2), async (req, res) => {
    try {
        const { nome } = req.body;

        if (!nome) {
            return res.status(400).json({
                mensagem: 'Nome da categoria é obrigatório.'
            });
        }

        const loja = await pool.query(
            `SELECT id_loja
             FROM loja
             WHERE id_usuario = $1`,
            [req.usuario.id_usuario]
        );

        if (loja.rows.length === 0) {
            return res.status(404).json({
                mensagem: 'Loja não encontrada.'
            });
        }

        const resultado = await pool.query(
            `INSERT INTO categoria
                (id_loja, nome)
             VALUES ($1, $2)
             RETURNING id_categoria, id_loja, nome`,
            [loja.rows[0].id_loja, nome]
        );

        res.status(201).json({
            mensagem: 'Categoria cadastrada com sucesso!',
            categoria: resultado.rows[0]
        });

    } catch (erro) {
        console.error(erro);

        res.status(500).json({
            mensagem: 'Erro ao cadastrar categoria.'
        });
    }
});
app.get('/loja/categorias', autenticarToken, verificarPerfil(2), async (req, res) => {
    try {
        const resultado = await pool.query(
            `SELECT
                c.id_categoria,
                c.nome
             FROM categoria c
             INNER JOIN loja l
                ON c.id_loja = l.id_loja
             WHERE l.id_usuario = $1
             ORDER BY c.nome`,
            [req.usuario.id_usuario]
        );

        res.json(resultado.rows);

    } catch (erro) {
        console.error(erro);

        res.status(500).json({
            mensagem: 'Erro ao buscar categorias.'
        });
    }
});
app.put('/loja/categorias/:id', autenticarToken, verificarPerfil(2), async (req, res) => {
    try {
        const { nome } = req.body;
        const idCategoria = req.params.id;

        if (!nome) {
            return res.status(400).json({
                mensagem: 'Nome da categoria é obrigatório.'
            });
        }

        const resultado = await pool.query(
            `UPDATE categoria c
             SET nome = $1
             FROM loja l
             WHERE c.id_categoria = $2
               AND c.id_loja = l.id_loja
               AND l.id_usuario = $3
             RETURNING c.id_categoria, c.id_loja, c.nome`,
            [nome, idCategoria, req.usuario.id_usuario]
        );

        if (resultado.rows.length === 0) {
            return res.status(404).json({
                mensagem: 'Categoria não encontrada.'
            });
        }

        res.json({
            mensagem: 'Categoria atualizada com sucesso!',
            categoria: resultado.rows[0]
        });

    } catch (erro) {
        console.error(erro);

        res.status(500).json({
            mensagem: 'Erro ao atualizar categoria.'
        });
    }
});
app.delete('/loja/categorias/:id', autenticarToken, verificarPerfil(2), async (req, res) => {
    try {
        const idCategoria = req.params.id;

        const resultado = await pool.query(
            `DELETE FROM categoria c
             USING loja l
             WHERE c.id_categoria = $1
               AND c.id_loja = l.id_loja
               AND l.id_usuario = $2
             RETURNING c.id_categoria`,
            [idCategoria, req.usuario.id_usuario]
        );

        if (resultado.rows.length === 0) {
            return res.status(404).json({
                mensagem: 'Categoria não encontrada.'
            });
        }

        res.json({
            mensagem: 'Categoria excluída com sucesso!'
        });

    } catch (erro) {
        console.error(erro);

        if (erro.code === '23503') {
            return res.status(409).json({
                mensagem: 'Não é possível excluir a categoria porque existem produtos vinculados a ela.'
            });
        }

        res.status(500).json({
            mensagem: 'Erro ao excluir categoria.'
        });
    }
});
app.post('/loja/produtos', autenticarToken, verificarPerfil(2), async (req, res) => {
    try {
        const {
            id_categoria,
            nome,
            foto,
            descricao,
            preco
        } = req.body;

        if (!id_categoria || !nome || preco === undefined) {
            return res.status(400).json({
                mensagem: 'Categoria, nome e preço são obrigatórios.'
            });
        }

        const categoria = await pool.query(
            `SELECT c.id_categoria
             FROM categoria c
             INNER JOIN loja l
                ON c.id_loja = l.id_loja
             WHERE c.id_categoria = $1
               AND l.id_usuario = $2`,
            [id_categoria, req.usuario.id_usuario]
        );

        if (categoria.rows.length === 0) {
            return res.status(404).json({
                mensagem: 'Categoria não encontrada.'
            });
        }

        const resultado = await pool.query(
            `INSERT INTO produto
                (id_categoria, nome, foto, descricao, preco)
             VALUES ($1, $2, $3, $4, $5)
             RETURNING
                id_produto,
                id_categoria,
                nome,
                foto,
                descricao,
                preco,
                disponivel`,
            [id_categoria, nome, foto, descricao, preco]
        );

        res.status(201).json({
            mensagem: 'Produto cadastrado com sucesso!',
            produto: resultado.rows[0]
        });

    } catch (erro) {
        console.error(erro);

        res.status(500).json({
            mensagem: 'Erro ao cadastrar produto.'
        });
    }
});
app.get('/loja/produtos', autenticarToken, verificarPerfil(2), async (req, res) => {
    try {
        const resultado = await pool.query(
            `SELECT
                p.id_produto,
                p.id_categoria,
                c.nome AS categoria,
                p.nome,
                p.foto,
                p.descricao,
                p.preco,
                p.disponivel
             FROM produto p
             INNER JOIN categoria c
                ON p.id_categoria = c.id_categoria
             INNER JOIN loja l
                ON c.id_loja = l.id_loja
             WHERE l.id_usuario = $1
             ORDER BY c.nome, p.nome`,
            [req.usuario.id_usuario]
        );

        res.json(resultado.rows);

    } catch (erro) {
        console.error(erro);

        res.status(500).json({
            mensagem: 'Erro ao buscar produtos.'
        });
    }
});
app.put('/loja/produtos/:id', autenticarToken, verificarPerfil(2), async (req, res) => {
    try {
        const idProduto = req.params.id;
        const {
            id_categoria,
            nome,
            foto,
            descricao,
            preco
        } = req.body;

        if (!id_categoria || !nome || preco === undefined) {
            return res.status(400).json({
                mensagem: 'Categoria, nome e preço são obrigatórios.'
            });
        }

        const categoria = await pool.query(
            `SELECT c.id_categoria
             FROM categoria c
             INNER JOIN loja l
                ON c.id_loja = l.id_loja
             WHERE c.id_categoria = $1
               AND l.id_usuario = $2`,
            [id_categoria, req.usuario.id_usuario]
        );

        if (categoria.rows.length === 0) {
            return res.status(404).json({
                mensagem: 'Categoria não encontrada.'
            });
        }

        const resultado = await pool.query(
            `UPDATE produto p
             SET
                id_categoria = $1,
                nome = $2,
                foto = $3,
                descricao = $4,
                preco = $5
             FROM categoria c
             INNER JOIN loja l
                ON c.id_loja = l.id_loja
             WHERE p.id_produto = $6
               AND p.id_categoria = c.id_categoria
               AND l.id_usuario = $7
             RETURNING
                p.id_produto,
                p.id_categoria,
                p.nome,
                p.foto,
                p.descricao,
                p.preco,
                p.disponivel`,
            [
                id_categoria,
                nome,
                foto,
                descricao,
                preco,
                idProduto,
                req.usuario.id_usuario
            ]
        );

        if (resultado.rows.length === 0) {
            return res.status(404).json({
                mensagem: 'Produto não encontrado.'
            });
        }

        res.json({
            mensagem: 'Produto atualizado com sucesso!',
            produto: resultado.rows[0]
        });

    } catch (erro) {
        console.error(erro);

        res.status(500).json({
            mensagem: 'Erro ao atualizar produto.'
        });
    }
});
app.patch('/loja/produtos/:id/disponibilidade', autenticarToken, verificarPerfil(2), async (req, res) => {
    try {
        const idProduto = req.params.id;
        const { disponivel } = req.body;

        if (typeof disponivel !== 'boolean') {
            return res.status(400).json({
                mensagem: 'O campo disponivel deve ser true ou false.'
            });
        }

        const resultado = await pool.query(
            `UPDATE produto p
             SET disponivel = $1
             FROM categoria c
             INNER JOIN loja l
                ON c.id_loja = l.id_loja
             WHERE p.id_produto = $2
               AND p.id_categoria = c.id_categoria
               AND l.id_usuario = $3
             RETURNING
                p.id_produto,
                p.nome,
                p.disponivel`,
            [disponivel, idProduto, req.usuario.id_usuario]
        );

        if (resultado.rows.length === 0) {
            return res.status(404).json({
                mensagem: 'Produto não encontrado.'
            });
        }

        res.json({
            mensagem: 'Disponibilidade do produto atualizada com sucesso!',
            produto: resultado.rows[0]
        });

    } catch (erro) {
        console.error(erro);

        res.status(500).json({
            mensagem: 'Erro ao atualizar disponibilidade do produto.'
        });
    }
});
app.post('/loja/produtos/:id/grupos-complemento', autenticarToken, verificarPerfil(2), async (req, res) => {
    try {
        const idProduto = req.params.id;
        const {
            nome,
            minimo_escolhas,
            maximo_escolhas
        } = req.body;

        if (!nome || minimo_escolhas === undefined || maximo_escolhas === undefined) {
            return res.status(400).json({
                mensagem: 'Nome, mínimo e máximo de escolhas são obrigatórios.'
            });
        }

        if (minimo_escolhas < 0 || maximo_escolhas < minimo_escolhas) {
            return res.status(400).json({
                mensagem: 'Os limites de escolhas são inválidos.'
            });
        }

        const produto = await pool.query(
            `SELECT p.id_produto
             FROM produto p
             INNER JOIN categoria c
                ON p.id_categoria = c.id_categoria
             INNER JOIN loja l
                ON c.id_loja = l.id_loja
             WHERE p.id_produto = $1
               AND l.id_usuario = $2`,
            [idProduto, req.usuario.id_usuario]
        );

        if (produto.rows.length === 0) {
            return res.status(404).json({
                mensagem: 'Produto não encontrado.'
            });
        }

        const resultado = await pool.query(
            `INSERT INTO grupo_complemento
                (id_produto, nome, minimo_escolhas, maximo_escolhas)
             VALUES ($1, $2, $3, $4)
             RETURNING
                id_grupo,
                id_produto,
                nome,
                minimo_escolhas,
                maximo_escolhas`,
            [idProduto, nome, minimo_escolhas, maximo_escolhas]
        );

        res.status(201).json({
            mensagem: 'Grupo de complementos cadastrado com sucesso!',
            grupo: resultado.rows[0]
        });

    } catch (erro) {
        console.error(erro);

        res.status(500).json({
            mensagem: 'Erro ao cadastrar grupo de complementos.'
        });
    }
});
app.get('/loja/produtos/:id/grupos-complemento', autenticarToken, verificarPerfil(2), async (req, res) => {
    try {
        const idProduto = req.params.id;

        const resultado = await pool.query(
            `SELECT
                g.id_grupo,
                g.id_produto,
                g.nome,
                g.minimo_escolhas,
                g.maximo_escolhas
             FROM grupo_complemento g
             INNER JOIN produto p
                ON g.id_produto = p.id_produto
             INNER JOIN categoria c
                ON p.id_categoria = c.id_categoria
             INNER JOIN loja l
                ON c.id_loja = l.id_loja
             WHERE g.id_produto = $1
               AND l.id_usuario = $2
             ORDER BY g.nome`,
            [idProduto, req.usuario.id_usuario]
        );

        res.json(resultado.rows);

    } catch (erro) {
        console.error(erro);

        res.status(500).json({
            mensagem: 'Erro ao buscar grupos de complementos.'
        });
    }
});
app.post('/loja/grupos-complemento/:id/complementos', autenticarToken, verificarPerfil(2), async (req, res) => {
    try {
        const idGrupo = req.params.id;
        const { nome, preco } = req.body;

        if (!nome || preco === undefined) {
            return res.status(400).json({
                mensagem: 'Nome e preço são obrigatórios.'
            });
        }

        if (preco < 0) {
            return res.status(400).json({
                mensagem: 'O preço não pode ser negativo.'
            });
        }

        const grupo = await pool.query(
            `SELECT g.id_grupo
             FROM grupo_complemento g
             INNER JOIN produto p
                ON g.id_produto = p.id_produto
             INNER JOIN categoria c
                ON p.id_categoria = c.id_categoria
             INNER JOIN loja l
                ON c.id_loja = l.id_loja
             WHERE g.id_grupo = $1
               AND l.id_usuario = $2`,
            [idGrupo, req.usuario.id_usuario]
        );

        if (grupo.rows.length === 0) {
            return res.status(404).json({
                mensagem: 'Grupo de complementos não encontrado.'
            });
        }

        const resultado = await pool.query(
            `INSERT INTO complemento
                (id_grupo, nome, preco)
             VALUES ($1, $2, $3)
             RETURNING
                id_complemento,
                id_grupo,
                nome,
                preco`,
            [idGrupo, nome, preco]
        );

        res.status(201).json({
            mensagem: 'Complemento cadastrado com sucesso!',
            complemento: resultado.rows[0]
        });

    } catch (erro) {
        console.error(erro);

        res.status(500).json({
            mensagem: 'Erro ao cadastrar complemento.'
        });
    }
});
app.get('/loja/grupos-complemento/:id/complementos', autenticarToken, verificarPerfil(2), async (req, res) => {
    try {
        const idGrupo = req.params.id;

        const resultado = await pool.query(
            `SELECT
                c.id_complemento,
                c.id_grupo,
                c.nome,
                c.preco
             FROM complemento c
             INNER JOIN grupo_complemento g
                ON c.id_grupo = g.id_grupo
             INNER JOIN produto p
                ON g.id_produto = p.id_produto
             INNER JOIN categoria cat
                ON p.id_categoria = cat.id_categoria
             INNER JOIN loja l
                ON cat.id_loja = l.id_loja
             WHERE c.id_grupo = $1
               AND l.id_usuario = $2
             ORDER BY c.nome`,
            [idGrupo, req.usuario.id_usuario]
        );

        res.json(resultado.rows);

    } catch (erro) {
        console.error(erro);

        res.status(500).json({
            mensagem: 'Erro ao buscar complementos.'
        });
    }
});
app.put('/loja/grupos-complemento/:id', autenticarToken, verificarPerfil(2), async (req, res) => {
    try {
        const idGrupo = req.params.id;
        const {
            nome,
            minimo_escolhas,
            maximo_escolhas
        } = req.body;

        if (!nome || minimo_escolhas === undefined || maximo_escolhas === undefined) {
            return res.status(400).json({
                mensagem: 'Nome, mínimo e máximo de escolhas são obrigatórios.'
            });
        }

        if (minimo_escolhas < 0 || maximo_escolhas < minimo_escolhas) {
            return res.status(400).json({
                mensagem: 'Os limites de escolhas são inválidos.'
            });
        }

        const resultado = await pool.query(
            `UPDATE grupo_complemento g
             SET
                nome = $1,
                minimo_escolhas = $2,
                maximo_escolhas = $3
             FROM produto p
             INNER JOIN categoria c
                ON p.id_categoria = c.id_categoria
             INNER JOIN loja l
                ON c.id_loja = l.id_loja
             WHERE g.id_grupo = $4
               AND g.id_produto = p.id_produto
               AND l.id_usuario = $5
             RETURNING
                g.id_grupo,
                g.id_produto,
                g.nome,
                g.minimo_escolhas,
                g.maximo_escolhas`,
            [
                nome,
                minimo_escolhas,
                maximo_escolhas,
                idGrupo,
                req.usuario.id_usuario
            ]
        );

        if (resultado.rows.length === 0) {
            return res.status(404).json({
                mensagem: 'Grupo de complementos não encontrado.'
            });
        }

        res.json({
            mensagem: 'Grupo de complementos atualizado com sucesso!',
            grupo: resultado.rows[0]
        });

    } catch (erro) {
        console.error(erro);

        res.status(500).json({
            mensagem: 'Erro ao atualizar grupo de complementos.'
        });
    }
});
app.delete('/loja/grupos-complemento/:id', autenticarToken, verificarPerfil(2), async (req, res) => {
    try {
        const idGrupo = req.params.id;

        const resultado = await pool.query(
            `DELETE FROM grupo_complemento g
             USING produto p, categoria c, loja l
             WHERE g.id_grupo = $1
               AND g.id_produto = p.id_produto
               AND p.id_categoria = c.id_categoria
               AND c.id_loja = l.id_loja
               AND l.id_usuario = $2
             RETURNING g.id_grupo`,
            [idGrupo, req.usuario.id_usuario]
        );

        if (resultado.rows.length === 0) {
            return res.status(404).json({
                mensagem: 'Grupo de complementos não encontrado.'
            });
        }

        res.json({
            mensagem: 'Grupo de complementos excluído com sucesso!'
        });

    } catch (erro) {
        console.error(erro);

        if (erro.code === '23503') {
            return res.status(409).json({
                mensagem: 'Não é possível excluir o grupo porque existem complementos vinculados a ele.'
            });
        }

        res.status(500).json({
            mensagem: 'Erro ao excluir grupo de complementos.'
        });
    }
});
app.put('/loja/complementos/:id', autenticarToken, verificarPerfil(2), async (req, res) => {
    try {
        const idComplemento = req.params.id;
        const { nome, preco } = req.body;

        if (!nome || preco === undefined) {
            return res.status(400).json({
                mensagem: 'Nome e preço são obrigatórios.'
            });
        }

        if (preco < 0) {
            return res.status(400).json({
                mensagem: 'O preço não pode ser negativo.'
            });
        }

        const resultado = await pool.query(
            `UPDATE complemento c
             SET
                nome = $1,
                preco = $2
             FROM grupo_complemento g
             INNER JOIN produto p
                ON g.id_produto = p.id_produto
             INNER JOIN categoria cat
                ON p.id_categoria = cat.id_categoria
             INNER JOIN loja l
                ON cat.id_loja = l.id_loja
             WHERE c.id_complemento = $3
               AND c.id_grupo = g.id_grupo
               AND l.id_usuario = $4
             RETURNING
                c.id_complemento,
                c.id_grupo,
                c.nome,
                c.preco`,
            [
                nome,
                preco,
                idComplemento,
                req.usuario.id_usuario
            ]
        );

        if (resultado.rows.length === 0) {
            return res.status(404).json({
                mensagem: 'Complemento não encontrado.'
            });
        }

        res.json({
            mensagem: 'Complemento atualizado com sucesso!',
            complemento: resultado.rows[0]
        });

    } catch (erro) {
        console.error(erro);

        res.status(500).json({
            mensagem: 'Erro ao atualizar complemento.'
        });
    }
});
app.delete('/loja/complementos/:id', autenticarToken, verificarPerfil(2), async (req, res) => {
    try {
        const idComplemento = req.params.id;

        const resultado = await pool.query(
            `DELETE FROM complemento c
             USING grupo_complemento g, produto p, categoria cat, loja l
             WHERE c.id_complemento = $1
               AND c.id_grupo = g.id_grupo
               AND g.id_produto = p.id_produto
               AND p.id_categoria = cat.id_categoria
               AND cat.id_loja = l.id_loja
               AND l.id_usuario = $2
             RETURNING c.id_complemento`,
            [idComplemento, req.usuario.id_usuario]
        );

        if (resultado.rows.length === 0) {
            return res.status(404).json({
                mensagem: 'Complemento não encontrado.'
            });
        }

        res.json({
            mensagem: 'Complemento excluído com sucesso!'
        });

    } catch (erro) {
        console.error(erro);

        res.status(500).json({
            mensagem: 'Erro ao excluir complemento.'
        });
    }
});
app.get('/lojas/:id_loja/cardapio', async (req, res) => {
    try {
        const idLoja = req.params.id_loja;

        const resultado = await pool.query(
            `SELECT
                cat.id_categoria,
                cat.nome AS categoria,

                p.id_produto,
                p.nome AS produto,
                p.foto,
                p.descricao,
                p.preco,

                g.id_grupo,
                g.nome AS grupo_complemento,
                g.minimo_escolhas,
                g.maximo_escolhas,

                c.id_complemento,
                c.nome AS complemento,
                c.preco AS preco_complemento

             FROM categoria cat

             INNER JOIN loja l
                ON cat.id_loja = l.id_loja

             INNER JOIN produto p
                ON cat.id_categoria = p.id_categoria

             LEFT JOIN grupo_complemento g
                ON p.id_produto = g.id_produto

             LEFT JOIN complemento c
                ON g.id_grupo = c.id_grupo

             WHERE l.id_loja = $1
               AND p.disponivel = TRUE

             ORDER BY
                cat.nome,
                p.nome,
                g.nome,
                c.nome`,
            [idLoja]
        );

        res.json(resultado.rows);

    } catch (erro) {
        console.error(erro);

        res.status(500).json({
            mensagem: 'Erro ao buscar cardápio.'
        });
    }
});
app.get('/cliente', autenticarToken, verificarPerfil(3), (req, res) => {
    res.json({
        mensagem: 'Acesso autorizado! Você é cliente.'
    });
});

app.get('/entregador', autenticarToken, verificarPerfil(4), (req, res) => {
    res.json({
        mensagem: 'Acesso autorizado! Você é entregador.'
    });
});

const PORT = 3000;

app.listen(PORT, () => {
    console.log(`Servidor rodando em http://localhost:${PORT}`);
});