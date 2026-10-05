--
-- PostgreSQL database dump
--

\restrict dCic6x9E5a9Cb2JeTpVOMIY0ltjyMlE9vKeo1dA6Ed7LO59IDBw9OjpquBQe8hj

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

-- Started on 2026-10-05 10:18:54

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 232 (class 1259 OID 17899)
-- Name: categoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categoria (
    id_categoria integer NOT NULL,
    id_loja integer NOT NULL,
    nome character varying(100) NOT NULL
);


ALTER TABLE public.categoria OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 17898)
-- Name: categoria_id_categoria_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categoria_id_categoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categoria_id_categoria_seq OWNER TO postgres;

--
-- TOC entry 5200 (class 0 OID 0)
-- Dependencies: 231
-- Name: categoria_id_categoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categoria_id_categoria_seq OWNED BY public.categoria.id_categoria;


--
-- TOC entry 238 (class 1259 OID 17954)
-- Name: complemento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.complemento (
    id_complemento integer NOT NULL,
    id_grupo integer NOT NULL,
    nome character varying(100) NOT NULL,
    preco numeric(10,2) DEFAULT 0.00 NOT NULL,
    CONSTRAINT chk_preco_complemento CHECK ((preco >= (0)::numeric))
);


ALTER TABLE public.complemento OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 17953)
-- Name: complemento_id_complemento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.complemento_id_complemento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.complemento_id_complemento_seq OWNER TO postgres;

--
-- TOC entry 5201 (class 0 OID 0)
-- Dependencies: 237
-- Name: complemento_id_complemento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.complemento_id_complemento_seq OWNED BY public.complemento.id_complemento;


--
-- TOC entry 240 (class 1259 OID 17972)
-- Name: endereco; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.endereco (
    id_endereco integer NOT NULL,
    id_usuario integer NOT NULL,
    rua character varying(150) NOT NULL,
    numero character varying(20) NOT NULL,
    complemento character varying(150),
    bairro character varying(100) NOT NULL,
    cidade character varying(100) NOT NULL,
    ponto_referencia character varying(200),
    favorito boolean DEFAULT false NOT NULL,
    ativo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.endereco OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 17971)
-- Name: endereco_id_endereco_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.endereco_id_endereco_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.endereco_id_endereco_seq OWNER TO postgres;

--
-- TOC entry 5202 (class 0 OID 0)
-- Dependencies: 239
-- Name: endereco_id_endereco_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.endereco_id_endereco_seq OWNED BY public.endereco.id_endereco;


--
-- TOC entry 242 (class 1259 OID 17997)
-- Name: endereco_loja; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.endereco_loja (
    id_endereco_loja integer NOT NULL,
    id_endereco integer NOT NULL,
    id_loja integer NOT NULL,
    distancia_km numeric(5,2) NOT NULL,
    CONSTRAINT chk_distancia_km CHECK ((distancia_km >= (0)::numeric))
);


ALTER TABLE public.endereco_loja OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 17996)
-- Name: endereco_loja_id_endereco_loja_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.endereco_loja_id_endereco_loja_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.endereco_loja_id_endereco_loja_seq OWNER TO postgres;

--
-- TOC entry 5203 (class 0 OID 0)
-- Dependencies: 241
-- Name: endereco_loja_id_endereco_loja_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.endereco_loja_id_endereco_loja_seq OWNED BY public.endereco_loja.id_endereco_loja;


--
-- TOC entry 230 (class 1259 OID 17883)
-- Name: faixa_entrega; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.faixa_entrega (
    id_faixa integer NOT NULL,
    id_loja integer NOT NULL,
    distancia_maxima_km numeric(5,2) NOT NULL,
    taxa numeric(10,2) NOT NULL
);


ALTER TABLE public.faixa_entrega OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17882)
-- Name: faixa_entrega_id_faixa_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.faixa_entrega_id_faixa_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.faixa_entrega_id_faixa_seq OWNER TO postgres;

--
-- TOC entry 5204 (class 0 OID 0)
-- Dependencies: 229
-- Name: faixa_entrega_id_faixa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.faixa_entrega_id_faixa_seq OWNED BY public.faixa_entrega.id_faixa;


--
-- TOC entry 228 (class 1259 OID 17867)
-- Name: forma_pagamento_loja; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.forma_pagamento_loja (
    id_forma_pagamento integer NOT NULL,
    id_loja integer NOT NULL,
    forma_pagamento character varying(30) NOT NULL,
    CONSTRAINT chk_forma_pagamento CHECK (((forma_pagamento)::text = ANY ((ARRAY['dinheiro'::character varying, 'pix'::character varying, 'cartao_credito'::character varying, 'cartao_debito'::character varying])::text[])))
);


