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
-- Name: atualizar_quantidade_estoque(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.atualizar_quantidade_estoque() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE Estoque
    SET quantidade = quantidade - NEW.quantidade
    WHERE produto_id = NEW.produto_id;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.atualizar_quantidade_estoque() OWNER TO postgres;

--
-- Name: atualizar_ultima_atualizacao_categoria(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.atualizar_ultima_atualizacao_categoria() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.ultima_atualizacao = CURRENT_TIMESTAMP;
	RETURN NEW;
END;
$$;


ALTER FUNCTION public.atualizar_ultima_atualizacao_categoria() OWNER TO postgres;

--
-- Name: atualizar_ultima_atualizacao_cliente(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.atualizar_ultima_atualizacao_cliente() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.ultima_atualizacao = CURRENT_TIMESTAMP;
	RETURN NEW;
END;
$$;


ALTER FUNCTION public.atualizar_ultima_atualizacao_cliente() OWNER TO postgres;

--
-- Name: atualizar_ultima_atualizacao_desconto(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.atualizar_ultima_atualizacao_desconto() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.ultima_atualizacao = CURRENT_TIMESTAMP;
	RETURN NEW;
END;
$$;


ALTER FUNCTION public.atualizar_ultima_atualizacao_desconto() OWNER TO postgres;

--
-- Name: atualizar_ultima_atualizacao_estoque(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.atualizar_ultima_atualizacao_estoque() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.ultima_atualizacao = CURRENT_TIMESTAMP;
	RETURN NEW;
END;
$$;


ALTER FUNCTION public.atualizar_ultima_atualizacao_estoque() OWNER TO postgres;

--
-- Name: atualizar_ultima_atualizacao_fornecedor(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.atualizar_ultima_atualizacao_fornecedor() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.ultima_atualizacao = CURRENT_TIMESTAMP;
	RETURN NEW;
END;
$$;


ALTER FUNCTION public.atualizar_ultima_atualizacao_fornecedor() OWNER TO postgres;

--
-- Name: atualizar_ultima_atualizacao_funcionario(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.atualizar_ultima_atualizacao_funcionario() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.ultima_atualizacao = CURRENT_TIMESTAMP;
	RETURN NEW;
END;
$$;


ALTER FUNCTION public.atualizar_ultima_atualizacao_funcionario() OWNER TO postgres;

--
-- Name: atualizar_ultima_atualizacao_item_pedido(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.atualizar_ultima_atualizacao_item_pedido() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.ultima_atualizacao = CURRENT_TIMESTAMP;
	RETURN NEW;
END;
$$;


ALTER FUNCTION public.atualizar_ultima_atualizacao_item_pedido() OWNER TO postgres;

--
-- Name: atualizar_ultima_atualizacao_pagamento(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.atualizar_ultima_atualizacao_pagamento() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.ultima_atualizacao = CURRENT_TIMESTAMP;
	RETURN NEW;
END;
$$;


ALTER FUNCTION public.atualizar_ultima_atualizacao_pagamento() OWNER TO postgres;

--
-- Name: atualizar_ultima_atualizacao_pedido(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.atualizar_ultima_atualizacao_pedido() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.ultima_atualizacao = CURRENT_TIMESTAMP;
	RETURN NEW;
END;
$$;


ALTER FUNCTION public.atualizar_ultima_atualizacao_pedido() OWNER TO postgres;

--
-- Name: atualizar_ultima_atualizacao_produto(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.atualizar_ultima_atualizacao_produto() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.ultima_atualizacao = CURRENT_TIMESTAMP;
	RETURN NEW;
END;
$$;


ALTER FUNCTION public.atualizar_ultima_atualizacao_produto() OWNER TO postgres;

--
-- Name: calcular_previsao_entrega(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.calcular_previsao_entrega(dias integer) RETURNS timestamp without time zone
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN CURRENT_TIMESTAMP + (dias || ' DAY')::INTERVAL;
END;
$$;


ALTER FUNCTION public.calcular_previsao_entrega(dias integer) OWNER TO postgres;

--
-- Name: calcular_valor_total_pagamento(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.calcular_valor_total_pagamento(pedido_id_entrada integer, desconto_id_entrada integer) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE
    desconto NUMERIC := 0;
    valor_total NUMERIC := 0;
    valor_produto NUMERIC;
    quantidade_item INTEGER;
BEGIN
    IF desconto_id_entrada IS NOT NULL THEN
        SELECT valor_desconto INTO desconto FROM Desconto
        WHERE desconto_id = desconto_id_entrada;
    	IF desconto IS NULL THEN
        	desconto := 0;
        END IF;
    END IF;
    
    FOR valor_produto, quantidade_item IN
        SELECT p.valor, ip.quantidade FROM Produto p
        INNER JOIN item_pedido ip ON p.produto_id = ip.produto_id
        WHERE ip.pedido_id = pedido_id_entrada
    LOOP
        valor_total := valor_total + (valor_produto * quantidade_item);
    END LOOP;
    valor_total := valor_total - desconto;
    RETURN valor_total;
END;
$$;


ALTER FUNCTION public.calcular_valor_total_pagamento(pedido_id_entrada integer, desconto_id_entrada integer) OWNER TO postgres;

--
-- Name: crud_categoria(integer, text, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.crud_categoria(IN id_entrada integer, IN nome_entrada text, IN acao integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF acao = 1 THEN
		INSERT INTO Categoria(nome)
		VALUES (nome_entrada);
	ELSIF acao = 0 THEN
		UPDATE Categoria
		SET nome = nome_entrada
		WHERE categoria_id = id_entrada;
	ELSIF acao = -1 THEN
		DELETE FROM Categoria
		WHERE categoria_id = id_entrada;
	ELSE
		RAISE NOTICE 'AÇÃO INVÁLIDA! 1 - INSERIR || 0 - ATUALIZAR || -1 - DELETAR';
	END IF;
END;
$$;


ALTER PROCEDURE public.crud_categoria(IN id_entrada integer, IN nome_entrada text, IN acao integer) OWNER TO postgres;

--
-- Name: crud_cliente(integer, text, text, character varying, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.crud_cliente(IN id_entrada integer, IN nome_entrada text, IN sobrenome_entrada text, IN cpf_entrada character varying, IN acao integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF acao = 1 THEN
		INSERT INTO Cliente(nome, sobrenome, cpf, data_criacao)
		VALUES (nome_entrada, sobrenome_entrada, cpf_entrada, CURRENT_TIMESTAMP);
	ELSIF acao = 0 THEN
		UPDATE Cliente
		SET nome = nome_entrada,
			sobrenome = sobrenome_entrada, 
			cpf = cpf_entrada
		WHERE cliente_id = id_entrada;
	ELSIF acao = -1 THEN
		DELETE FROM Cliente
		WHERE cliente_id = id_entrada;
	ELSE
		RAISE NOTICE 'AÇÃO INVÁLIDA! 1 - INSERIR || 0 - ATUALIZAR || -1 - DELETAR';
	END IF;
END;
$$;


ALTER PROCEDURE public.crud_cliente(IN id_entrada integer, IN nome_entrada text, IN sobrenome_entrada text, IN cpf_entrada character varying, IN acao integer) OWNER TO postgres;

--
-- Name: crud_desconto(integer, text, numeric, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.crud_desconto(IN id_entrada integer, IN titulo_entrada text, IN valor_desconto_entrada numeric, IN acao integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF acao = 1 THEN
		INSERT INTO Desconto(titulo, valor_desconto)
		VALUES (titulo_entrada, valor_desconto_entrada);
	ELSIF acao = 0 THEN
		UPDATE Desconto
		SET titulo = titulo_entrada,
			valor_desconto = valor_desconto_entrada
		WHERE desconto_id = id_entrada;
	ELSIF acao = -1 THEN
		DELETE FROM Desconto
		WHERE desconto_id = id_entrada;
	ELSE
		RAISE NOTICE 'AÇÃO INVÁLIDA! 1 - INSERIR || 0 - ATUALIZAR || -1 - DELETAR';
	END IF;
END;
$$;


ALTER PROCEDURE public.crud_desconto(IN id_entrada integer, IN titulo_entrada text, IN valor_desconto_entrada numeric, IN acao integer) OWNER TO postgres;

--
-- Name: crud_estoque(integer, integer, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.crud_estoque(IN produto_id_entrada integer, IN quantidade_entrada integer, IN acao integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF acao = 1 THEN
		INSERT INTO Estoque(produto_id, quantidade)
		VALUES (produto_id_entrada, quantidade_entrada);
	ELSIF acao = 0 THEN
		UPDATE Estoque
		SET quantidade = quantidade_entrada
		WHERE produto_id = produto_id_entrada;
	ELSIF acao = -1 THEN
		DELETE FROM Estoque
		WHERE produto_id = produto_id_entrada;
	ELSE
		RAISE NOTICE 'AÇÃO INVÁLIDA! 1 - INSERIR || 0 - ATUALIZAR || -1 - DELETAR';
	END IF;
END;
$$;


ALTER PROCEDURE public.crud_estoque(IN produto_id_entrada integer, IN quantidade_entrada integer, IN acao integer) OWNER TO postgres;

--
-- Name: crud_fornecedor(integer, character varying, text, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.crud_fornecedor(IN id_entrada integer, IN cnpj_entrada character varying, IN endereco_entrada text, IN acao integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF acao = 1 THEN
		INSERT INTO Fornecedor(cnpj, endereco)
		VALUES (cnpj_entrada, endereco_entrada);
	ELSIF acao = 0 THEN
		UPDATE Fornecedor
		SET cnpj = cnpj_entrada,
			endereco = endereco_entrada
		WHERE fornecedor_id = id_entrada;
	ELSIF acao = -1 THEN
		DELETE FROM Fornecedor
		WHERE fornecedor_id = id_entrada;
	ELSE
		RAISE NOTICE 'AÇÃO INVÁLIDA! 1 - INSERIR || 0 - ATUALIZAR || -1 - DELETAR';
	END IF;
END;
$$;


ALTER PROCEDURE public.crud_fornecedor(IN id_entrada integer, IN cnpj_entrada character varying, IN endereco_entrada text, IN acao integer) OWNER TO postgres;

--
-- Name: crud_funcionario(integer, text, text, character varying, smallint, text, text, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.crud_funcionario(IN id_entrada integer, IN nome_entrada text, IN sobrenome_entrada text, IN cpf_entrada character varying, IN ativo_entrada smallint, IN login_entrada text, IN senha_entrada text, IN acao integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF acao = 1 THEN
		INSERT INTO Funcionario(nome, sobrenome, cpf, ativo, login, senha, data_criacao)
		VALUES (nome_entrada, sobrenome_entrada, cpf_entrada, ativo_entrada, login_entrada, senha_entrada, CURRENT_TIMESTAMP);
	ELSIF acao = 0 THEN
		UPDATE Funcionario
		SET nome = nome_entrada,
			sobrenome = sobrenome_entrada,
			cpf = cpf_entrada,
			ativo = ativo_entrada,
			login = login_entrada, 
			senha = senha_entrada
		WHERE funcionario_id = id_entrada;
	ELSIF acao = -1 THEN
		DELETE FROM Funcionario
		WHERE funcionario_id = id_entrada;
	ELSE
		RAISE NOTICE 'AÇÃO INVÁLIDA! 1 - INSERIR || 0 - ATUALIZAR || -1 - DELETAR';
	END IF;
END;
$$;


ALTER PROCEDURE public.crud_funcionario(IN id_entrada integer, IN nome_entrada text, IN sobrenome_entrada text, IN cpf_entrada character varying, IN ativo_entrada smallint, IN login_entrada text, IN senha_entrada text, IN acao integer) OWNER TO postgres;

--
-- Name: crud_item_pedido(integer, integer, integer, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.crud_item_pedido(IN pedido_id_entrada integer, IN produto_id_entrada integer, IN quantidade_entrada integer, IN acao integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF acao = 1 THEN
		INSERT INTO Item_Pedido(pedido_id, produto_id, quantidade)
		VALUES (pedido_id_entrada, produto_id_entrada, quantidade_entrada);
	ELSIF acao = -1 THEN
		DELETE FROM Item_Pedido
		WHERE pedido_id = pedido_id_entrada AND produto_id = produto_id_entrada;
	ELSE
		RAISE NOTICE 'AÇÃO INVÁLIDA! 1 - INSERIR || -1 - DELETAR';
	END IF;
END;
$$;


ALTER PROCEDURE public.crud_item_pedido(IN pedido_id_entrada integer, IN produto_id_entrada integer, IN quantidade_entrada integer, IN acao integer) OWNER TO postgres;

--
-- Name: crud_pagamento(integer, integer, integer, integer, integer, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.crud_pagamento(IN id_entrada integer, IN pedido_id_entrada integer, IN cliente_id_entrada integer, IN funcionario_id_entrada integer, IN desconto_id_entrada integer, IN acao integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF acao = 1 THEN
		INSERT INTO Pagamento(pedido_id, cliente_id, funcionario_id, desconto_id, valor, data_pagamento)
		VALUES (pedido_id_entrada, cliente_id_entrada, funcionario_id_entrada, desconto_id_entrada, Calcular_Valor_Total_Pagamento(pedido_id_entrada, desconto_id_entrada), CURRENT_TIMESTAMP);
	ELSIF acao = -1 THEN
		DELETE FROM Pagamento
		WHERE pagamento_id = id_entrada;
	ELSE
		RAISE NOTICE 'AÇÃO INVÁLIDA! 1 - INSERIR || -1 - DELETAR';
	END IF;
END;
$$;


ALTER PROCEDURE public.crud_pagamento(IN id_entrada integer, IN pedido_id_entrada integer, IN cliente_id_entrada integer, IN funcionario_id_entrada integer, IN desconto_id_entrada integer, IN acao integer) OWNER TO postgres;

--
-- Name: crud_pedido(integer, integer, integer, timestamp without time zone, integer, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.crud_pedido(IN id_entrada integer, IN funcionario_id_entrada integer, IN cliente_id_entrada integer, IN data_pedido_entrada timestamp without time zone, IN previsao_entrega_entrada integer, IN acao integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF acao = 1 THEN
		INSERT INTO Pedido(funcionario_id, cliente_id, data_pedido, previsao_entrega)
		VALUES (funcionario_id_entrada, cliente_id_entrada, CURRENT_TIMESTAMP, Calcular_Previsao_Entrega(previsao_entrega_entrada));
	ELSIF acao = 0 THEN
		UPDATE Pedido
		SET funcionario_id = funcionario_id_entrada,
			previsao_entrega = Calcular_Previsao_Entrega(previsao_entrega_entrada)
		WHERE pedido_id = id_entrada;
	ELSIF acao = -1 THEN
		DELETE FROM Pedido
		WHERE pedido_id = id_entrada;
	ELSE
		RAISE NOTICE 'AÇÃO INVÁLIDA! 1 - INSERIR || 0 - ATUALIZAR || -1 - DELETAR';
	END IF;
END;
$$;


ALTER PROCEDURE public.crud_pedido(IN id_entrada integer, IN funcionario_id_entrada integer, IN cliente_id_entrada integer, IN data_pedido_entrada timestamp without time zone, IN previsao_entrega_entrada integer, IN acao integer) OWNER TO postgres;

--
-- Name: crud_produto(integer, integer, integer, text, text, text, numeric, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.crud_produto(IN id_entrada integer, IN categoria_id_entrada integer, IN fornecedor_id_entrada integer, IN nome_entrada text, IN descricao_entrada text, IN marca_entrada text, IN valor_entrada numeric, IN acao integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF acao = 1 THEN
		INSERT INTO Produto(categoria_id, fornecedor_id, nome, descricao, marca, valor)
		VALUES (categoria_id_entrada, fornecedor_id_entrada, nome_entrada, descricao_entrada, marca_entrada, valor_entrada);
	ELSIF acao = 0 THEN
		UPDATE Produto
		SET categoria_id = categoria_id_entrada,
			fornecedor_id = fornecedor_id_entrada, 
			nome = nome_entrada, 
			descricao = descricao_entrada, 
			marca = marca_entrada, 
			valor = valor_entrada
		WHERE produto_id = id_entrada;
	ELSIF acao = -1 THEN
		DELETE FROM Produto
		WHERE produto_id = id_entrada;
	ELSE
		RAISE NOTICE 'AÇÃO INVÁLIDA! 1 - INSERIR || 0 - ATUALIZAR || -1 - DELETAR';
	END IF;
END;
$$;


ALTER PROCEDURE public.crud_produto(IN id_entrada integer, IN categoria_id_entrada integer, IN fornecedor_id_entrada integer, IN nome_entrada text, IN descricao_entrada text, IN marca_entrada text, IN valor_entrada numeric, IN acao integer) OWNER TO postgres;

--
-- Name: inserir_data_desligamento_funcionario(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.inserir_data_desligamento_funcionario() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.ativo = 0 THEN
        NEW.data_desligamento = CURRENT_TIMESTAMP;
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.inserir_data_desligamento_funcionario() OWNER TO postgres;

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
    nome text NOT NULL,
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
    nome text NOT NULL,
    sobrenome text NOT NULL,
    cpf character varying(14) NOT NULL,
    data_criacao timestamp without time zone NOT NULL,
    ultima_atualizacao timestamp without time zone NOT NULL
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
    titulo text NOT NULL,
    valor_desconto numeric NOT NULL,
    ultima_atualizacao timestamp without time zone NOT NULL
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
    quantidade integer NOT NULL,
    ultima_atualizacao timestamp without time zone NOT NULL
);


ALTER TABLE public.estoque OWNER TO postgres;

--
-- Name: fornecedor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fornecedor (
    fornecedor_id integer NOT NULL,
    cnpj character varying(18) NOT NULL,
    endereco text NOT NULL,
    ultima_atualizacao timestamp without time zone NOT NULL
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
    nome text NOT NULL,
    sobrenome text NOT NULL,
    cpf character varying(14) NOT NULL,
    ativo smallint NOT NULL,
    login text NOT NULL,
    senha text NOT NULL,
    data_criacao timestamp without time zone NOT NULL,
    data_desligamento timestamp without time zone,
    ultima_atualizacao timestamp without time zone NOT NULL
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
    quantidade integer NOT NULL,
    ultima_atualizacao timestamp without time zone NOT NULL
);


ALTER TABLE public.item_pedido OWNER TO postgres;

--
-- Name: pagamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pagamento (
    pagamento_id integer NOT NULL,
    pedido_id integer NOT NULL,
    cliente_id integer NOT NULL,
    funcionario_id integer NOT NULL,
    desconto_id integer NOT NULL,
    valor numeric NOT NULL,
    data_pagamento timestamp without time zone NOT NULL,
    ultima_atualizacao timestamp without time zone NOT NULL
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
    funcionario_id integer NOT NULL,
    cliente_id integer NOT NULL,
    data_pedido timestamp without time zone NOT NULL,
    previsao_entrega timestamp without time zone,
    data_entrega timestamp without time zone,
    ultima_atualizacao timestamp without time zone NOT NULL
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
    categoria_id integer NOT NULL,
    fornecedor_id integer NOT NULL,
    nome text NOT NULL,
    descricao text NOT NULL,
    marca text NOT NULL,
    valor numeric NOT NULL,
    ultima_atualizacao timestamp without time zone NOT NULL
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
1	Instrumentos Musicais	2024-09-19 11:09:57.662486
2	Equipamentos de Áudio	2024-09-19 11:09:57.662486
3	Acessórios	2024-09-19 11:09:57.662486
4	Mídias Musicais	2024-09-19 11:09:57.662486
\.


--
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cliente (cliente_id, nome, sobrenome, cpf, data_criacao, ultima_atualizacao) FROM stdin;
1	Eliezio	Soares	123.456.789-10	2024-09-19 11:09:57.662486	2024-09-19 11:09:57.662486
2	Moroni	Neres	987.654.321-00	2024-09-19 11:09:57.662486	2024-09-19 11:09:57.662486
3	Keylly	Eyglys	111.222.333-44	2024-09-19 11:09:57.662486	2024-09-19 11:09:57.662486
\.


--
-- Data for Name: desconto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.desconto (desconto_id, titulo, valor_desconto, ultima_atualizacao) FROM stdin;
1	Desconto de Inauguração	15.00	2024-09-19 11:09:57.662486
2	Desconto de Verão	20.00	2024-09-19 11:09:57.662486
3	Desconto de Músico Profissional	25.00	2024-09-19 11:09:57.662486
\.


--
-- Data for Name: estoque; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estoque (produto_id, quantidade, ultima_atualizacao) FROM stdin;
1	50	2024-09-19 11:09:57.662486
2	100	2024-09-19 11:09:57.662486
3	200	2024-09-19 11:09:57.662486
4	20	2024-09-19 11:09:57.662486
5	5	2024-09-19 11:09:57.662486
6	3	2024-09-19 11:09:57.662486
7	150	2024-09-19 11:09:57.662486
8	7	2024-09-19 11:09:57.662486
9	12	2024-09-19 11:09:57.662486
\.


--
-- Data for Name: fornecedor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fornecedor (fornecedor_id, cnpj, endereco, ultima_atualizacao) FROM stdin;
1	12.345.678/0001-90	Rua das Flores, 123, São Paulo	2024-09-19 11:09:57.662486
2	98.765.432/0001-10	Av. dos Andradas, 456, Belo Horizonte	2024-09-19 11:09:57.662486
3	11.222.333/0001-55	Praça da Liberdade, 789, Rio de Janeiro	2024-09-19 11:09:57.662486
4	55.444.333/0001-20	Rua XV de Novembro, 1010, Curitiba	2024-09-19 11:09:57.662486
5	66.777.888/0001-30	Av. Paulista, 1500, São Paulo	2024-09-19 11:09:57.662486
\.


--
-- Data for Name: funcionario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.funcionario (funcionario_id, nome, sobrenome, cpf, ativo, login, senha, data_criacao, data_desligamento, ultima_atualizacao) FROM stdin;
1	Thiago	Alves	333.444.555-66	1	thiago.alves	canalha123	2024-09-19 11:09:57.662486	\N	2024-09-19 11:09:57.662486
2	Ismaelly	Eyre	444.555.666-77	1	ismaelly.eyre	pegaavisao456	2024-09-19 11:09:57.662486	\N	2024-09-19 11:09:57.662486
3	Maria	Fernanda	555.666.777-88	1	maria.fernanda	nomenosabonete789	2024-09-19 11:09:57.662486	\N	2024-09-19 11:09:57.662486
\.


--
-- Data for Name: item_pedido; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.item_pedido (pedido_id, produto_id, quantidade, ultima_atualizacao) FROM stdin;
1	1	1	2024-09-19 11:09:57.662486
1	2	1	2024-09-19 11:09:57.662486
1	4	1	2024-09-19 11:09:57.662486
2	2	1	2024-09-19 11:09:57.662486
2	3	1	2024-09-19 11:09:57.662486
3	2	1	2024-09-19 11:09:57.662486
\.


--
-- Data for Name: pagamento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pagamento (pagamento_id, pedido_id, cliente_id, funcionario_id, desconto_id, valor, data_pagamento, ultima_atualizacao) FROM stdin;
1	1	1	1	1	1800.00	2024-09-19 11:09:57.662486	2024-09-19 11:09:57.662486
2	2	2	2	2	200.00	2024-09-19 11:09:57.662486	2024-09-19 11:09:57.662486
3	3	2	1	1	1200.00	2024-09-19 11:09:57.662486	2024-09-19 11:09:57.662486
\.


--
-- Data for Name: pedido; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pedido (pedido_id, funcionario_id, cliente_id, data_pedido, previsao_entrega, data_entrega, ultima_atualizacao) FROM stdin;
1	1	1	2024-09-19 11:09:57.662486	2024-09-26 11:09:57.662486	\N	2024-09-19 11:09:57.662486
2	2	2	2024-09-19 11:09:57.662486	2024-09-24 11:09:57.662486	\N	2024-09-19 11:09:57.662486
3	2	3	2024-09-19 11:09:57.662486	2024-09-24 11:09:57.662486	\N	2024-09-19 11:09:57.662486
\.


--
-- Data for Name: produto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produto (produto_id, categoria_id, fornecedor_id, nome, descricao, marca, valor, ultima_atualizacao) FROM stdin;
2	1	1	Ukulele Concert	Ukulele Concert Mogno	Shelby	260.00	2024-09-19 11:09:57.662486
3	2	2	Mesa de Som	Mesa de Som Analógica 16 canais	Yamaha	2500.00	2024-09-19 11:09:57.662486
4	3	3	Cabo P10	Cabo P10 de 3 metros	Santo Ângelo	50.00	2024-09-19 11:09:57.662486
5	4	1	Vinil The Beatles - Abbey Road	Álbum de vinil clássico dos Beatles	EMI	150.00	2024-09-19 11:09:57.662486
6	1	2	Violão Clássico	Violão de Nylon 39"	Yamaha	1200.00	2024-09-19 11:09:57.662486
7	2	3	Pedal de Distortion	Pedal Boss DS-1	Boss	450.00	2024-09-19 11:09:57.662486
8	3	4	Encordoamento para Guitarra	Encordoamento .010	Daddario	35.00	2024-09-19 11:09:57.662486
10	4	2	Vinil Pink Floyd - Dark Side of the Moon	Álbum de vinil clássico do Pink Floyd	EMI	180.00	2024-09-19 11:09:57.662486
1	1	1	Guitarra Elétrica	Guitarra Elétrica Stratocaster	Fender	3675.0000	2024-09-19 13:13:57.156793
9	1	5	Baixo Elétrico	Baixo Jazz Bass 4 cordas	Fender	2940.0000	2024-09-19 13:13:57.156793
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
-- Name: cliente cliente_cpf_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_cpf_key UNIQUE (cpf);


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
-- Name: fornecedor fornecedor_cnpj_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_cnpj_key UNIQUE (cnpj);


--
-- Name: fornecedor fornecedor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_pkey PRIMARY KEY (fornecedor_id);


--
-- Name: funcionario funcionario_cpf_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_cpf_key UNIQUE (cpf);


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
-- Name: item_pedido atualizar_quantidade_estoque; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER atualizar_quantidade_estoque AFTER INSERT OR UPDATE ON public.item_pedido FOR EACH ROW EXECUTE FUNCTION public.atualizar_quantidade_estoque();


--
-- Name: categoria atualizar_ultima_atualizacao_categoria; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER atualizar_ultima_atualizacao_categoria BEFORE INSERT OR UPDATE ON public.categoria FOR EACH ROW EXECUTE FUNCTION public.atualizar_ultima_atualizacao_categoria();


--
-- Name: cliente atualizar_ultima_atualizacao_cliente; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER atualizar_ultima_atualizacao_cliente BEFORE INSERT OR UPDATE ON public.cliente FOR EACH ROW EXECUTE FUNCTION public.atualizar_ultima_atualizacao_cliente();


--
-- Name: desconto atualizar_ultima_atualizacao_desconto; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER atualizar_ultima_atualizacao_desconto BEFORE INSERT OR UPDATE ON public.desconto FOR EACH ROW EXECUTE FUNCTION public.atualizar_ultima_atualizacao_desconto();


--
-- Name: estoque atualizar_ultima_atualizacao_estoque; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER atualizar_ultima_atualizacao_estoque BEFORE INSERT OR UPDATE ON public.estoque FOR EACH ROW EXECUTE FUNCTION public.atualizar_ultima_atualizacao_estoque();


--
-- Name: fornecedor atualizar_ultima_atualizacao_fornecedor; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER atualizar_ultima_atualizacao_fornecedor BEFORE INSERT OR UPDATE ON public.fornecedor FOR EACH ROW EXECUTE FUNCTION public.atualizar_ultima_atualizacao_fornecedor();


--
-- Name: funcionario atualizar_ultima_atualizacao_funcionario; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER atualizar_ultima_atualizacao_funcionario BEFORE INSERT OR UPDATE ON public.funcionario FOR EACH ROW EXECUTE FUNCTION public.atualizar_ultima_atualizacao_funcionario();


--
-- Name: item_pedido atualizar_ultima_atualizacao_item_pedido; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER atualizar_ultima_atualizacao_item_pedido BEFORE INSERT OR UPDATE ON public.item_pedido FOR EACH ROW EXECUTE FUNCTION public.atualizar_ultima_atualizacao_item_pedido();


--
-- Name: pagamento atualizar_ultima_atualizacao_pagamento; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER atualizar_ultima_atualizacao_pagamento BEFORE INSERT OR UPDATE ON public.pagamento FOR EACH ROW EXECUTE FUNCTION public.atualizar_ultima_atualizacao_pagamento();


--
-- Name: pedido atualizar_ultima_atualizacao_pedido; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER atualizar_ultima_atualizacao_pedido BEFORE INSERT OR UPDATE ON public.pedido FOR EACH ROW EXECUTE FUNCTION public.atualizar_ultima_atualizacao_pedido();


--
-- Name: produto atualizar_ultima_atualizacao_produto; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER atualizar_ultima_atualizacao_produto BEFORE INSERT OR UPDATE ON public.produto FOR EACH ROW EXECUTE FUNCTION public.atualizar_ultima_atualizacao_produto();


--
-- Name: funcionario inserir_data_desligamento_funcionario; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER inserir_data_desligamento_funcionario BEFORE UPDATE ON public.funcionario FOR EACH ROW WHEN ((old.ativo IS DISTINCT FROM new.ativo)) EXECUTE FUNCTION public.inserir_data_desligamento_funcionario();


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

