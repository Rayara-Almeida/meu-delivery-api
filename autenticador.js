const jwt = require('jsonwebtoken');

const JWT_SECRET = 'chave-secreta-meu-delivery';

function autenticarToken(req, res, next) {
    const autorizacao = req.headers.authorization;

    if (!autorizacao) {
        return res.status(401).json({
            mensagem: 'Token não informado.'
        });
    }

    const partes = autorizacao.split(' ');

    if (partes.length !== 2 || partes[0] !== 'Bearer') {
        return res.status(401).json({
            mensagem: 'Formato do token inválido.'
        });
    }

    const token = partes[1];

    try {
        const usuario = jwt.verify(token, JWT_SECRET);

        req.usuario = usuario;

        next();

    } catch (erro) {
        return res.status(401).json({
            mensagem: 'Token inválido ou expirado.'
        });
    }
}

module.exports = autenticarToken;