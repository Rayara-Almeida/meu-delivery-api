# Meu Delivery API

API do sistema Meu Delivery, desenvolvida para integração entre o sistema Web, aplicativo Mobile e banco de dados.

## Tecnologias utilizadas

- Node.js
- Express
- PostgreSQL
- pg
- bcrypt
- JSON Web Token (JWT)
- dotenv

## Pré-requisitos

Antes de executar o projeto, é necessário ter instalado:

- Node.js
- PostgreSQL
- Git

## Como executar o projeto

### 1. Clonar o repositório

```bash
git clone https://github.com/Rayara-Almeida/meu-delivery-api.git
cd meu-delivery-api
2. Instalar as dependências
npm install
3. Configurar o banco de dados

Crie um banco de dados PostgreSQL.

Depois, execute o arquivo:

MeuDeliveryDB.sql

Esse arquivo contém a estrutura do banco de dados utilizada pela API.

4. Configurar o arquivo .env

Na raiz do projeto, crie um arquivo chamado .env com as configurações do seu PostgreSQL:

DB_USER=postgres
DB_HOST=localhost
DB_DATABASE=nome_do_banco
DB_PASSWORD=sua_senha_do_postgres
DB_PORT=5432

O arquivo .env não deve ser enviado para o GitHub, pois contém informações de acesso ao banco de dados.

5. Executar a API

No terminal, dentro da pasta do projeto:

node server.js

Se estiver tudo correto, será exibida a mensagem:

Servidor rodando em http://localhost:3000
Rotas principais
Método	Rota	Descrição
GET	/	Verifica se a API está funcionando e conectada ao banco
POST	/clientes	Cadastra um novo cliente
POST	/login	Realiza o login
GET	/perfil	Retorna os dados do usuário autenticado
GET	/cliente	Verifica acesso do perfil cliente
GET	/loja/status	Verifica o status de funcionamento da loja
Perfis de usuário
ID	Perfil
1	Administrador
2	Loja
3	Cliente
4	Entregador
Segurança

A API utiliza:

bcrypt para criptografar as senhas;
JWT para autenticação dos usuários;
dotenv para proteger as credenciais do banco de dados;
.gitignore para impedir o envio do arquivo .env ao GitHub.
Estrutura do projeto
meu-delivery-api/
├── node_modules/
├── .env
├── .gitignore
├── autenticador.js
├── database.js
├── MeuDeliveryDB.sql
├── package-lock.json
├── package.json
├── README.md
├── server.js
└── verificarPerfil.js
Integração com o aplicativo Mobile

O aplicativo Mobile utiliza esta API para realizar operações como:

cadastro de clientes;
login;
autenticação;
consulta de perfil;
consulta do status da loja.

A API é responsável pelas regras de negócio e pelo acesso ao banco de dados.
