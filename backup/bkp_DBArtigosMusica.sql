--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Ubuntu 16.4-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.4 (Ubuntu 16.4-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: ajustar_valor_produtos_por_marca(text, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ajustar_valor_produtos_por_marca(p_marca text, p_percentual numeric) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    cur_atualizar_produto CURSOR FOR
    SELECT produto_id, valor
    FROM produto
    WHERE marca = p_marca;

    id_produto INTEGER;
    valor_produto NUMERIC;
BEGIN
    OPEN cur_atualizar_produto;

    LOOP
        FETCH cur_atualizar_produto INTO id_produto, valor_produto;
        EXIT WHEN NOT FOUND;

        UPDATE produto
        SET valor = valor_produto * p_percentual,
            ultima_atualizacao = CURRENT_TIMESTAMP
        WHERE produto_id = id_produto;

        RAISE NOTICE 'Produto ID: %, Valor antigo: %, Valor novo: %', 
                     id_produto, valor_produto, valor_produto * p_percentual;
    END LOOP;

    CLOSE cur_atualizar_produto;
END
$$;


ALTER FUNCTION public.ajustar_valor_produtos_por_marca(p_marca text, p_percentual numeric) OWNER TO postgres;

--
-- Name: listar_produtos_com_estoque_baixo(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.listar_produtos_com_estoque_baixo() RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    cur_estoque_baixo CURSOR FOR
    SELECT p.produto_id, p.nome, e.quantidade
    FROM produto p
    JOIN estoque e ON p.produto_id = e.produto_id
    WHERE e.quantidade < 10;
    
    produto_id INTEGER;
    nome TEXT;
    quantidade INTEGER;
BEGIN
    OPEN cur_estoque_baixo;
    
    LOOP
        FETCH cur_estoque_baixo INTO produto_id, nome, quantidade;
        EXIT WHEN NOT FOUND;
        
        RAISE NOTICE 'Produto ID: %, Nome: %, Quantidade em estoque: %', produto_id, nome, quantidade;
    END LOOP;
    
    CLOSE cur_estoque_baixo;
END
$$;


ALTER FUNCTION public.listar_produtos_com_estoque_baixo() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: categoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categoria (
    categoria_id integer NOT NULL,
    nome text,
    ultima_atualizacao timestamp without time zone
);


ALTER TABLE public.categoria OWNER TO postgres;

--
-- Name: categoria_categoria_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categoria_categoria_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categoria_categoria_id_seq OWNER TO postgres;

--
-- Name: categoria_categoria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categoria_categoria_id_seq OWNED BY public.categoria.categoria_id;


--
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente (
    cliente_id integer NOT NULL,
    nome text,
    sobrenome text,
    cpf character varying(14),
    data_criacao timestamp without time zone,
    ultima_atualizacao timestamp without time zone
);


ALTER TABLE public.cliente OWNER TO postgres;

--
-- Name: cliente_cliente_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cliente_cliente_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cliente_cliente_id_seq OWNER TO postgres;

--
-- Name: cliente_cliente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cliente_cliente_id_seq OWNED BY public.cliente.cliente_id;


--
-- Name: desconto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.desconto (
    desconto_id integer NOT NULL,
    titulo text,
    valor_desconto numeric
);


ALTER TABLE public.desconto OWNER TO postgres;

--
-- Name: desconto_desconto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.desconto_desconto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.desconto_desconto_id_seq OWNER TO postgres;

--
-- Name: desconto_desconto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.desconto_desconto_id_seq OWNED BY public.desconto.desconto_id;


--
-- Name: estoque; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estoque (
    produto_id integer NOT NULL,
    quantidade integer,
    ultima_atualizacao timestamp without time zone
);


ALTER TABLE public.estoque OWNER TO postgres;

--
-- Name: fornecedor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fornecedor (
    fornecedor_id integer NOT NULL,
    cnpj character varying(18),
    endereco text,
    ultima_atualizacao timestamp without time zone
);


ALTER TABLE public.fornecedor OWNER TO postgres;

--
-- Name: fornecedor_fornecedor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fornecedor_fornecedor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fornecedor_fornecedor_id_seq OWNER TO postgres;

--
-- Name: fornecedor_fornecedor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fornecedor_fornecedor_id_seq OWNED BY public.fornecedor.fornecedor_id;


--
-- Name: funcionario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.funcionario (
    funcionario_id integer NOT NULL,
    nome text,
    sobrenome text,
    cpf character varying(14),
    ativo smallint,
    login text,
    senha text,
    data_criacao timestamp without time zone,
    data_desligamento timestamp without time zone,
    ultima_atualizacao timestamp without time zone
);


ALTER TABLE public.funcionario OWNER TO postgres;

--
-- Name: funcionario_funcionario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.funcionario_funcionario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.funcionario_funcionario_id_seq OWNER TO postgres;

--
-- Name: funcionario_funcionario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.funcionario_funcionario_id_seq OWNED BY public.funcionario.funcionario_id;


--
-- Name: item_pedido; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item_pedido (
    pedido_id integer NOT NULL,
    produto_id integer NOT NULL,
    quantidade integer,
    ultima_atualizacao timestamp without time zone
);


ALTER TABLE public.item_pedido OWNER TO postgres;

--
-- Name: pagamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pagamento (
    pagamento_id integer NOT NULL,
    pedido_id integer,
    cliente_id integer,
    funcionario_id integer,
    desconto_id integer,
    valor numeric,
    data_pagamento timestamp without time zone
);


ALTER TABLE public.pagamento OWNER TO postgres;

--
-- Name: pagamento_pagamento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pagamento_pagamento_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pagamento_pagamento_id_seq OWNER TO postgres;

--
-- Name: pagamento_pagamento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pagamento_pagamento_id_seq OWNED BY public.pagamento.pagamento_id;


--
-- Name: pedido; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pedido (
    pedido_id integer NOT NULL,
    funcionario_id integer,
    cliente_id integer,
    data_pedido timestamp without time zone,
    previsao_entrega timestamp without time zone,
    data_entrega timestamp without time zone,
    ultima_atualizacao timestamp without time zone
);


ALTER TABLE public.pedido OWNER TO postgres;

--
-- Name: pedido_pedido_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pedido_pedido_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pedido_pedido_id_seq OWNER TO postgres;

--
-- Name: pedido_pedido_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pedido_pedido_id_seq OWNED BY public.pedido.pedido_id;


--
-- Name: produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produto (
    produto_id integer NOT NULL,
    categoria_id integer,
    fornecedor_id integer,
    nome text,
    descricao text,
    marca text,
    valor numeric,
    ultima_atualizacao timestamp without time zone
);


ALTER TABLE public.produto OWNER TO postgres;

--
-- Name: produto_produto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.produto_produto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.produto_produto_id_seq OWNER TO postgres;

--
-- Name: produto_produto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.produto_produto_id_seq OWNED BY public.produto.produto_id;


--
-- Name: resumo_estoque_vendas; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.resumo_estoque_vendas AS
 SELECT p.nome AS produto,
    e.quantidade AS quantidade_estoque,
    COALESCE(sum(ip.quantidade), (0)::bigint) AS quantidade_vendida
   FROM ((public.produto p
     JOIN public.estoque e ON ((p.produto_id = e.produto_id)))
     LEFT JOIN public.item_pedido ip ON ((p.produto_id = ip.produto_id)))
  GROUP BY p.nome, e.quantidade;


ALTER VIEW public.resumo_estoque_vendas OWNER TO postgres;

--
-- Name: resumo_simples; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.resumo_simples AS
 SELECT pe.pedido_id,
    cl.nome AS cliente,
    p.nome AS produto
   FROM (((public.pedido pe
     JOIN public.cliente cl ON ((pe.cliente_id = cl.cliente_id)))
     JOIN public.item_pedido ip ON ((pe.pedido_id = ip.pedido_id)))
     JOIN public.produto p ON ((ip.produto_id = p.produto_id)));


ALTER VIEW public.resumo_simples OWNER TO postgres;

--
-- Name: categoria categoria_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria ALTER COLUMN categoria_id SET DEFAULT nextval('public.categoria_categoria_id_seq'::regclass);


--
-- Name: cliente cliente_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente ALTER COLUMN cliente_id SET DEFAULT nextval('public.cliente_cliente_id_seq'::regclass);


--
-- Name: desconto desconto_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.desconto ALTER COLUMN desconto_id SET DEFAULT nextval('public.desconto_desconto_id_seq'::regclass);


--
-- Name: fornecedor fornecedor_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fornecedor ALTER COLUMN fornecedor_id SET DEFAULT nextval('public.fornecedor_fornecedor_id_seq'::regclass);


--
-- Name: funcionario funcionario_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.funcionario ALTER COLUMN funcionario_id SET DEFAULT nextval('public.funcionario_funcionario_id_seq'::regclass);


--
-- Name: pagamento pagamento_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagamento ALTER COLUMN pagamento_id SET DEFAULT nextval('public.pagamento_pagamento_id_seq'::regclass);


--
-- Name: pedido pedido_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido ALTER COLUMN pedido_id SET DEFAULT nextval('public.pedido_pedido_id_seq'::regclass);


--
-- Name: produto produto_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto ALTER COLUMN produto_id SET DEFAULT nextval('public.produto_produto_id_seq'::regclass);


--
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categoria (categoria_id, nome, ultima_atualizacao) FROM stdin;
1	Instrumentos Musicais	2024-09-15 08:39:08.878418
2	Equipamentos de Áudio	2024-09-15 08:39:08.878418
3	Acessórios	2024-09-15 08:39:08.878418
4	Mídias Musicais	2024-09-15 08:39:08.878418
\.


--
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cliente (cliente_id, nome, sobrenome, cpf, data_criacao, ultima_atualizacao) FROM stdin;
1	Eliezio	Soares	123.456.789-10	2024-09-15 08:39:08.878418	2024-09-15 08:39:08.878418
2	Moroni	Neres	987.654.321-00	2024-09-15 08:39:08.878418	2024-09-15 08:39:08.878418
3	Keylly	Eyglys	111.222.333-44	2024-09-15 08:39:08.878418	2024-09-15 08:39:08.878418
\.


--
-- Data for Name: desconto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.desconto (desconto_id, titulo, valor_desconto) FROM stdin;
1	Desconto de Inauguração	15.00
2	Desconto de Verão	20.00
3	Desconto de Músico Profissional	25.00
\.


--
-- Data for Name: estoque; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estoque (produto_id, quantidade, ultima_atualizacao) FROM stdin;
1	50	2024-09-15 08:39:08.878418
2	100	2024-09-15 08:39:08.878418
3	200	2024-09-15 08:39:08.878418
4	20	2024-09-15 08:39:08.878418
5	5	2024-09-15 08:39:08.878418
6	3	2024-09-15 08:39:08.878418
7	150	2024-09-15 08:39:08.878418
8	7	2024-09-15 08:39:08.878418
9	12	2024-09-15 08:39:08.878418
\.


--
-- Data for Name: fornecedor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fornecedor (fornecedor_id, cnpj, endereco, ultima_atualizacao) FROM stdin;
1	12.345.678/0001-90	Rua das Flores, 123, São Paulo	2024-09-15 08:39:08.878418
2	98.765.432/0001-10	Av. dos Andradas, 456, Belo Horizonte	2024-09-15 08:39:08.878418
3	11.222.333/0001-55	Praça da Liberdade, 789, Rio de Janeiro	2024-09-15 08:39:08.878418
4	55.444.333/0001-20	Rua XV de Novembro, 1010, Curitiba	2024-09-15 08:39:08.878418
5	66.777.888/0001-30	Av. Paulista, 1500, São Paulo	2024-09-15 08:39:08.878418
\.


--
-- Data for Name: funcionario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.funcionario (funcionario_id, nome, sobrenome, cpf, ativo, login, senha, data_criacao, data_desligamento, ultima_atualizacao) FROM stdin;
1	Thiago	Alves	333.444.555-66	1	thiago.alves	canalha123	2024-09-15 08:39:08.878418	\N	2024-09-15 08:39:08.878418
2	Ismaelly	Eyre	444.555.666-77	1	ismaelly.eyre	pegaavisao456	2024-09-15 08:39:08.878418	\N	2024-09-15 08:39:08.878418
3	Maria	Fernanda	555.666.777-88	1	maria.fernanda	nomenosabonete789	2024-09-15 08:39:08.878418	\N	2024-09-15 08:39:08.878418
\.


--
-- Data for Name: item_pedido; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.item_pedido (pedido_id, produto_id, quantidade, ultima_atualizacao) FROM stdin;
1	1	1	2024-09-15 08:39:08.878418
1	2	1	2024-09-15 08:39:08.878418
1	4	1	2024-09-15 08:39:08.878418
2	2	1	2024-09-15 08:39:08.878418
2	3	1	2024-09-15 08:39:08.878418
3	2	1	2024-09-15 08:39:08.878418
\.


--
-- Data for Name: pagamento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pagamento (pagamento_id, pedido_id, cliente_id, funcionario_id, desconto_id, valor, data_pagamento) FROM stdin;
1	1	1	1	1	1800.00	2024-09-15 08:39:08.878418
2	2	2	2	2	200.00	2024-09-15 08:39:08.878418
3	3	2	1	1	1200.00	2024-09-15 08:39:08.878418
\.


--
-- Data for Name: pedido; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pedido (pedido_id, funcionario_id, cliente_id, data_pedido, previsao_entrega, data_entrega, ultima_atualizacao) FROM stdin;
1	1	1	2024-09-15 08:39:08.878418	2024-09-22 08:39:08.878418	\N	2024-09-15 08:39:08.878418
2	2	2	2024-09-15 08:39:08.878418	2024-09-20 08:39:08.878418	\N	2024-09-15 08:39:08.878418
3	2	3	2024-09-15 08:39:08.878418	2024-09-20 08:39:08.878418	\N	2024-09-15 08:39:08.878418
\.


--
-- Data for Name: produto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produto (produto_id, categoria_id, fornecedor_id, nome, descricao, marca, valor, ultima_atualizacao) FROM stdin;
2	1	1	Ukulele Concert	Ukulele Concert Mogno	Shelby	260.00	2024-09-15 08:39:08.878418
3	2	2	Mesa de Som	Mesa de Som Analógica 16 canais	Yamaha	2500.00	2024-09-15 08:39:08.878418
4	3	3	Cabo P10	Cabo P10 de 3 metros	Santo Ângelo	50.00	2024-09-15 08:39:08.878418
5	4	1	Vinil The Beatles - Abbey Road	Álbum de vinil clássico dos Beatles	EMI	150.00	2024-09-15 08:39:08.878418
6	1	2	Violão Clássico	Violão de Nylon 39"	Yamaha	1200.00	2024-09-15 08:39:08.878418
7	2	3	Pedal de Distortion	Pedal Boss DS-1	Boss	450.00	2024-09-15 08:39:08.878418
8	3	4	Encordoamento para Guitarra	Encordoamento .010	Daddario	35.00	2024-09-15 08:39:08.878418
10	4	2	Vinil Pink Floyd - Dark Side of the Moon	Álbum de vinil clássico do Pink Floyd	EMI	180.00	2024-09-15 08:39:08.878418
1	1	1	Guitarra Elétrica	Guitarra Elétrica Stratocaster	Fender	3675.0000	2024-09-15 08:52:11.26341
9	1	5	Baixo Elétrico	Baixo Jazz Bass 4 cordas	Fender	2940.0000	2024-09-15 08:52:11.26341
\.


--
-- Name: categoria_categoria_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categoria_categoria_id_seq', 4, true);


--
-- Name: cliente_cliente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cliente_cliente_id_seq', 3, true);


--
-- Name: desconto_desconto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.desconto_desconto_id_seq', 3, true);


--
-- Name: fornecedor_fornecedor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fornecedor_fornecedor_id_seq', 5, true);


--
-- Name: funcionario_funcionario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.funcionario_funcionario_id_seq', 3, true);


--
-- Name: pagamento_pagamento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pagamento_pagamento_id_seq', 3, true);


--
-- Name: pedido_pedido_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pedido_pedido_id_seq', 3, true);


--
-- Name: produto_produto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produto_produto_id_seq', 10, true);


--
-- Name: categoria categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (categoria_id);


--
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (cliente_id);


--
-- Name: desconto desconto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.desconto
    ADD CONSTRAINT desconto_pkey PRIMARY KEY (desconto_id);


--
-- Name: estoque estoque_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estoque
    ADD CONSTRAINT estoque_pkey PRIMARY KEY (produto_id);


--
-- Name: fornecedor fornecedor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_pkey PRIMARY KEY (fornecedor_id);


--
-- Name: funcionario funcionario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_pkey PRIMARY KEY (funcionario_id);


--
-- Name: item_pedido item_pedido_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_pedido
    ADD CONSTRAINT item_pedido_pkey PRIMARY KEY (pedido_id, produto_id);


--
-- Name: pagamento pagamento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagamento
    ADD CONSTRAINT pagamento_pkey PRIMARY KEY (pagamento_id);


--
-- Name: pedido pedido_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_pkey PRIMARY KEY (pedido_id);


--
-- Name: produto produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (produto_id);


--
-- Name: estoque estoque_produto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estoque
    ADD CONSTRAINT estoque_produto_id_fkey FOREIGN KEY (produto_id) REFERENCES public.produto(produto_id);


--
-- Name: item_pedido item_pedido_pedido_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_pedido
    ADD CONSTRAINT item_pedido_pedido_id_fkey FOREIGN KEY (pedido_id) REFERENCES public.pedido(pedido_id);


--
-- Name: item_pedido item_pedido_produto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_pedido
    ADD CONSTRAINT item_pedido_produto_id_fkey FOREIGN KEY (produto_id) REFERENCES public.produto(produto_id);


--
-- Name: pagamento pagamento_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagamento
    ADD CONSTRAINT pagamento_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.cliente(cliente_id);


--
-- Name: pagamento pagamento_desconto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagamento
    ADD CONSTRAINT pagamento_desconto_id_fkey FOREIGN KEY (desconto_id) REFERENCES public.desconto(desconto_id);


--
-- Name: pagamento pagamento_funcionario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagamento
    ADD CONSTRAINT pagamento_funcionario_id_fkey FOREIGN KEY (funcionario_id) REFERENCES public.funcionario(funcionario_id);


--
-- Name: pagamento pagamento_pedido_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagamento
    ADD CONSTRAINT pagamento_pedido_id_fkey FOREIGN KEY (pedido_id) REFERENCES public.pedido(pedido_id);


--
-- Name: pedido pedido_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.cliente(cliente_id);


--
-- Name: pedido pedido_funcionario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_funcionario_id_fkey FOREIGN KEY (funcionario_id) REFERENCES public.funcionario(funcionario_id);


--
-- Name: produto produto_categoria_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_categoria_id_fkey FOREIGN KEY (categoria_id) REFERENCES public.categoria(categoria_id);


--
-- Name: produto produto_fornecedor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_fornecedor_id_fkey FOREIGN KEY (fornecedor_id) REFERENCES public.fornecedor(fornecedor_id);


--
-- PostgreSQL database dump complete
--

