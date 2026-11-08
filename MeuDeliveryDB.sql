--
-- PostgreSQL database dump
--

\restrict OiD5hKhCqUBkuQibeeMwpd0EoEaPtziuzuKJknfIKr8NQFQNcORciR1TEUEZtdA

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

-- Started on 2026-11-08 19:48:08

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
-- TOC entry 258 (class 1259 OID 26287)
-- Name: avaliacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.avaliacao (
    id_avaliacao integer NOT NULL,
    id_pedido integer NOT NULL,
    id_usuario integer NOT NULL,
    nota integer NOT NULL,
    comentario text,
    data_avaliacao timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT avaliacao_nota_check CHECK (((nota >= 1) AND (nota <= 5)))
);


ALTER TABLE public.avaliacao OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 26286)
-- Name: avaliacao_id_avaliacao_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.avaliacao_id_avaliacao_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.avaliacao_id_avaliacao_seq OWNER TO postgres;

--
-- TOC entry 5275 (class 0 OID 0)
-- Dependencies: 257
-- Name: avaliacao_id_avaliacao_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.avaliacao_id_avaliacao_seq OWNED BY public.avaliacao.id_avaliacao;


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
-- TOC entry 5276 (class 0 OID 0)
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
-- TOC entry 5277 (class 0 OID 0)
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
-- TOC entry 5278 (class 0 OID 0)
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
-- TOC entry 5279 (class 0 OID 0)
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
-- TOC entry 5280 (class 0 OID 0)
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
-- TOC entry 5281 (class 0 OID 0)
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
-- TOC entry 5282 (class 0 OID 0)
-- Dependencies: 235
-- Name: grupo_complemento_id_grupo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.grupo_complemento_id_grupo_seq OWNED BY public.grupo_complemento.id_grupo;


--
-- TOC entry 252 (class 1259 OID 26194)
-- Name: historico_atribuicao_entregador; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.historico_atribuicao_entregador (
    id_historico integer NOT NULL,
    id_pedido integer NOT NULL,
    id_entregador_anterior integer,
    id_entregador_novo integer NOT NULL,
    id_usuario integer NOT NULL,
    data_hora timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.historico_atribuicao_entregador OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 26193)
-- Name: historico_atribuicao_entregador_id_historico_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.historico_atribuicao_entregador_id_historico_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.historico_atribuicao_entregador_id_historico_seq OWNER TO postgres;

--
-- TOC entry 5283 (class 0 OID 0)
-- Dependencies: 251
-- Name: historico_atribuicao_entregador_id_historico_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.historico_atribuicao_entregador_id_historico_seq OWNED BY public.historico_atribuicao_entregador.id_historico;


--
-- TOC entry 250 (class 1259 OID 26164)
-- Name: historico_status_pedido; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.historico_status_pedido (
    id_historico integer NOT NULL,
    id_pedido integer NOT NULL,
    status_anterior character varying(40),
    status_novo character varying(40) NOT NULL,
    motivo text,
    data_hora timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    id_usuario integer
);


ALTER TABLE public.historico_status_pedido OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 26163)
-- Name: historico_status_pedido_id_historico_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.historico_status_pedido_id_historico_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.historico_status_pedido_id_historico_seq OWNER TO postgres;

--
-- TOC entry 5284 (class 0 OID 0)
-- Dependencies: 249
-- Name: historico_status_pedido_id_historico_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.historico_status_pedido_id_historico_seq OWNED BY public.historico_status_pedido.id_historico;


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
-- TOC entry 5285 (class 0 OID 0)
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
-- TOC entry 5286 (class 0 OID 0)
-- Dependencies: 223
-- Name: loja_id_loja_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.loja_id_loja_seq OWNED BY public.loja.id_loja;


--
-- TOC entry 256 (class 1259 OID 26261)
-- Name: notificacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notificacao (
    id_notificacao integer NOT NULL,
    id_usuario integer NOT NULL,
    id_pedido integer,
    mensagem text NOT NULL,
    lida boolean DEFAULT false NOT NULL,
    data_criacao timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.notificacao OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 26260)
-- Name: notificacao_id_notificacao_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notificacao_id_notificacao_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notificacao_id_notificacao_seq OWNER TO postgres;

--
-- TOC entry 5287 (class 0 OID 0)
-- Dependencies: 255
-- Name: notificacao_id_notificacao_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notificacao_id_notificacao_seq OWNED BY public.notificacao.id_notificacao;


--
-- TOC entry 254 (class 1259 OID 26229)
-- Name: oferta_entrega; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oferta_entrega (
    id_oferta integer NOT NULL,
    id_pedido integer NOT NULL,
    id_entregador integer NOT NULL,
    origem text NOT NULL,
    destino text NOT NULL,
    distancia_km numeric(8,2) NOT NULL,
    valor_entrega numeric(10,2) NOT NULL,
    prazo_resposta timestamp without time zone NOT NULL,
    status character varying(20) DEFAULT 'pendente'::character varying NOT NULL,
    data_criacao timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT chk_status_oferta CHECK (((status)::text = ANY ((ARRAY['pendente'::character varying, 'aceita'::character varying, 'recusada'::character varying, 'expirada'::character varying])::text[])))
);


ALTER TABLE public.oferta_entrega OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 26228)
-- Name: oferta_entrega_id_oferta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oferta_entrega_id_oferta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oferta_entrega_id_oferta_seq OWNER TO postgres;

