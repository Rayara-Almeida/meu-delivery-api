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