ALTER TABLE public.forma_pagamento_loja OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17866)
-- Name: forma_pagamento_loja_id_forma_pagamento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.forma_pagamento_loja_id_forma_pagamento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.forma_pagamento_loja_id_forma_pagamento_seq OWNER TO postgres;

--
-- TOC entry 5205 (class 0 OID 0)
-- Dependencies: 227
-- Name: forma_pagamento_loja_id_forma_pagamento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.forma_pagamento_loja_id_forma_pagamento_seq OWNED BY public.forma_pagamento_loja.id_forma_pagamento;


--
-- TOC entry 236 (class 1259 OID 17934)
-- Name: grupo_complemento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grupo_complemento (
    id_grupo integer NOT NULL,
    id_produto integer NOT NULL,
    nome character varying(100) NOT NULL,
    minimo_escolhas integer DEFAULT 0 NOT NULL,
    maximo_escolhas integer NOT NULL,
    CONSTRAINT chk_maximo_escolhas CHECK ((maximo_escolhas >= minimo_escolhas)),
    CONSTRAINT chk_minimo_escolhas CHECK ((minimo_escolhas >= 0))
);


ALTER TABLE public.grupo_complemento OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 17933)
-- Name: grupo_complemento_id_grupo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.grupo_complemento_id_grupo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.grupo_complemento_id_grupo_seq OWNER TO postgres;

--
-- TOC entry 5206 (class 0 OID 0)
-- Dependencies: 235
-- Name: grupo_complemento_id_grupo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.grupo_complemento_id_grupo_seq OWNED BY public.grupo_complemento.id_grupo;


--
-- TOC entry 226 (class 1259 OID 17849)
-- Name: horario_funcionamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.horario_funcionamento (
    id_horario integer NOT NULL,
    id_loja integer NOT NULL,
    dia_semana character varying(15) NOT NULL,
    hora_abertura time without time zone NOT NULL,
    hora_fechamento time without time zone NOT NULL,
    CONSTRAINT chk_dia_semana CHECK (((dia_semana)::text = ANY ((ARRAY['segunda'::character varying, 'terça'::character varying, 'quarta'::character varying, 'quinta'::character varying, 'sexta'::character varying, 'sábado'::character varying, 'domingo'::character varying])::text[])))
);


ALTER TABLE public.horario_funcionamento OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17848)
-- Name: horario_funcionamento_id_horario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.horario_funcionamento_id_horario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.horario_funcionamento_id_horario_seq OWNER TO postgres;

--
-- TOC entry 5207 (class 0 OID 0)
-- Dependencies: 225
-- Name: horario_funcionamento_id_horario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.horario_funcionamento_id_horario_seq OWNED BY public.horario_funcionamento.id_horario;


--
-- TOC entry 224 (class 1259 OID 17826)
-- Name: loja; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.loja (
    id_loja integer NOT NULL,
    id_usuario integer NOT NULL,
    nome character varying(100) NOT NULL,
    foto character varying(500),
    categoria character varying(30) NOT NULL,
    endereco character varying(200) NOT NULL,
    telefone character varying(20) NOT NULL,
    aberta boolean DEFAULT false NOT NULL,
    tempo_estimado integer,
    taxa numeric(10,2),
    CONSTRAINT chk_categoria CHECK (((categoria)::text = ANY ((ARRAY['lanches'::character varying, 'pizzaria'::character varying, 'açaí'::character varying, 'mercado'::character varying])::text[])))
);


ALTER TABLE public.loja OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17825)
-- Name: loja_id_loja_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.loja_id_loja_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.loja_id_loja_seq OWNER TO postgres;

--
-- TOC entry 5208 (class 0 OID 0)
-- Dependencies: 223
-- Name: loja_id_loja_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.loja_id_loja_seq OWNED BY public.loja.id_loja;