--
-- TOC entry 5288 (class 0 OID 0)
-- Dependencies: 253
-- Name: oferta_entrega_id_oferta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oferta_entrega_id_oferta_seq OWNED BY public.oferta_entrega.id_oferta;


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
    id_entregador integer,
    tempo_preparo integer,
    data_coleta timestamp without time zone,
    CONSTRAINT chk_forma_pagamento CHECK (((forma_pagamento)::text = ANY ((ARRAY['dinheiro'::character varying, 'cartao_entrega'::character varying, 'pix'::character varying])::text[]))),
    CONSTRAINT chk_pedido_status CHECK (((status)::text = ANY ((ARRAY['aguardando_confirmacao'::character varying, 'em_preparo'::character varying, 'pronto'::character varying, 'despachado'::character varying, 'a_caminho'::character varying, 'entregue'::character varying, 'recusado'::character varying, 'cancelado'::character varying, 'nao_entregue'::character varying])::text[]))),
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
-- TOC entry 5289 (class 0 OID 0)
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
-- TOC entry 5290 (class 0 OID 0)
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
-- TOC entry 5291 (class 0 OID 0)
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
-- TOC entry 5292 (class 0 OID 0)
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
-- TOC entry 5293 (class 0 OID 0)
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
    id_perfil integer NOT NULL,
    online boolean DEFAULT false NOT NULL
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
-- TOC entry 5294 (class 0 OID 0)
-- Dependencies: 221
-- Name: usuario_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_id_usuario_seq OWNED BY public.usuario.id_usuario;


--
-- TOC entry 4984 (class 2604 OID 26290)
-- Name: avaliacao id_avaliacao; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avaliacao ALTER COLUMN id_avaliacao SET DEFAULT nextval('public.avaliacao_id_avaliacao_seq'::regclass);


--
-- TOC entry 4959 (class 2604 OID 17902)
-- Name: categoria id_categoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria ALTER COLUMN id_categoria SET DEFAULT nextval('public.categoria_id_categoria_seq'::regclass);


--
-- TOC entry 4964 (class 2604 OID 17957)
-- Name: complemento id_complemento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.complemento ALTER COLUMN id_complemento SET DEFAULT nextval('public.complemento_id_complemento_seq'::regclass);


--
-- TOC entry 4966 (class 2604 OID 17975)
-- Name: endereco id_endereco; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endereco ALTER COLUMN id_endereco SET DEFAULT nextval('public.endereco_id_endereco_seq'::regclass);


--
-- TOC entry 4969 (class 2604 OID 18000)
-- Name: endereco_loja id_endereco_loja; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endereco_loja ALTER COLUMN id_endereco_loja SET DEFAULT nextval('public.endereco_loja_id_endereco_loja_seq'::regclass);


--
-- TOC entry 4958 (class 2604 OID 17886)
-- Name: faixa_entrega id_faixa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faixa_entrega ALTER COLUMN id_faixa SET DEFAULT nextval('public.faixa_entrega_id_faixa_seq'::regclass);


--
-- TOC entry 4957 (class 2604 OID 17870)
-- Name: forma_pagamento_loja id_forma_pagamento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forma_pagamento_loja ALTER COLUMN id_forma_pagamento SET DEFAULT nextval('public.forma_pagamento_loja_id_forma_pagamento_seq'::regclass);


--
-- TOC entry 4962 (class 2604 OID 17937)
-- Name: grupo_complemento id_grupo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grupo_complemento ALTER COLUMN id_grupo SET DEFAULT nextval('public.grupo_complemento_id_grupo_seq'::regclass);


--
-- TOC entry 4976 (class 2604 OID 26197)
-- Name: historico_atribuicao_entregador id_historico; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historico_atribuicao_entregador ALTER COLUMN id_historico SET DEFAULT nextval('public.historico_atribuicao_entregador_id_historico_seq'::regclass);


--
-- TOC entry 4974 (class 2604 OID 26167)
-- Name: historico_status_pedido id_historico; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historico_status_pedido ALTER COLUMN id_historico SET DEFAULT nextval('public.historico_status_pedido_id_historico_seq'::regclass);


--
-- TOC entry 4956 (class 2604 OID 17852)
-- Name: horario_funcionamento id_horario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.horario_funcionamento ALTER COLUMN id_horario SET DEFAULT nextval('public.horario_funcionamento_id_horario_seq'::regclass);


--
-- TOC entry 4954 (class 2604 OID 17829)
-- Name: loja id_loja; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loja ALTER COLUMN id_loja SET DEFAULT nextval('public.loja_id_loja_seq'::regclass);


--
-- TOC entry 4981 (class 2604 OID 26264)
-- Name: notificacao id_notificacao; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notificacao ALTER COLUMN id_notificacao SET DEFAULT nextval('public.notificacao_id_notificacao_seq'::regclass);


--
-- TOC entry 4978 (class 2604 OID 26232)
-- Name: oferta_entrega id_oferta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oferta_entrega ALTER COLUMN id_oferta SET DEFAULT nextval('public.oferta_entrega_id_oferta_seq'::regclass);


--
-- TOC entry 4970 (class 2604 OID 18024)
-- Name: pedido id_pedido; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido ALTER COLUMN id_pedido SET DEFAULT nextval('public.pedido_id_pedido_seq'::regclass);


--
-- TOC entry 4972 (class 2604 OID 18066)
-- Name: pedido_item id_pedido_item; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido_item ALTER COLUMN id_pedido_item SET DEFAULT nextval('public.pedido_item_id_pedido_item_seq'::regclass);


--
-- TOC entry 4973 (class 2604 OID 18095)
-- Name: pedido_item_complemento id_pedido_item_complemento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido_item_complemento ALTER COLUMN id_pedido_item_complemento SET DEFAULT nextval('public.pedido_item_complemento_id_pedido_item_complemento_seq'::regclass);


--
-- TOC entry 4951 (class 2604 OID 17798)
-- Name: perfil id_perfil; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil ALTER COLUMN id_perfil SET DEFAULT nextval('public.perfil_id_perfil_seq'::regclass);


