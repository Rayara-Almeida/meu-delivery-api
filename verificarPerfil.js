function verificarPerfil(...perfisPermitidos) {
    return (req, res, next) => {

        if (!req.usuario) {
            return res.status(401).json({
                mensagem: 'Usuário não autenticado.'
            });
        }

        if (!perfisPermitidos.includes(req.usuario.id_perfil)) {
            return res.status(403).json({
                mensagem: 'Acesso negado. Você não possui permissão para esta área.'
            });
        }

        next();
    };
}

module.exports = verificarPerfil;