--
-- TOC entry 244 (class 1259 OID 18021)
-- Name: pedido; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pedido (
    id_pedido integer NOT NULL,
    id_usuario integer NOT NULL,
    id_loja integer NOT NULL,
    id_endereco integer NOT NULL,
    rua character varying(150) NOT NULL,
    numero character varying(20) NOT NULL,
    complemento character varying(150),
    bairro character varying(100) NOT NULL,
    cidade character varying(100) NOT NULL,
    ponto_referencia character varying(200),
    status character varying(30) DEFAULT 'aguardando_confirmacao'::character varying NOT NULL,
    subtotal numeric(10,2) NOT NULL,
    taxa_entrega numeric(10,2) NOT NULL,
    total numeric(10,2) NOT NULL,
    forma_pagamento character varying(30) NOT NULL,
    troco numeric(10,2),
    CONSTRAINT chk_forma_pagamento CHECK (((forma_pagamento)::text = ANY ((ARRAY['dinheiro'::character varying, 'cartao_entrega'::character varying, 'pix'::character varying])::text[]))),
    CONSTRAINT chk_pedido_status CHECK (((status)::text = ANY ((ARRAY['aguardando_confirmacao'::character varying, 'confirmado'::character varying, 'cancelado'::character varying, 'em_preparo'::character varying, 'saiu_para_entrega'::character varying, 'entregue'::character varying])::text[]))),
    CONSTRAINT chk_troco CHECK (((troco IS NULL) OR (troco >= (0)::numeric))),
    CONSTRAINT chk_valores_pedido CHECK (((subtotal >= (0)::numeric) AND (taxa_entrega >= (0)::numeric) AND (total >= (0)::numeric)))
);


ALTER TABLE public.pedido OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 18020)
-- Name: pedido_id_pedido_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pedido_id_pedido_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pedido_id_pedido_seq OWNER TO postgres;

--
-- TOC entry 5209 (class 0 OID 0)
-- Dependencies: 243
-- Name: pedido_id_pedido_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pedido_id_pedido_seq OWNED BY public.pedido.id_pedido;


--
-- TOC entry 246 (class 1259 OID 18063)
-- Name: pedido_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pedido_item (
    id_pedido_item integer NOT NULL,
    id_pedido integer NOT NULL,
    id_produto integer NOT NULL,
    nome_produto character varying(100) NOT NULL,
    preco_unitario numeric(10,2) NOT NULL,
    quantidade integer NOT NULL,
    observacao text,
    subtotal numeric(10,2) NOT NULL,
    CONSTRAINT chk_preco_pedido_item CHECK ((preco_unitario >= (0)::numeric)),
    CONSTRAINT chk_quantidade_pedido_item CHECK ((quantidade > 0)),
    CONSTRAINT chk_subtotal_pedido_item CHECK ((subtotal >= (0)::numeric))
);


ALTER TABLE public.pedido_item OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 18092)
-- Name: pedido_item_complemento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pedido_item_complemento (
    id_pedido_item_complemento integer NOT NULL,
    id_pedido_item integer NOT NULL,
    id_complemento integer NOT NULL,
    nome_complemento character varying(100) NOT NULL,
    preco numeric(10,2) NOT NULL,
    CONSTRAINT chk_preco_pedido_complemento CHECK ((preco >= (0)::numeric))
);


ALTER TABLE public.pedido_item_complemento OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 18091)
-- Name: pedido_item_complemento_id_pedido_item_complemento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pedido_item_complemento_id_pedido_item_complemento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pedido_item_complemento_id_pedido_item_complemento_seq OWNER TO postgres;

--
-- TOC entry 5210 (class 0 OID 0)
-- Dependencies: 247
-- Name: pedido_item_complemento_id_pedido_item_complemento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pedido_item_complemento_id_pedido_item_complemento_seq OWNED BY public.pedido_item_complemento.id_pedido_item_complemento;


--
-- TOC entry 245 (class 1259 OID 18062)
-- Name: pedido_item_id_pedido_item_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pedido_item_id_pedido_item_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pedido_item_id_pedido_item_seq OWNER TO postgres;

--
-- TOC entry 5211 (class 0 OID 0)
-- Dependencies: 245
-- Name: pedido_item_id_pedido_item_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pedido_item_id_pedido_item_seq OWNED BY public.pedido_item.id_pedido_item;


--
-- TOC entry 220 (class 1259 OID 17795)
-- Name: perfil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.perfil (
    id_perfil integer NOT NULL,
    nome character varying(30) NOT NULL
);


ALTER TABLE public.perfil OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17794)
-- Name: perfil_id_perfil_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.perfil_id_perfil_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.perfil_id_perfil_seq OWNER TO postgres;

--
-- TOC entry 5212 (class 0 OID 0)
-- Dependencies: 219
-- Name: perfil_id_perfil_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.perfil_id_perfil_seq OWNED BY public.perfil.id_perfil;