--
-- TOC entry 4960 (class 2604 OID 17917)
-- Name: produto id_produto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto ALTER COLUMN id_produto SET DEFAULT nextval('public.produto_id_produto_seq'::regclass);


--
-- TOC entry 4952 (class 2604 OID 17809)
-- Name: usuario id_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuario_id_usuario_seq'::regclass);


--
-- TOC entry 5269 (class 0 OID 26287)
-- Dependencies: 258
-- Data for Name: avaliacao; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.avaliacao (id_avaliacao, id_pedido, id_usuario, nota, comentario, data_avaliacao) FROM stdin;
1	2	13	5	Pedido muito bom!	2026-11-08 19:40:27.081337
\.


--
-- TOC entry 5243 (class 0 OID 17899)
-- Dependencies: 232
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categoria (id_categoria, id_loja, nome) FROM stdin;
3	1	Lanches
\.


--
-- TOC entry 5249 (class 0 OID 17954)
-- Dependencies: 238
-- Data for Name: complemento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.complemento (id_complemento, id_grupo, nome, preco) FROM stdin;
\.


--
-- TOC entry 5251 (class 0 OID 17972)
-- Dependencies: 240
-- Data for Name: endereco; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.endereco (id_endereco, id_usuario, rua, numero, complemento, bairro, cidade, ponto_referencia, favorito, ativo) FROM stdin;
4	13	Rua Teste	100	\N	Centro	João Pessoa	Próximo à praça	f	t
5	7	Rua Teste	101	\N	Centro	Jo�o Pessoa	\N	f	t
\.


--
-- TOC entry 5253 (class 0 OID 17997)
-- Dependencies: 242
-- Data for Name: endereco_loja; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.endereco_loja (id_endereco_loja, id_endereco, id_loja, distancia_km) FROM stdin;
1	4	1	2.00
2	5	1	2.00
\.


--
-- TOC entry 5241 (class 0 OID 17883)
-- Dependencies: 230
-- Data for Name: faixa_entrega; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.faixa_entrega (id_faixa, id_loja, distancia_maxima_km, taxa) FROM stdin;
5	1	3.00	5.00
6	1	5.00	8.00
7	1	8.00	12.00
8	1	3.00	8.00
\.


--
-- TOC entry 5239 (class 0 OID 17867)
-- Dependencies: 228
-- Data for Name: forma_pagamento_loja; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.forma_pagamento_loja (id_forma_pagamento, id_loja, forma_pagamento) FROM stdin;
\.


--
-- TOC entry 5247 (class 0 OID 17934)
-- Dependencies: 236
-- Data for Name: grupo_complemento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.grupo_complemento (id_grupo, id_produto, nome, minimo_escolhas, maximo_escolhas) FROM stdin;
\.


--
-- TOC entry 5263 (class 0 OID 26194)
-- Dependencies: 252
-- Data for Name: historico_atribuicao_entregador; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.historico_atribuicao_entregador (id_historico, id_pedido, id_entregador_anterior, id_entregador_novo, id_usuario, data_hora) FROM stdin;
1	4	\N	14	5	2026-10-30 15:40:00.229687
2	1	\N	6	5	2026-11-03 11:20:25.775357
3	2	\N	6	6	2026-11-08 13:15:57.058729
\.


--
-- TOC entry 5261 (class 0 OID 26164)
-- Dependencies: 250
-- Data for Name: historico_status_pedido; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.historico_status_pedido (id_historico, id_pedido, status_anterior, status_novo, motivo, data_hora, id_usuario) FROM stdin;
1	3	\N	aguardando_confirmacao	\N	2026-10-27 16:13:59.843078	7
2	4	\N	aguardando_confirmacao	\N	2026-10-27 16:15:07.2545	7
3	3	aguardando_confirmacao	em_preparo	\N	2026-10-27 16:17:28.404611	5
4	5	\N	aguardando_confirmacao	\N	2026-10-27 16:20:23.996451	7
5	5	aguardando_confirmacao	cancelado	Cliente solicitou cancelamento	2026-10-27 16:20:45.798484	7
6	6	\N	aguardando_confirmacao	\N	2026-10-29 11:53:29.019623	7
7	6	aguardando_confirmacao	recusado	Produto indispon�vel para teste	2026-10-29 12:04:52.109369	5
8	7	\N	aguardando_confirmacao	\N	2026-10-29 12:09:39.928142	7
9	7	aguardando_confirmacao	cancelado	Cliente desistiu do pedido	2026-10-29 12:10:21.893942	7
10	8	\N	aguardando_confirmacao	\N	2026-10-29 12:28:32.541964	7
11	8	aguardando_confirmacao	em_preparo	\N	2026-10-29 12:28:57.106129	5
12	8	em_preparo	pronto	\N	2026-10-29 12:29:20.551189	5
13	8	pronto	a_caminho	\N	2026-10-29 12:32:44.162666	6
14	8	a_caminho	entregue	\N	2026-10-29 12:33:10.064453	6
15	3	em_preparo	pronto	\N	2026-10-29 15:50:33.264699	5
16	3	pronto	a_caminho	\N	2026-10-29 15:52:00.460894	6
17	3	a_caminho	entregue	\N	2026-10-29 15:52:15.648139	6
18	4	aguardando_confirmacao	em_preparo	\N	2026-10-29 15:59:14.862601	5
19	4	em_preparo	pronto	\N	2026-10-29 15:59:30.468193	5
20	4	pronto	a_caminho	\N	2026-10-30 15:47:26.661781	14
21	4	a_caminho	entregue	\N	2026-10-30 15:48:03.268344	14
22	1	aguardando_confirmacao	em_preparo	\N	2026-11-03 11:19:50.667209	5
23	1	em_preparo	pronto	\N	2026-11-03 11:20:09.557688	5
24	1	pronto	a_caminho	\N	2026-11-03 11:34:40.81073	6
25	1	a_caminho	nao_entregue	Cliente n�o estava dispon�vel para receber o pedido.	2026-11-03 11:34:57.859577	6
26	2	aguardando_confirmacao	em_preparo	\N	2026-11-03 20:43:54.987541	5
27	9	\N	aguardando_confirmacao	\N	2026-11-03 21:14:19.858633	13
28	9	aguardando_confirmacao	recusado	Produto indispon�vel para teste	2026-11-03 21:17:12.180699	5
29	2	em_preparo	pronto	\N	2026-11-03 21:21:13.26416	5
30	2	pronto	despachado	\N	2026-11-08 12:57:54.734123	5
31	10	\N	aguardando_confirmacao	\N	2026-11-08 13:40:28.620752	13
32	10	aguardando_confirmacao	em_preparo	\N	2026-11-08 13:46:42.635567	5
33	10	em_preparo	pronto	\N	2026-11-08 13:47:02.20959	5
34	10	pronto	despachado	\N	2026-11-08 13:50:51.601365	5
35	11	\N	aguardando_confirmacao	\N	2026-11-08 14:14:21.95117	13
36	11	aguardando_confirmacao	em_preparo	\N	2026-11-08 14:16:18.383093	5
37	11	em_preparo	pronto	\N	2026-11-08 14:16:34.486444	5
38	11	pronto	despachado	\N	2026-11-08 14:16:53.477656	5
39	12	\N	aguardando_confirmacao	\N	2026-11-08 16:18:22.491035	13
40	12	aguardando_confirmacao	em_preparo	\N	2026-11-08 16:32:35.977012	5
41	12	em_preparo	pronto	\N	2026-11-08 16:32:50.463926	5
42	12	pronto	despachado	\N	2026-11-08 16:33:07.792516	5
43	2	despachado	a_caminho	\N	2026-11-08 19:27:58.891015	6
44	2	a_caminho	entregue	\N	2026-11-08 19:39:33.569712	6
\.


