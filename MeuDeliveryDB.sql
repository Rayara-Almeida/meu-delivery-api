--
-- PostgreSQL database dump
--

\restrict uc6OpRb0TWmvwo8ejMCAb5cdjOFbpockjpkbO3kSwxyff6g7RRAXp7b2bhtbIOI

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

-- Started on 2026-09-20 19:03:15

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
-- TOC entry 5075 (class 0 OID 0)
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
-- TOC entry 5076 (class 0 OID 0)
-- Dependencies: 227
-- Name: forma_pagamento_loja_id_forma_pagamento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.forma_pagamento_loja_id_forma_pagamento_seq OWNED BY public.forma_pagamento_loja.id_forma_pagamento;


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
-- TOC entry 5077 (class 0 OID 0)
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
-- TOC entry 5078 (class 0 OID 0)
-- Dependencies: 223
-- Name: loja_id_loja_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.loja_id_loja_seq OWNED BY public.loja.id_loja;


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
-- TOC entry 5079 (class 0 OID 0)
-- Dependencies: 219
-- Name: perfil_id_perfil_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.perfil_id_perfil_seq OWNED BY public.perfil.id_perfil;


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
-- TOC entry 5080 (class 0 OID 0)
-- Dependencies: 221
-- Name: usuario_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_id_usuario_seq OWNED BY public.usuario.id_usuario;


--
-- TOC entry 4887 (class 2604 OID 17886)
-- Name: faixa_entrega id_faixa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faixa_entrega ALTER COLUMN id_faixa SET DEFAULT nextval('public.faixa_entrega_id_faixa_seq'::regclass);


--
-- TOC entry 4886 (class 2604 OID 17870)
-- Name: forma_pagamento_loja id_forma_pagamento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forma_pagamento_loja ALTER COLUMN id_forma_pagamento SET DEFAULT nextval('public.forma_pagamento_loja_id_forma_pagamento_seq'::regclass);


--
-- TOC entry 4885 (class 2604 OID 17852)
-- Name: horario_funcionamento id_horario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.horario_funcionamento ALTER COLUMN id_horario SET DEFAULT nextval('public.horario_funcionamento_id_horario_seq'::regclass);


--
-- TOC entry 4883 (class 2604 OID 17829)
-- Name: loja id_loja; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loja ALTER COLUMN id_loja SET DEFAULT nextval('public.loja_id_loja_seq'::regclass);


--
-- TOC entry 4881 (class 2604 OID 17798)
-- Name: perfil id_perfil; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil ALTER COLUMN id_perfil SET DEFAULT nextval('public.perfil_id_perfil_seq'::regclass);


--
-- TOC entry 4882 (class 2604 OID 17809)
-- Name: usuario id_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuario_id_usuario_seq'::regclass);


--
-- TOC entry 5069 (class 0 OID 17883)
-- Dependencies: 230
-- Data for Name: faixa_entrega; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.faixa_entrega (id_faixa, id_loja, distancia_maxima_km, taxa) FROM stdin;
\.


--
-- TOC entry 5067 (class 0 OID 17867)
-- Dependencies: 228
-- Data for Name: forma_pagamento_loja; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.forma_pagamento_loja (id_forma_pagamento, id_loja, forma_pagamento) FROM stdin;
\.


--
-- TOC entry 5065 (class 0 OID 17849)
-- Dependencies: 226
-- Data for Name: horario_funcionamento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.horario_funcionamento (id_horario, id_loja, dia_semana, hora_abertura, hora_fechamento) FROM stdin;
1	1	segunda	08:00:00	18:00:00
2	1	terça	08:00:00	18:00:00
3	1	quarta	08:00:00	18:00:00
4	1	quinta	08:00:00	18:00:00
5	1	sexta	08:00:00	18:00:00
\.


--
-- TOC entry 5063 (class 0 OID 17826)
-- Dependencies: 224
-- Data for Name: loja; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.loja (id_loja, id_usuario, nome, foto, categoria, endereco, telefone, aberta, tempo_estimado, taxa) FROM stdin;
1	5	Loja Teste	https://exemplo.com/foto-loja.jpg	lanches	Rua Principal, 100	87977777777	f	40	5.00
\.