--
-- TOC entry 234 (class 1259 OID 17914)
-- Name: produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produto (
    id_produto integer NOT NULL,
    id_categoria integer NOT NULL,
    nome character varying(100) NOT NULL,
    foto character varying(500),
    descricao text,
    preco numeric(10,2) NOT NULL,
    disponivel boolean DEFAULT true NOT NULL
);


ALTER TABLE public.produto OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 17913)
-- Name: produto_id_produto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.produto_id_produto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.produto_id_produto_seq OWNER TO postgres;

--
-- TOC entry 5213 (class 0 OID 0)
-- Dependencies: 233
-- Name: produto_id_produto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.produto_id_produto_seq OWNED BY public.produto.id_produto;


--
-- TOC entry 222 (class 1259 OID 17806)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    id_usuario integer NOT NULL,
    nome character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    telefone character varying(11) NOT NULL,
    senha character varying(100) NOT NULL,
    id_perfil integer NOT NULL
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17805)
-- Name: usuario_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuario_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuario_id_usuario_seq OWNER TO postgres;

--
-- TOC entry 5214 (class 0 OID 0)
-- Dependencies: 221
-- Name: usuario_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_id_usuario_seq OWNED BY public.usuario.id_usuario;


--
-- TOC entry 4933 (class 2604 OID 17902)
-- Name: categoria id_categoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria ALTER COLUMN id_categoria SET DEFAULT nextval('public.categoria_id_categoria_seq'::regclass);


--
-- TOC entry 4938 (class 2604 OID 17957)
-- Name: complemento id_complemento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.complemento ALTER COLUMN id_complemento SET DEFAULT nextval('public.complemento_id_complemento_seq'::regclass);


--
-- TOC entry 4940 (class 2604 OID 17975)
-- Name: endereco id_endereco; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endereco ALTER COLUMN id_endereco SET DEFAULT nextval('public.endereco_id_endereco_seq'::regclass);


--
-- TOC entry 4943 (class 2604 OID 18000)
-- Name: endereco_loja id_endereco_loja; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endereco_loja ALTER COLUMN id_endereco_loja SET DEFAULT nextval('public.endereco_loja_id_endereco_loja_seq'::regclass);


--
-- TOC entry 4932 (class 2604 OID 17886)
-- Name: faixa_entrega id_faixa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faixa_entrega ALTER COLUMN id_faixa SET DEFAULT nextval('public.faixa_entrega_id_faixa_seq'::regclass);


--
-- TOC entry 4931 (class 2604 OID 17870)
-- Name: forma_pagamento_loja id_forma_pagamento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forma_pagamento_loja ALTER COLUMN id_forma_pagamento SET DEFAULT nextval('public.forma_pagamento_loja_id_forma_pagamento_seq'::regclass);


--
-- TOC entry 4936 (class 2604 OID 17937)
-- Name: grupo_complemento id_grupo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grupo_complemento ALTER COLUMN id_grupo SET DEFAULT nextval('public.grupo_complemento_id_grupo_seq'::regclass);


--
-- TOC entry 4930 (class 2604 OID 17852)
-- Name: horario_funcionamento id_horario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.horario_funcionamento ALTER COLUMN id_horario SET DEFAULT nextval('public.horario_funcionamento_id_horario_seq'::regclass);


--
-- TOC entry 4928 (class 2604 OID 17829)
-- Name: loja id_loja; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loja ALTER COLUMN id_loja SET DEFAULT nextval('public.loja_id_loja_seq'::regclass);


--
-- TOC entry 4944 (class 2604 OID 18024)
-- Name: pedido id_pedido; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido ALTER COLUMN id_pedido SET DEFAULT nextval('public.pedido_id_pedido_seq'::regclass);


--
-- TOC entry 4946 (class 2604 OID 18066)
-- Name: pedido_item id_pedido_item; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido_item ALTER COLUMN id_pedido_item SET DEFAULT nextval('public.pedido_item_id_pedido_item_seq'::regclass);


--
-- TOC entry 4947 (class 2604 OID 18095)
-- Name: pedido_item_complemento id_pedido_item_complemento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido_item_complemento ALTER COLUMN id_pedido_item_complemento SET DEFAULT nextval('public.pedido_item_complemento_id_pedido_item_complemento_seq'::regclass);


--
-- TOC entry 4926 (class 2604 OID 17798)
-- Name: perfil id_perfil; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil ALTER COLUMN id_perfil SET DEFAULT nextval('public.perfil_id_perfil_seq'::regclass);