--
-- TOC entry 5237 (class 0 OID 17849)
-- Dependencies: 226
-- Data for Name: horario_funcionamento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.horario_funcionamento (id_horario, id_loja, dia_semana, hora_abertura, hora_fechamento) FROM stdin;
1	1	segunda	08:00:00	18:00:00
3	1	quarta	08:00:00	18:00:00
4	1	quinta	08:00:00	18:00:00
5	1	sexta	08:00:00	18:00:00
6	1	domingo	00:00:00	23:59:00
2	1	terça	08:00:00	18:00:00
\.


--
-- TOC entry 5235 (class 0 OID 17826)
-- Dependencies: 224
-- Data for Name: loja; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.loja (id_loja, id_usuario, nome, foto, categoria, endereco, telefone, aberta, tempo_estimado, taxa) FROM stdin;
1	5	Loja Teste	https://exemplo.com/foto-loja.jpg	lanches	Rua Principal, 100	87977777777	t	40	5.00
\.


--
-- TOC entry 5267 (class 0 OID 26261)
-- Dependencies: 256
-- Data for Name: notificacao; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notificacao (id_notificacao, id_usuario, id_pedido, mensagem, lida, data_criacao) FROM stdin;
1	5	12	Não há entregadores online disponíveis para este pedido.	t	2026-11-08 16:37:13.279911
\.


--
-- TOC entry 5265 (class 0 OID 26229)
-- Dependencies: 254
-- Data for Name: oferta_entrega; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oferta_entrega (id_oferta, id_pedido, id_entregador, origem, destino, distancia_km, valor_entrega, prazo_resposta, status, data_criacao) FROM stdin;
2	2	6	Rua Principal, 100	Rua Teste, 100, Centro, João Pessoa	2.00	5.00	2026-11-08 13:30:46.614983	aceita	2026-11-08 13:11:23.182625
1	2	6	Rua Principal, 100	Rua Teste, 100, Centro, João Pessoa	2.00	5.00	2026-11-08 12:59:54.734123	expirada	2026-11-08 12:57:54.734123
3	10	6	Rua Principal, 100	Rua Teste, 100, Centro, João Pessoa	2.00	5.00	2026-11-08 13:52:51.601365	expirada	2026-11-08 13:50:51.601365
4	11	6	Rua Principal, 100	Rua Teste, 100, Centro, João Pessoa	2.00	5.00	2026-11-08 14:18:53.477656	recusada	2026-11-08 14:16:53.477656
5	11	14	Rua Principal, 100	Rua Teste, 100, Centro, João Pessoa	2.00	5.00	2026-11-08 14:19:34.511515	expirada	2026-11-08 14:17:34.511515
6	12	6	Rua Principal, 100	Rua Teste, 100, Centro, João Pessoa	2.00	5.00	2026-11-08 16:35:07.792516	expirada	2026-11-08 16:33:07.792516
7	12	14	Rua Principal, 100	Rua Teste, 100, Centro, João Pessoa	2.00	5.00	2026-11-08 16:37:12.022494	expirada	2026-11-08 16:35:12.022494
\.


