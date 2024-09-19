CREATE TABLE categoria(
	categoria_id SERIAL PRIMARY KEY NOT NULL,
	nome TEXT NOT NULL,
	ultima_atualizacao TIMESTAMP
);
CREATE TABLE fornecedor(
	fornecedor_id SERIAL PRIMARY KEY NOT NULL,
	cnpj VARCHAR(18) UNIQUE NOT NULL,
	endereco TEXT NOT NULL,
	ultima_atualizacao TIMESTAMP NOT NULL
);
CREATE TABLE desconto(
	desconto_id SERIAL PRIMARY KEY NOT NULL,
	titulo TEXT NOT NULL,
	valor_desconto NUMERIC NOT NULL,
	ultima_atualizacao TIMESTAMP NOT NULL
);
CREATE TABLE produto(
	produto_id SERIAL PRIMARY KEY NOT NULL,
	categoria_id INTEGER NOT NULL,
	fornecedor_id INTEGER NOT NULL,
	nome TEXT NOT NULL,
	descricao TEXT NOT NULL,
	marca TEXT NOT NULL,
	valor NUMERIC NOT NULL,
	ultima_atualizacao TIMESTAMP NOT NULL,
	FOREIGN KEY (categoria_id) REFERENCES categoria(categoria_id),
	FOREIGN KEY (fornecedor_id) REFERENCES fornecedor(fornecedor_id)
);
CREATE TABLE estoque(
	produto_id INTEGER NOT NULL,
	quantidade INTEGER NOT NULL,
	ultima_atualizacao TIMESTAMP NOT NULL,
	PRIMARY KEY (produto_id),
	FOREIGN KEY (produto_id) REFERENCES produto(produto_id)
);
CREATE TABLE cliente(
	cliente_id SERIAL PRIMARY KEY NOT NULL,
	nome TEXT NOT NULL,
	sobrenome TEXT NOT NULL,
	cpf VARCHAR(14) UNIQUE NOT NULL,
	data_criacao TIMESTAMP NOT NULL,
	ultima_atualizacao TIMESTAMP NOT NULL
);
CREATE TABLE funcionario(
	funcionario_id SERIAL PRIMARY KEY NOT NULL,
	nome TEXT NOT NULL,
	sobrenome TEXT NOT NULL,
	cpf VARCHAR(14) UNIQUE NOT NULL,
	ativo SMALLINT NOT NULL,
	login TEXT NOT NULL,
	senha TEXT NOT NULL,
	data_criacao TIMESTAMP NOT NULL,
	data_desligamento TIMESTAMP,
	ultima_atualizacao TIMESTAMP NOT NULL
);
CREATE TABLE pedido(
	pedido_id SERIAL PRIMARY KEY NOT NULL,
	funcionario_id INTEGER NOT NULL,
	cliente_id INTEGER NOT NULL,
	data_pedido TIMESTAMP NOT NULL,
	previsao_entrega TIMESTAMP,
	data_entrega TIMESTAMP,
	ultima_atualizacao TIMESTAMP NOT NULL,
	FOREIGN KEY (funcionario_id) REFERENCES funcionario(funcionario_id),
	FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id)
);
CREATE TABLE pagamento(
	pagamento_id SERIAL PRIMARY KEY NOT NULL,
	pedido_id INTEGER NOT NULL,
	cliente_id INTEGER NOT NULL,
	funcionario_id INTEGER NOT NULL,
	desconto_id INTEGER NOT NULL,
	valor NUMERIC NOT NULL,
	data_pagamento TIMESTAMP NOT NULL,
	ultima_atualizacao TIMESTAMP NOT NULL,
	FOREIGN KEY (pedido_id) REFERENCES pedido(pedido_id),
	FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id),
	FOREIGN KEY (funcionario_id) REFERENCES funcionario(funcionario_id),
	FOREIGN KEY (desconto_id) REFERENCES desconto(desconto_id)
	
);
CREATE TABLE item_pedido(
	pedido_id INTEGER NOT NULL,
	produto_id INTEGER NOT NULL,
	quantidade INTEGER NOT NULL,
	ultima_atualizacao TIMESTAMP NOT NULL,
	PRIMARY KEY (pedido_id, produto_id),
	FOREIGN KEY (pedido_id) REFERENCES pedido(pedido_id),
	FOREIGN KEY (produto_id) REFERENCES produto(produto_id)
);
