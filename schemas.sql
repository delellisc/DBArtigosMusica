CREATE TABLE categoria(
	categoria_id SERIAL PRIMARY KEY,
	nome TEXT,
	ultima_atualizacao TIMESTAMP
);
CREATE TABLE fornecedor(
	fornecedor_id SERIAL PRIMARY KEY,
	cnpj VARCHAR(18),
	endereco TEXT,
	ultima_atualizacao TIMESTAMP
);
CREATE TABLE desconto(
	desconto_id SERIAL PRIMARY KEY,
	titulo TEXT,
	valor_desconto NUMERIC
);
CREATE TABLE produto(
	produto_id SERIAL PRIMARY KEY,
	categoria_id INTEGER,
	fornecedor_id INTEGER,
	nome TEXT,
	descricao TEXT,
	marca TEXT,
	valor NUMERIC,
	ultima_atualizacao TIMESTAMP,
	FOREIGN KEY (categoria_id) REFERENCES categoria(categoria_id),
	FOREIGN KEY (fornecedor_id) REFERENCES fornecedor(fornecedor_id)
);
CREATE TABLE estoque(
	produto_id INTEGER,
	quantidade INTEGER,
	ultima_atualizacao TIMESTAMP,
	PRIMARY KEY (produto_id),
	FOREIGN KEY (produto_id) REFERENCES produto(produto_id)
);
CREATE TABLE cliente(
	cliente_id SERIAL PRIMARY KEY,
	nome TEXT,
	sobrenome TEXT,
	cpf VARCHAR(14),
	fidelidade NUMERIC,
	data_criacao TIMESTAMP,
	ultima_atualizacao TIMESTAMP
);
CREATE TABLE funcionario(
	funcionario_id SERIAL PRIMARY KEY,
	nome TEXT,
	sobrenome TEXT,
	cpf VARCHAR(14),
	ativo SMALLINT,
	login TEXT,
	senha TEXT,
	data_criacao TIMESTAMP,
	data_desligamento TIMESTAMP,
	ultima_atualizacao TIMESTAMP
);
CREATE TABLE pedido(
	pedido_id SERIAL PRIMARY KEY,
	funcionario_id INTEGER,
	cliente_id INTEGER,
	produto_id INTEGER,
	data_pedido TIMESTAMP,
	previsao_entrega TIMESTAMP,
	data_entrega TIMESTAMP,
	estoque_id INTEGER,
	ultima_atualizacao TIMESTAMP,
	FOREIGN KEY (funcionario_id) REFERENCES funcionario(funcionario_id),
	FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id),
	FOREIGN KEY (produto_id) REFERENCES produto(produto_id)
);
CREATE TABLE pagamento(
	pagamento_id SERIAL PRIMARY KEY,
	pedido_id INTEGER,
	funcionario_id INTEGER,
	cliente_id INTEGER,
	valor NUMERIC,
	data_pagamento TIMESTAMP,
	FOREIGN KEY (pedido_id) REFERENCES pedido(pedido_id)
);
CREATE TABLE item_pedido(
	pedido_id INTEGER,
	produto_id INTEGER,
	ultima_atualizacao TIMESTAMP,
	FOREIGN KEY (pedido_id) REFERENCES pedido(pedido_id),
	FOREIGN KEY (produto_id) REFERENCES produto(produto_id)
);