--
-- TOC entry 5255 (class 0 OID 18021)
-- Dependencies: 244
-- Data for Name: pedido; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pedido (id_pedido, id_usuario, id_loja, id_endereco, rua, numero, complemento, bairro, cidade, ponto_referencia, status, subtotal, taxa_entrega, total, forma_pagamento, troco, id_entregador, tempo_preparo, data_coleta) FROM stdin;
5	7	1	5	Rua Teste	101	\N	Centro	Jo�o Pessoa	\N	cancelado	20.00	5.00	25.00	pix	\N	\N	\N	\N
6	7	1	5	Rua Teste	101	\N	Centro	Jo�o Pessoa	\N	recusado	20.00	5.00	25.00	pix	\N	\N	\N	\N
7	7	1	5	Rua Teste	101	\N	Centro	Jo�o Pessoa	\N	cancelado	20.00	5.00	25.00	pix	\N	\N	\N	\N
8	7	1	5	Rua Teste	101	\N	Centro	Jo�o Pessoa	\N	entregue	20.00	5.00	25.00	pix	\N	\N	\N	\N
3	7	1	5	Rua Teste	101	\N	Centro	Jo�o Pessoa	\N	entregue	20.00	5.00	25.00	pix	\N	6	\N	\N
4	7	1	5	Rua Teste	101	\N	Centro	Jo�o Pessoa	\N	entregue	20.00	5.00	25.00	pix	\N	14	\N	\N
1	13	1	4	Rua Teste	100	\N	Centro	João Pessoa	Próximo à praça	nao_entregue	20.00	5.00	25.00	pix	\N	6	\N	\N
9	13	1	4	Rua Teste	100	\N	Centro	João Pessoa	Próximo à praça	recusado	20.00	5.00	25.00	pix	\N	\N	\N	\N
10	13	1	4	Rua Teste	100	\N	Centro	João Pessoa	Próximo à praça	despachado	20.00	5.00	25.00	pix	\N	\N	30	\N
11	13	1	4	Rua Teste	100	\N	Centro	João Pessoa	Próximo à praça	despachado	20.00	5.00	25.00	pix	\N	\N	30	\N
12	13	1	4	Rua Teste	100	\N	Centro	João Pessoa	Próximo à praça	despachado	20.00	5.00	25.00	pix	\N	\N	30	\N
2	13	1	4	Rua Teste	100	\N	Centro	João Pessoa	Próximo à praça	entregue	20.00	5.00	25.00	pix	\N	6	35	2026-11-08 19:27:58.891015
\.


--
-- TOC entry 5257 (class 0 OID 18063)
-- Dependencies: 246
-- Data for Name: pedido_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pedido_item (id_pedido_item, id_pedido, id_produto, nome_produto, preco_unitario, quantidade, observacao, subtotal) FROM stdin;
1	1	5	X-Burger Teste	20.00	1	Teste do pedido	20.00
2	2	5	X-Burger Teste	20.00	1	Teste final APP 07	20.00
3	3	5	X-Burger Teste	20.00	1	\N	20.00
4	4	5	X-Burger Teste	20.00	1	\N	20.00
5	5	5	X-Burger Teste	20.00	1	\N	20.00
6	6	5	X-Burger Teste	20.00	1	\N	20.00
7	7	5	X-Burger Teste	20.00	1	\N	20.00
8	8	5	X-Burger Teste	20.00	1	\N	20.00
9	9	5	X-Burger Teste	20.00	1	\N	20.00
10	10	5	X-Burger Teste	20.00	1	\N	20.00
11	11	5	X-Burger Teste	20.00	1	\N	20.00
12	12	5	X-Burger Teste	20.00	1	\N	20.00
\.


--
-- TOC entry 5259 (class 0 OID 18092)
-- Dependencies: 248
-- Data for Name: pedido_item_complemento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pedido_item_complemento (id_pedido_item_complemento, id_pedido_item, id_complemento, nome_complemento, preco) FROM stdin;
\.


--
-- TOC entry 5231 (class 0 OID 17795)
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
-- TOC entry 5245 (class 0 OID 17914)
-- Dependencies: 234
-- Data for Name: produto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produto (id_produto, id_categoria, nome, foto, descricao, preco, disponivel) FROM stdin;
5	3	X-Burger Teste	\N	Produto para teste do pedido	25.00	t
\.


--
-- TOC entry 5233 (class 0 OID 17806)
-- Dependencies: 222
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario (id_usuario, nome, email, telefone, senha, id_perfil, online) FROM stdin;
3	Maria Teste	maria.teste@email.com	87999999999	$2b$10$59BQF.aKDNhJsuH0nX2S8./TjtRjS/5EewqB00F82ngY73Vfz/8s6	3	f
4	Admin Teste	admin.teste@email.com	87988888888	$2b$10$H.73BTYh/llw9emQ15tHUO8yQQ9pYtu44v4MKixKat/wBQJ.z2gH6	1	f
5	Loja Teste	loja.teste@email.com	87977777777	$2b$10$bYGkBXRkeCwk7poaWmKM9.JYI0b79vuhSUzkLP.LP5buQa3luOgCS	2	f
7	Cliente Teste	cliente.teste@email.com	87955555555	$2b$10$e59zZ8pJfoSNq0YFvmvRJOsUuWzeec9bXyxH0Sy.iFfVip9HUaYqO	3	f
13	Cliente W06	clientew06@gmail.com	87999999999	$2b$10$/CLpOW9WfXfnpE2iiFoNE.nnNkUu.5JaYWUfP.vOwRf0fJ.E/tKvC	3	f
6	Entregador Teste	entregador.teste@email.com	87966666666	$2b$10$jWyHoBMzDpCNEnW36W20LuaHrLaLwVJfXtb40PtL52MJSkmo2M2K2	4	t
14	Entregador Teste 2	entregador.teste2@email.com	83999990002	$2b$10$ZFLhNect1zczUgktdSf9zObcYA/k2PP3iDr7FHQm.uvyDYDDBvEu2	4	f
\.