--
-- TOC entry 4934 (class 2604 OID 17917)
-- Name: produto id_produto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto ALTER COLUMN id_produto SET DEFAULT nextval('public.produto_id_produto_seq'::regclass);


--
-- TOC entry 4927 (class 2604 OID 17809)
-- Name: usuario id_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuario_id_usuario_seq'::regclass);


--
-- TOC entry 5178 (class 0 OID 17899)
-- Dependencies: 232
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categoria (id_categoria, id_loja, nome) FROM stdin;
3	1	Lanches
\.


--
-- TOC entry 5184 (class 0 OID 17954)
-- Dependencies: 238
-- Data for Name: complemento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.complemento (id_complemento, id_grupo, nome, preco) FROM stdin;
\.


--
-- TOC entry 5186 (class 0 OID 17972)
-- Dependencies: 240
-- Data for Name: endereco; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.endereco (id_endereco, id_usuario, rua, numero, complemento, bairro, cidade, ponto_referencia, favorito, ativo) FROM stdin;
4	13	Rua Teste	100	\N	Centro	João Pessoa	Próximo à praça	f	t
\.


--
-- TOC entry 5188 (class 0 OID 17997)
-- Dependencies: 242
-- Data for Name: endereco_loja; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.endereco_loja (id_endereco_loja, id_endereco, id_loja, distancia_km) FROM stdin;
1	4	1	2.00
\.


--
-- TOC entry 5176 (class 0 OID 17883)
-- Dependencies: 230
-- Data for Name: faixa_entrega; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.faixa_entrega (id_faixa, id_loja, distancia_maxima_km, taxa) FROM stdin;
5	1	3.00	5.00
6	1	5.00	8.00
7	1	8.00	12.00
\.


--
-- TOC entry 5174 (class 0 OID 17867)
-- Dependencies: 228
-- Data for Name: forma_pagamento_loja; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.forma_pagamento_loja (id_forma_pagamento, id_loja, forma_pagamento) FROM stdin;
\.


--
-- TOC entry 5182 (class 0 OID 17934)
-- Dependencies: 236
-- Data for Name: grupo_complemento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.grupo_complemento (id_grupo, id_produto, nome, minimo_escolhas, maximo_escolhas) FROM stdin;
\.


--
-- TOC entry 5172 (class 0 OID 17849)
-- Dependencies: 226
-- Data for Name: horario_funcionamento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.horario_funcionamento (id_horario, id_loja, dia_semana, hora_abertura, hora_fechamento) FROM stdin;
1	1	segunda	08:00:00	18:00:00
2	1	terça	08:00:00	18:00:00
3	1	quarta	08:00:00	18:00:00
4	1	quinta	08:00:00	18:00:00
5	1	sexta	08:00:00	18:00:00
6	1	domingo	00:00:00	23:59:00
\.


--
-- TOC entry 5170 (class 0 OID 17826)
-- Dependencies: 224
-- Data for Name: loja; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.loja (id_loja, id_usuario, nome, foto, categoria, endereco, telefone, aberta, tempo_estimado, taxa) FROM stdin;
1	5	Loja Teste	https://exemplo.com/foto-loja.jpg	lanches	Rua Principal, 100	87977777777	t	40	5.00
\.


--
-- TOC entry 5190 (class 0 OID 18021)
-- Dependencies: 244
-- Data for Name: pedido; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pedido (id_pedido, id_usuario, id_loja, id_endereco, rua, numero, complemento, bairro, cidade, ponto_referencia, status, subtotal, taxa_entrega, total, forma_pagamento, troco) FROM stdin;
1	13	1	4	Rua Teste	100	\N	Centro	João Pessoa	Próximo à praça	aguardando_confirmacao	20.00	5.00	25.00	pix	\N
\.


--
-- TOC entry 5192 (class 0 OID 18063)
-- Dependencies: 246
-- Data for Name: pedido_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pedido_item (id_pedido_item, id_pedido, id_produto, nome_produto, preco_unitario, quantidade, observacao, subtotal) FROM stdin;
1	1	5	X-Burger Teste	20.00	1	Teste do pedido	20.00
\.


--
-- TOC entry 5194 (class 0 OID 18092)
-- Dependencies: 248
-- Data for Name: pedido_item_complemento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pedido_item_complemento (id_pedido_item_complemento, id_pedido_item, id_complemento, nome_complemento, preco) FROM stdin;
\.