--
-- TOC entry 5059 (class 0 OID 17795)
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
-- TOC entry 5061 (class 0 OID 17806)
-- Dependencies: 222
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario (id_usuario, nome, email, telefone, senha, id_perfil) FROM stdin;
3	Maria Teste	maria.teste@email.com	87999999999	$2b$10$59BQF.aKDNhJsuH0nX2S8./TjtRjS/5EewqB00F82ngY73Vfz/8s6	3
4	Admin Teste	admin.teste@email.com	87988888888	$2b$10$H.73BTYh/llw9emQ15tHUO8yQQ9pYtu44v4MKixKat/wBQJ.z2gH6	1
5	Loja Teste	loja.teste@email.com	87977777777	$2b$10$bYGkBXRkeCwk7poaWmKM9.JYI0b79vuhSUzkLP.LP5buQa3luOgCS	2
6	Entregador Teste	entregador.teste@email.com	87966666666	$2b$10$jWyHoBMzDpCNEnW36W20LuaHrLaLwVJfXtb40PtL52MJSkmo2M2K2	4
7	Cliente Teste	cliente.teste@email.com	87955555555	$2b$10$e59zZ8pJfoSNq0YFvmvRJOsUuWzeec9bXyxH0Sy.iFfVip9HUaYqO	3
\.


--
-- TOC entry 5081 (class 0 OID 0)
-- Dependencies: 229
-- Name: faixa_entrega_id_faixa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.faixa_entrega_id_faixa_seq', 4, true);


--
-- TOC entry 5082 (class 0 OID 0)
-- Dependencies: 227
-- Name: forma_pagamento_loja_id_forma_pagamento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.forma_pagamento_loja_id_forma_pagamento_seq', 1, false);


--
-- TOC entry 5083 (class 0 OID 0)
-- Dependencies: 225
-- Name: horario_funcionamento_id_horario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.horario_funcionamento_id_horario_seq', 5, true);


--
-- TOC entry 5084 (class 0 OID 0)
-- Dependencies: 223
-- Name: loja_id_loja_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.loja_id_loja_seq', 2, true);


--
-- TOC entry 5085 (class 0 OID 0)
-- Dependencies: 219
-- Name: perfil_id_perfil_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.perfil_id_perfil_seq', 4, true);


--
-- TOC entry 5086 (class 0 OID 0)
-- Dependencies: 221
-- Name: usuario_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_id_usuario_seq', 9, true);


--
-- TOC entry 4905 (class 2606 OID 17892)
-- Name: faixa_entrega faixa_entrega_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faixa_entrega
    ADD CONSTRAINT faixa_entrega_pkey PRIMARY KEY (id_faixa);


--
-- TOC entry 4903 (class 2606 OID 17876)
-- Name: forma_pagamento_loja forma_pagamento_loja_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forma_pagamento_loja
    ADD CONSTRAINT forma_pagamento_loja_pkey PRIMARY KEY (id_forma_pagamento);


--
-- TOC entry 4901 (class 2606 OID 17860)
-- Name: horario_funcionamento horario_funcionamento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.horario_funcionamento
    ADD CONSTRAINT horario_funcionamento_pkey PRIMARY KEY (id_horario);


--
-- TOC entry 4899 (class 2606 OID 17842)
-- Name: loja loja_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loja
    ADD CONSTRAINT loja_pkey PRIMARY KEY (id_loja);


--
-- TOC entry 4892 (class 2606 OID 17804)
-- Name: perfil perfil_nome_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil
    ADD CONSTRAINT perfil_nome_key UNIQUE (nome);


--
-- TOC entry 4894 (class 2606 OID 17802)
-- Name: perfil perfil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil
    ADD CONSTRAINT perfil_pkey PRIMARY KEY (id_perfil);


--
-- TOC entry 4897 (class 2606 OID 17817)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 4895 (class 1259 OID 17823)
-- Name: uq_usuario_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX uq_usuario_email ON public.usuario USING btree (lower((email)::text));


--
-- TOC entry 4910 (class 2606 OID 17893)
-- Name: faixa_entrega fk_faixa_loja; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faixa_entrega
    ADD CONSTRAINT fk_faixa_loja FOREIGN KEY (id_loja) REFERENCES public.loja(id_loja);


--
-- TOC entry 4909 (class 2606 OID 17877)
-- Name: forma_pagamento_loja fk_forma_pagamento_loja; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forma_pagamento_loja
    ADD CONSTRAINT fk_forma_pagamento_loja FOREIGN KEY (id_loja) REFERENCES public.loja(id_loja);


--
-- TOC entry 4908 (class 2606 OID 17861)
-- Name: horario_funcionamento fk_horario_loja; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.horario_funcionamento
    ADD CONSTRAINT fk_horario_loja FOREIGN KEY (id_loja) REFERENCES public.loja(id_loja);


--
-- TOC entry 4907 (class 2606 OID 17843)
-- Name: loja fk_loja_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loja
    ADD CONSTRAINT fk_loja_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 4906 (class 2606 OID 17818)
-- Name: usuario fk_usuario_perfil; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT fk_usuario_perfil FOREIGN KEY (id_perfil) REFERENCES public.perfil(id_perfil);


-- Completed on 2026-09-20 19:03:15

--
-- PostgreSQL database dump complete
--

\unrestrict uc6OpRb0TWmvwo8ejMCAb5cdjOFbpockjpkbO3kSwxyff6g7RRAXp7b2bhtbIOI