--
-- TOC entry 5295 (class 0 OID 0)
-- Dependencies: 257
-- Name: avaliacao_id_avaliacao_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.avaliacao_id_avaliacao_seq', 2, true);


--
-- TOC entry 5296 (class 0 OID 0)
-- Dependencies: 231
-- Name: categoria_id_categoria_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categoria_id_categoria_seq', 3, true);


--
-- TOC entry 5297 (class 0 OID 0)
-- Dependencies: 237
-- Name: complemento_id_complemento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.complemento_id_complemento_seq', 4, true);


--
-- TOC entry 5298 (class 0 OID 0)
-- Dependencies: 239
-- Name: endereco_id_endereco_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.endereco_id_endereco_seq', 5, true);


--
-- TOC entry 5299 (class 0 OID 0)
-- Dependencies: 241
-- Name: endereco_loja_id_endereco_loja_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.endereco_loja_id_endereco_loja_seq', 2, true);


--
-- TOC entry 5300 (class 0 OID 0)
-- Dependencies: 229
-- Name: faixa_entrega_id_faixa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.faixa_entrega_id_faixa_seq', 8, true);


--
-- TOC entry 5301 (class 0 OID 0)
-- Dependencies: 227
-- Name: forma_pagamento_loja_id_forma_pagamento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.forma_pagamento_loja_id_forma_pagamento_seq', 1, false);


--
-- TOC entry 5302 (class 0 OID 0)
-- Dependencies: 235
-- Name: grupo_complemento_id_grupo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.grupo_complemento_id_grupo_seq', 3, true);


--
-- TOC entry 5303 (class 0 OID 0)
-- Dependencies: 251
-- Name: historico_atribuicao_entregador_id_historico_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.historico_atribuicao_entregador_id_historico_seq', 3, true);


--
-- TOC entry 5304 (class 0 OID 0)
-- Dependencies: 249
-- Name: historico_status_pedido_id_historico_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.historico_status_pedido_id_historico_seq', 44, true);


--
-- TOC entry 5305 (class 0 OID 0)
-- Dependencies: 225
-- Name: horario_funcionamento_id_horario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.horario_funcionamento_id_horario_seq', 6, true);


--
-- TOC entry 5306 (class 0 OID 0)
-- Dependencies: 223
-- Name: loja_id_loja_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.loja_id_loja_seq', 3, true);


--
-- TOC entry 5307 (class 0 OID 0)
-- Dependencies: 255
-- Name: notificacao_id_notificacao_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notificacao_id_notificacao_seq', 1, true);


--
-- TOC entry 5308 (class 0 OID 0)
-- Dependencies: 253
-- Name: oferta_entrega_id_oferta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oferta_entrega_id_oferta_seq', 7, true);


--
-- TOC entry 5309 (class 0 OID 0)
-- Dependencies: 243
-- Name: pedido_id_pedido_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pedido_id_pedido_seq', 12, true);


--
-- TOC entry 5310 (class 0 OID 0)
-- Dependencies: 247
-- Name: pedido_item_complemento_id_pedido_item_complemento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pedido_item_complemento_id_pedido_item_complemento_seq', 1, false);


--
-- TOC entry 5311 (class 0 OID 0)
-- Dependencies: 245
-- Name: pedido_item_id_pedido_item_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pedido_item_id_pedido_item_seq', 12, true);


--
-- TOC entry 5312 (class 0 OID 0)
-- Dependencies: 219
-- Name: perfil_id_perfil_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.perfil_id_perfil_seq', 4, true);


--
-- TOC entry 5313 (class 0 OID 0)
-- Dependencies: 233
-- Name: produto_id_produto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produto_id_produto_seq', 5, true);


--
-- TOC entry 5314 (class 0 OID 0)
-- Dependencies: 221
-- Name: usuario_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_id_usuario_seq', 14, true);


--
-- TOC entry 5048 (class 2606 OID 26303)
-- Name: avaliacao avaliacao_id_pedido_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avaliacao
    ADD CONSTRAINT avaliacao_id_pedido_key UNIQUE (id_pedido);


--
-- TOC entry 5050 (class 2606 OID 26301)
-- Name: avaliacao avaliacao_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avaliacao
    ADD CONSTRAINT avaliacao_pkey PRIMARY KEY (id_avaliacao);


--
-- TOC entry 5019 (class 2606 OID 17907)
-- Name: categoria categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (id_categoria);


--
-- TOC entry 5025 (class 2606 OID 17965)
-- Name: complemento complemento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.complemento
    ADD CONSTRAINT complemento_pkey PRIMARY KEY (id_complemento);


--
-- TOC entry 5030 (class 2606 OID 18007)
-- Name: endereco_loja endereco_loja_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endereco_loja
    ADD CONSTRAINT endereco_loja_pkey PRIMARY KEY (id_endereco_loja);


--
-- TOC entry 5027 (class 2606 OID 17989)
-- Name: endereco endereco_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endereco
    ADD CONSTRAINT endereco_pkey PRIMARY KEY (id_endereco);


--
-- TOC entry 5017 (class 2606 OID 17892)
-- Name: faixa_entrega faixa_entrega_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faixa_entrega
    ADD CONSTRAINT faixa_entrega_pkey PRIMARY KEY (id_faixa);


--
-- TOC entry 5015 (class 2606 OID 17876)
-- Name: forma_pagamento_loja forma_pagamento_loja_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forma_pagamento_loja
    ADD CONSTRAINT forma_pagamento_loja_pkey PRIMARY KEY (id_forma_pagamento);


--
-- TOC entry 5023 (class 2606 OID 17947)
-- Name: grupo_complemento grupo_complemento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grupo_complemento
    ADD CONSTRAINT grupo_complemento_pkey PRIMARY KEY (id_grupo);