--
-- TOC entry 5166 (class 0 OID 17795)
-- Dependencies: 220
-- Data for Name: perfil; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.perfil (id_perfil, nome) FROM stdin;
1	Administrador
2	Loja
3	Cliente
4	Entregador
\.


--
-- TOC entry 5180 (class 0 OID 17914)
-- Dependencies: 234
-- Data for Name: produto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produto (id_produto, id_categoria, nome, foto, descricao, preco, disponivel) FROM stdin;
5	3	X-Burger Teste	\N	Produto para teste do pedido	20.00	t
\.


--
-- TOC entry 5168 (class 0 OID 17806)
-- Dependencies: 222
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario (id_usuario, nome, email, telefone, senha, id_perfil) FROM stdin;
3	Maria Teste	maria.teste@email.com	87999999999	$2b$10$59BQF.aKDNhJsuH0nX2S8./TjtRjS/5EewqB00F82ngY73Vfz/8s6	3
4	Admin Teste	admin.teste@email.com	87988888888	$2b$10$H.73BTYh/llw9emQ15tHUO8yQQ9pYtu44v4MKixKat/wBQJ.z2gH6	1
5	Loja Teste	loja.teste@email.com	87977777777	$2b$10$bYGkBXRkeCwk7poaWmKM9.JYI0b79vuhSUzkLP.LP5buQa3luOgCS	2
6	Entregador Teste	entregador.teste@email.com	87966666666	$2b$10$jWyHoBMzDpCNEnW36W20LuaHrLaLwVJfXtb40PtL52MJSkmo2M2K2	4
7	Cliente Teste	cliente.teste@email.com	87955555555	$2b$10$e59zZ8pJfoSNq0YFvmvRJOsUuWzeec9bXyxH0Sy.iFfVip9HUaYqO	3
13	Cliente W06	clientew06@gmail.com	87999999999	$2b$10$/CLpOW9WfXfnpE2iiFoNE.nnNkUu.5JaYWUfP.vOwRf0fJ.E/tKvC	3
\.


--
-- TOC entry 5215 (class 0 OID 0)
-- Dependencies: 231
-- Name: categoria_id_categoria_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categoria_id_categoria_seq', 3, true);


--
-- TOC entry 5216 (class 0 OID 0)
-- Dependencies: 237
-- Name: complemento_id_complemento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.complemento_id_complemento_seq', 4, true);


--
-- TOC entry 5217 (class 0 OID 0)
-- Dependencies: 239
-- Name: endereco_id_endereco_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.endereco_id_endereco_seq', 4, true);


--
-- TOC entry 5218 (class 0 OID 0)
-- Dependencies: 241
-- Name: endereco_loja_id_endereco_loja_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.endereco_loja_id_endereco_loja_seq', 1, true);


--
-- TOC entry 5219 (class 0 OID 0)
-- Dependencies: 229
-- Name: faixa_entrega_id_faixa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.faixa_entrega_id_faixa_seq', 7, true);


--
-- TOC entry 5220 (class 0 OID 0)
-- Dependencies: 227
-- Name: forma_pagamento_loja_id_forma_pagamento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.forma_pagamento_loja_id_forma_pagamento_seq', 1, false);


--
-- TOC entry 5221 (class 0 OID 0)
-- Dependencies: 235
-- Name: grupo_complemento_id_grupo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.grupo_complemento_id_grupo_seq', 3, true);


--
-- TOC entry 5222 (class 0 OID 0)
-- Dependencies: 225
-- Name: horario_funcionamento_id_horario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.horario_funcionamento_id_horario_seq', 6, true);


--
-- TOC entry 5223 (class 0 OID 0)
-- Dependencies: 223
-- Name: loja_id_loja_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.loja_id_loja_seq', 3, true);


--
-- TOC entry 5224 (class 0 OID 0)
-- Dependencies: 243
-- Name: pedido_id_pedido_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pedido_id_pedido_seq', 1, true);


--
-- TOC entry 5225 (class 0 OID 0)
-- Dependencies: 247
-- Name: pedido_item_complemento_id_pedido_item_complemento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pedido_item_complemento_id_pedido_item_complemento_seq', 1, false);


--
-- TOC entry 5226 (class 0 OID 0)
-- Dependencies: 245
-- Name: pedido_item_id_pedido_item_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pedido_item_id_pedido_item_seq', 1, true);


--
-- TOC entry 5227 (class 0 OID 0)
-- Dependencies: 219
-- Name: perfil_id_perfil_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.perfil_id_perfil_seq', 4, true);


