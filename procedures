-- CATEGORIA
-- CRUD
CREATE OR REPLACE PROCEDURE CRUD_Categoria (
	id_entrada INTEGER,
	nome_entrada TEXT,
	acao INTEGER
	-- ultima_atualizacao TIMESTAMP
) AS $$
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
$$ LANGUAGE PLPGSQL;


-- FORNECEDOR
-- CRUD
CREATE OR REPLACE PROCEDURE CRUD_Fornecedor (
	id_entrada INTEGER,
	cnpj_entrada VARCHAR(18),
	endereco_entrada TEXT,
	acao INTEGER
	-- ultima_atualizacao TIMESTAMP
) AS $$
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
$$ LANGUAGE PLPGSQL;


-- DESCONTO
-- CRUD
CREATE OR REPLACE PROCEDURE CRUD_Desconto (
	id_entrada INTEGER,
	titulo_entrada TEXT,
	valor_desconto_entrada NUMERIC,
	acao INTEGER
	-- ultima_atualizacao TIMESTAMP
) AS $$
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
$$ LANGUAGE PLPGSQL;


-- PRODUTO
-- CRUD
CREATE OR REPLACE PROCEDURE CRUD_Produto (
	id_entrada INTEGER,
	categoria_id_entrada INTEGER,
	fornecedor_id_entrada INTEGER,
	nome_entrada TEXT,
	descricao_entrada TEXT,
	marca_entrada TEXT,
	valor_entrada NUMERIC,
	acao INTEGER
	-- ultima_atualizacao TIMESTAMP
) AS $$
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
$$ LANGUAGE PLPGSQL;


-- ESTOQUE
-- CRUD
CREATE OR REPLACE PROCEDURE CRUD_Estoque (
	produto_id_entrada INTEGER,
	quantidade_entrada INTEGER,
	acao INTEGER
	-- ultima_atualizacao TIMESTAMP
) AS $$
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
$$ LANGUAGE PLPGSQL;


-- CLIENTE
-- CRUD
CREATE OR REPLACE PROCEDURE CRUD_Cliente (
	id_entrada INTEGER,
	nome_entrada TEXT,
	sobrenome_entrada TEXT,
	cpf_entrada VARCHAR(14),
	acao INTEGER
	-- data_criacao_entrada TIMESTAMP,
	-- ultima_atualizacao TIMESTAMP
) AS $$
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
$$ LANGUAGE PLPGSQL;


-- FUNCIONARIO
-- CRUD
CREATE OR REPLACE PROCEDURE CRUD_Funcionario (
	id_entrada INTEGER,
	nome_entrada TEXT,
	sobrenome_entrada TEXT,
	cpf_entrada VARCHAR(14),
	ativo_entrada SMALLINT,
	login_entrada TEXT,
	senha_entrada TEXT,
	acao INTEGER
	-- data_criacao TIMESTAMP
	-- data_desligamento TIMESTAMP
	-- ultima_atualizacao TIMESTAMP
) AS $$
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
$$ LANGUAGE PLPGSQL;


-- PEDIDO
-- CRUD
CREATE OR REPLACE PROCEDURE CRUD_Pedido (
	id_entrada INTEGER,
	funcionario_id_entrada INTEGER,
	cliente_id_entrada INTEGER,
	data_pedido_entrada TIMESTAMP,
	previsao_entrega_entrada INTEGER,
	acao INTEGER
	-- ultima_atualizacao TIMESTAMP
) AS $$
BEGIN
	IF acao = 1 THEN
		INSERT INTO Pedido(funcionario_id, cliente_id, data_pedido, previsao_entrega)
		VALUES (funcionario_id_entrada, cliente_id_entrada, CURRENT_TIMESTAMP, Calcular_Previsao_Entrega(previsao_entrega_entrada);
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
$$ LANGUAGE PLPGSQL;


-- PAGAMENTO
-- CRUD
CREATE OR REPLACE PROCEDURE CRUD_Pagamento (
	id_entrada INTEGER,
	pedido_id_entrada INTEGER,
	cliente_id_entrada INTEGER,
	funcionario_id_entrada INTEGER,
	desconto_id_entrada INTEGER,
	acao INTEGER
) AS $$
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
$$ LANGUAGE PLPGSQL;


-- ITEM_PEDIDO
-- CRUD
CREATE OR REPLACE PROCEDURE CRUD_Item_Pedido (
	pedido_id_entrada INTEGER,
	produto_id_entrada INTEGER,
	quantidade_entrada INTEGER,
	acao INTEGER
	--ultima_atualizacao TIMESTAMP
) AS $$
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
$$ LANGUAGE PLPGSQL;