--
-- TOC entry 5042 (class 2606 OID 26204)
-- Name: historico_atribuicao_entregador historico_atribuicao_entregador_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historico_atribuicao_entregador
    ADD CONSTRAINT historico_atribuicao_entregador_pkey PRIMARY KEY (id_historico);


--
-- TOC entry 5040 (class 2606 OID 26176)
-- Name: historico_status_pedido historico_status_pedido_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historico_status_pedido
    ADD CONSTRAINT historico_status_pedido_pkey PRIMARY KEY (id_historico);


--
-- TOC entry 5013 (class 2606 OID 17860)
-- Name: horario_funcionamento horario_funcionamento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.horario_funcionamento
    ADD CONSTRAINT horario_funcionamento_pkey PRIMARY KEY (id_horario);


--
-- TOC entry 5011 (class 2606 OID 17842)
-- Name: loja loja_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loja
    ADD CONSTRAINT loja_pkey PRIMARY KEY (id_loja);


--
-- TOC entry 5046 (class 2606 OID 26275)
-- Name: notificacao notificacao_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notificacao
    ADD CONSTRAINT notificacao_pkey PRIMARY KEY (id_notificacao);


--
-- TOC entry 5044 (class 2606 OID 26249)
-- Name: oferta_entrega oferta_entrega_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oferta_entrega
    ADD CONSTRAINT oferta_entrega_pkey PRIMARY KEY (id_oferta);


--
-- TOC entry 5038 (class 2606 OID 18103)
-- Name: pedido_item_complemento pedido_item_complemento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido_item_complemento
    ADD CONSTRAINT pedido_item_complemento_pkey PRIMARY KEY (id_pedido_item_complemento);


--
-- TOC entry 5036 (class 2606 OID 18080)
-- Name: pedido_item pedido_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido_item
    ADD CONSTRAINT pedido_item_pkey PRIMARY KEY (id_pedido_item);


--
-- TOC entry 5034 (class 2606 OID 18046)
-- Name: pedido pedido_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_pkey PRIMARY KEY (id_pedido);


--
-- TOC entry 5004 (class 2606 OID 17804)
-- Name: perfil perfil_nome_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil
    ADD CONSTRAINT perfil_nome_key UNIQUE (nome);


--
-- TOC entry 5006 (class 2606 OID 17802)
-- Name: perfil perfil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil
    ADD CONSTRAINT perfil_pkey PRIMARY KEY (id_perfil);


--
-- TOC entry 5021 (class 2606 OID 17927)
-- Name: produto produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (id_produto);


--
-- TOC entry 5032 (class 2606 OID 18009)
-- Name: endereco_loja uq_endereco_loja; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endereco_loja
    ADD CONSTRAINT uq_endereco_loja UNIQUE (id_endereco, id_loja);


--
-- TOC entry 5009 (class 2606 OID 17817)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 5028 (class 1259 OID 17995)
-- Name: idx_endereco_favorito; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_endereco_favorito ON public.endereco USING btree (id_usuario) WHERE ((favorito = true) AND (ativo = true));


--
-- TOC entry 5007 (class 1259 OID 17823)
-- Name: uq_usuario_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX uq_usuario_email ON public.usuario USING btree (lower((email)::text));


--
-- TOC entry 5081 (class 2606 OID 26304)
-- Name: avaliacao fk_avaliacao_pedido; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avaliacao
    ADD CONSTRAINT fk_avaliacao_pedido FOREIGN KEY (id_pedido) REFERENCES public.pedido(id_pedido);


--
-- TOC entry 5082 (class 2606 OID 26309)
-- Name: avaliacao fk_avaliacao_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avaliacao
    ADD CONSTRAINT fk_avaliacao_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 5056 (class 2606 OID 17908)
-- Name: categoria fk_categoria_loja; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT fk_categoria_loja FOREIGN KEY (id_loja) REFERENCES public.loja(id_loja);


--
-- TOC entry 5059 (class 2606 OID 17966)
-- Name: complemento fk_complemento_grupo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.complemento
    ADD CONSTRAINT fk_complemento_grupo FOREIGN KEY (id_grupo) REFERENCES public.grupo_complemento(id_grupo);


--
-- TOC entry 5061 (class 2606 OID 18010)
-- Name: endereco_loja fk_endereco_loja_endereco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endereco_loja
    ADD CONSTRAINT fk_endereco_loja_endereco FOREIGN KEY (id_endereco) REFERENCES public.endereco(id_endereco);


--
-- TOC entry 5062 (class 2606 OID 18015)
-- Name: endereco_loja fk_endereco_loja_loja; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endereco_loja
    ADD CONSTRAINT fk_endereco_loja_loja FOREIGN KEY (id_loja) REFERENCES public.loja(id_loja);


--
-- TOC entry 5060 (class 2606 OID 17990)
-- Name: endereco fk_endereco_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endereco
    ADD CONSTRAINT fk_endereco_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 5055 (class 2606 OID 17893)
-- Name: faixa_entrega fk_faixa_loja; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faixa_entrega
    ADD CONSTRAINT fk_faixa_loja FOREIGN KEY (id_loja) REFERENCES public.loja(id_loja);


--
-- TOC entry 5054 (class 2606 OID 17877)
-- Name: forma_pagamento_loja fk_forma_pagamento_loja; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forma_pagamento_loja
    ADD CONSTRAINT fk_forma_pagamento_loja FOREIGN KEY (id_loja) REFERENCES public.loja(id_loja);


--
-- TOC entry 5058 (class 2606 OID 17948)
-- Name: grupo_complemento fk_grupo_produto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grupo_complemento
    ADD CONSTRAINT fk_grupo_produto FOREIGN KEY (id_produto) REFERENCES public.produto(id_produto);