--
-- TOC entry 5228 (class 0 OID 0)
-- Dependencies: 233
-- Name: produto_id_produto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produto_id_produto_seq', 5, true);


--
-- TOC entry 5229 (class 0 OID 0)
-- Dependencies: 221
-- Name: usuario_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_id_usuario_seq', 13, true);


--
-- TOC entry 4979 (class 2606 OID 17907)
-- Name: categoria categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (id_categoria);


--
-- TOC entry 4985 (class 2606 OID 17965)
-- Name: complemento complemento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.complemento
    ADD CONSTRAINT complemento_pkey PRIMARY KEY (id_complemento);


--
-- TOC entry 4990 (class 2606 OID 18007)
-- Name: endereco_loja endereco_loja_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endereco_loja
    ADD CONSTRAINT endereco_loja_pkey PRIMARY KEY (id_endereco_loja);


--
-- TOC entry 4987 (class 2606 OID 17989)
-- Name: endereco endereco_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endereco
    ADD CONSTRAINT endereco_pkey PRIMARY KEY (id_endereco);


--
-- TOC entry 4977 (class 2606 OID 17892)
-- Name: faixa_entrega faixa_entrega_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faixa_entrega
    ADD CONSTRAINT faixa_entrega_pkey PRIMARY KEY (id_faixa);


--
-- TOC entry 4975 (class 2606 OID 17876)
-- Name: forma_pagamento_loja forma_pagamento_loja_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forma_pagamento_loja
    ADD CONSTRAINT forma_pagamento_loja_pkey PRIMARY KEY (id_forma_pagamento);


--
-- TOC entry 4983 (class 2606 OID 17947)
-- Name: grupo_complemento grupo_complemento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grupo_complemento
    ADD CONSTRAINT grupo_complemento_pkey PRIMARY KEY (id_grupo);


--
-- TOC entry 4973 (class 2606 OID 17860)
-- Name: horario_funcionamento horario_funcionamento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.horario_funcionamento
    ADD CONSTRAINT horario_funcionamento_pkey PRIMARY KEY (id_horario);


--
-- TOC entry 4971 (class 2606 OID 17842)
-- Name: loja loja_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loja
    ADD CONSTRAINT loja_pkey PRIMARY KEY (id_loja);


--
-- TOC entry 4998 (class 2606 OID 18103)
-- Name: pedido_item_complemento pedido_item_complemento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido_item_complemento
    ADD CONSTRAINT pedido_item_complemento_pkey PRIMARY KEY (id_pedido_item_complemento);


--
-- TOC entry 4996 (class 2606 OID 18080)
-- Name: pedido_item pedido_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido_item
    ADD CONSTRAINT pedido_item_pkey PRIMARY KEY (id_pedido_item);


--
-- TOC entry 4994 (class 2606 OID 18046)
-- Name: pedido pedido_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_pkey PRIMARY KEY (id_pedido);


--
-- TOC entry 4964 (class 2606 OID 17804)
-- Name: perfil perfil_nome_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil
    ADD CONSTRAINT perfil_nome_key UNIQUE (nome);


--
-- TOC entry 4966 (class 2606 OID 17802)
-- Name: perfil perfil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil
    ADD CONSTRAINT perfil_pkey PRIMARY KEY (id_perfil);


--
-- TOC entry 4981 (class 2606 OID 17927)
-- Name: produto produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (id_produto);


--
-- TOC entry 4992 (class 2606 OID 18009)
-- Name: endereco_loja uq_endereco_loja; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endereco_loja
    ADD CONSTRAINT uq_endereco_loja UNIQUE (id_endereco, id_loja);


--
-- TOC entry 4969 (class 2606 OID 17817)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 4988 (class 1259 OID 17995)
-- Name: idx_endereco_favorito; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_endereco_favorito ON public.endereco USING btree (id_usuario) WHERE ((favorito = true) AND (ativo = true));


--
-- TOC entry 4967 (class 1259 OID 17823)
-- Name: uq_usuario_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX uq_usuario_email ON public.usuario USING btree (lower((email)::text));


--
-- TOC entry 5004 (class 2606 OID 17908)
-- Name: categoria fk_categoria_loja; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT fk_categoria_loja FOREIGN KEY (id_loja) REFERENCES public.loja(id_loja);


--
-- TOC entry 5007 (class 2606 OID 17966)
-- Name: complemento fk_complemento_grupo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.complemento
    ADD CONSTRAINT fk_complemento_grupo FOREIGN KEY (id_grupo) REFERENCES public.grupo_complemento(id_grupo);