--
-- TOC entry 5073 (class 2606 OID 26210)
-- Name: historico_atribuicao_entregador fk_historico_atribuicao_entregador_anterior; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historico_atribuicao_entregador
    ADD CONSTRAINT fk_historico_atribuicao_entregador_anterior FOREIGN KEY (id_entregador_anterior) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 5074 (class 2606 OID 26215)
-- Name: historico_atribuicao_entregador fk_historico_atribuicao_entregador_novo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historico_atribuicao_entregador
    ADD CONSTRAINT fk_historico_atribuicao_entregador_novo FOREIGN KEY (id_entregador_novo) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 5075 (class 2606 OID 26205)
-- Name: historico_atribuicao_entregador fk_historico_atribuicao_pedido; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historico_atribuicao_entregador
    ADD CONSTRAINT fk_historico_atribuicao_pedido FOREIGN KEY (id_pedido) REFERENCES public.pedido(id_pedido);


--
-- TOC entry 5076 (class 2606 OID 26220)
-- Name: historico_atribuicao_entregador fk_historico_atribuicao_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historico_atribuicao_entregador
    ADD CONSTRAINT fk_historico_atribuicao_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 5053 (class 2606 OID 17861)
-- Name: horario_funcionamento fk_horario_loja; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.horario_funcionamento
    ADD CONSTRAINT fk_horario_loja FOREIGN KEY (id_loja) REFERENCES public.loja(id_loja);


--
-- TOC entry 5052 (class 2606 OID 17843)
-- Name: loja fk_loja_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loja
    ADD CONSTRAINT fk_loja_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 5063 (class 2606 OID 18057)
-- Name: pedido fk_pedido_endereco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT fk_pedido_endereco FOREIGN KEY (id_endereco) REFERENCES public.endereco(id_endereco);


--
-- TOC entry 5064 (class 2606 OID 26188)
-- Name: pedido fk_pedido_entregador; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT fk_pedido_entregador FOREIGN KEY (id_entregador) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 5069 (class 2606 OID 18109)
-- Name: pedido_item_complemento fk_pedido_item_complemento_complemento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido_item_complemento
    ADD CONSTRAINT fk_pedido_item_complemento_complemento FOREIGN KEY (id_complemento) REFERENCES public.complemento(id_complemento);


--
-- TOC entry 5070 (class 2606 OID 18104)
-- Name: pedido_item_complemento fk_pedido_item_complemento_item; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido_item_complemento
    ADD CONSTRAINT fk_pedido_item_complemento_item FOREIGN KEY (id_pedido_item) REFERENCES public.pedido_item(id_pedido_item);


--
-- TOC entry 5067 (class 2606 OID 18081)
-- Name: pedido_item fk_pedido_item_pedido; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido_item
    ADD CONSTRAINT fk_pedido_item_pedido FOREIGN KEY (id_pedido) REFERENCES public.pedido(id_pedido);


--
-- TOC entry 5068 (class 2606 OID 18086)
-- Name: pedido_item fk_pedido_item_produto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido_item
    ADD CONSTRAINT fk_pedido_item_produto FOREIGN KEY (id_produto) REFERENCES public.produto(id_produto);


--
-- TOC entry 5065 (class 2606 OID 18052)
-- Name: pedido fk_pedido_loja; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT fk_pedido_loja FOREIGN KEY (id_loja) REFERENCES public.loja(id_loja);


--
-- TOC entry 5066 (class 2606 OID 18047)
-- Name: pedido fk_pedido_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT fk_pedido_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 5057 (class 2606 OID 17928)
-- Name: produto fk_produto_categoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT fk_produto_categoria FOREIGN KEY (id_categoria) REFERENCES public.categoria(id_categoria);


--
-- TOC entry 5051 (class 2606 OID 17818)
-- Name: usuario fk_usuario_perfil; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT fk_usuario_perfil FOREIGN KEY (id_perfil) REFERENCES public.perfil(id_perfil);


--
-- TOC entry 5071 (class 2606 OID 26177)
-- Name: historico_status_pedido historico_status_pedido_id_pedido_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historico_status_pedido
    ADD CONSTRAINT historico_status_pedido_id_pedido_fkey FOREIGN KEY (id_pedido) REFERENCES public.pedido(id_pedido);


--
-- TOC entry 5072 (class 2606 OID 26182)
-- Name: historico_status_pedido historico_status_pedido_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historico_status_pedido
    ADD CONSTRAINT historico_status_pedido_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 5079 (class 2606 OID 26281)
-- Name: notificacao notificacao_id_pedido_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notificacao
    ADD CONSTRAINT notificacao_id_pedido_fkey FOREIGN KEY (id_pedido) REFERENCES public.pedido(id_pedido);


--
-- TOC entry 5080 (class 2606 OID 26276)
-- Name: notificacao notificacao_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notificacao
    ADD CONSTRAINT notificacao_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 5077 (class 2606 OID 26255)
-- Name: oferta_entrega oferta_entrega_id_entregador_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oferta_entrega
    ADD CONSTRAINT oferta_entrega_id_entregador_fkey FOREIGN KEY (id_entregador) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 5078 (class 2606 OID 26250)
-- Name: oferta_entrega oferta_entrega_id_pedido_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oferta_entrega
    ADD CONSTRAINT oferta_entrega_id_pedido_fkey FOREIGN KEY (id_pedido) REFERENCES public.pedido(id_pedido);


-- Completed on 2026-11-08 19:48:08

--
-- PostgreSQL database dump complete
--

\unrestrict OiD5hKhCqUBkuQibeeMwpd0EoEaPtziuzuKJknfIKr8NQFQNcORciR1TEUEZtdA