--
-- TOC entry 5009 (class 2606 OID 18010)
-- Name: endereco_loja fk_endereco_loja_endereco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endereco_loja
    ADD CONSTRAINT fk_endereco_loja_endereco FOREIGN KEY (id_endereco) REFERENCES public.endereco(id_endereco);


--
-- TOC entry 5010 (class 2606 OID 18015)
-- Name: endereco_loja fk_endereco_loja_loja; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endereco_loja
    ADD CONSTRAINT fk_endereco_loja_loja FOREIGN KEY (id_loja) REFERENCES public.loja(id_loja);


--
-- TOC entry 5008 (class 2606 OID 17990)
-- Name: endereco fk_endereco_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endereco
    ADD CONSTRAINT fk_endereco_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 5003 (class 2606 OID 17893)
-- Name: faixa_entrega fk_faixa_loja; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faixa_entrega
    ADD CONSTRAINT fk_faixa_loja FOREIGN KEY (id_loja) REFERENCES public.loja(id_loja);


--
-- TOC entry 5002 (class 2606 OID 17877)
-- Name: forma_pagamento_loja fk_forma_pagamento_loja; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forma_pagamento_loja
    ADD CONSTRAINT fk_forma_pagamento_loja FOREIGN KEY (id_loja) REFERENCES public.loja(id_loja);


--
-- TOC entry 5006 (class 2606 OID 17948)
-- Name: grupo_complemento fk_grupo_produto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grupo_complemento
    ADD CONSTRAINT fk_grupo_produto FOREIGN KEY (id_produto) REFERENCES public.produto(id_produto);


--
-- TOC entry 5001 (class 2606 OID 17861)
-- Name: horario_funcionamento fk_horario_loja; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.horario_funcionamento
    ADD CONSTRAINT fk_horario_loja FOREIGN KEY (id_loja) REFERENCES public.loja(id_loja);


--
-- TOC entry 5000 (class 2606 OID 17843)
-- Name: loja fk_loja_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loja
    ADD CONSTRAINT fk_loja_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 5011 (class 2606 OID 18057)
-- Name: pedido fk_pedido_endereco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT fk_pedido_endereco FOREIGN KEY (id_endereco) REFERENCES public.endereco(id_endereco);


--
-- TOC entry 5016 (class 2606 OID 18109)
-- Name: pedido_item_complemento fk_pedido_item_complemento_complemento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido_item_complemento
    ADD CONSTRAINT fk_pedido_item_complemento_complemento FOREIGN KEY (id_complemento) REFERENCES public.complemento(id_complemento);


--
-- TOC entry 5017 (class 2606 OID 18104)
-- Name: pedido_item_complemento fk_pedido_item_complemento_item; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido_item_complemento
    ADD CONSTRAINT fk_pedido_item_complemento_item FOREIGN KEY (id_pedido_item) REFERENCES public.pedido_item(id_pedido_item);


--
-- TOC entry 5014 (class 2606 OID 18081)
-- Name: pedido_item fk_pedido_item_pedido; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido_item
    ADD CONSTRAINT fk_pedido_item_pedido FOREIGN KEY (id_pedido) REFERENCES public.pedido(id_pedido);


--
-- TOC entry 5015 (class 2606 OID 18086)
-- Name: pedido_item fk_pedido_item_produto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido_item
    ADD CONSTRAINT fk_pedido_item_produto FOREIGN KEY (id_produto) REFERENCES public.produto(id_produto);


--
-- TOC entry 5012 (class 2606 OID 18052)
-- Name: pedido fk_pedido_loja; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT fk_pedido_loja FOREIGN KEY (id_loja) REFERENCES public.loja(id_loja);


--
-- TOC entry 5013 (class 2606 OID 18047)
-- Name: pedido fk_pedido_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT fk_pedido_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 5005 (class 2606 OID 17928)
-- Name: produto fk_produto_categoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT fk_produto_categoria FOREIGN KEY (id_categoria) REFERENCES public.categoria(id_categoria);


--
-- TOC entry 4999 (class 2606 OID 17818)
-- Name: usuario fk_usuario_perfil; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT fk_usuario_perfil FOREIGN KEY (id_perfil) REFERENCES public.perfil(id_perfil);


-- Completed on 2026-10-05 10:18:55

--
-- PostgreSQL database dump complete
--

\unrestrict dCic6x9E5a9Cb2JeTpVOMIY0ltjyMlE9vKeo1dA6Ed7LO59IDBw9OjpquBQe8hj

