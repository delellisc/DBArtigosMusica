-- populando banco de dados
INSERT INTO categoria (nome) VALUES
('Instrumentos Musicais'),
('Equipamentos de Áudio'),
('Acessórios'),
('Mídias Musicais');

INSERT INTO fornecedor (cnpj, endereco) VALUES
('12.345.678/0001-90', 'Rua das Flores, 123, São Paulo'),
('98.765.432/0001-10', 'Av. dos Andradas, 456, Belo Horizonte'),
('11.222.333/0001-55', 'Praça da Liberdade, 789, Rio de Janeiro');

INSERT INTO desconto (titulo, valor_desconto) VALUES
('Desconto de Inauguração', 15.00),
('Desconto de Verão', 20.00),
('Desconto de Músico Profissional', 25.00);

INSERT INTO produto (categoria_id, desconto_id, fornecedor_id, nome, descricao, marca, valor) VALUES
(1, 1, 1, 'Guitarra Elétrica', 'Guitarra Elétrica Stratocaster', 'Fender', 3500.00),
(1, 2, 1, 'Ukulele Concert', 'Ukulele Concert Mogno', 'Shelby', 260.00),
(2, 2, 2, 'Mesa de Som', 'Mesa de Som Analógica 16 canais', 'Yamaha', 2500.00),
(3, 3, 3, 'Cabo P10', 'Cabo P10 de 3 metros', 'Santo Ângelo', 50.00),
(4, NULL, 1, 'Vinil The Beatles - Abbey Road', 'Álbum de vinil clássico dos Beatles', 'EMI', 150.00);

INSERT INTO estoque (produto_id, quantidade) VALUES
(1, 50),
(2, 100),
(3, 200),
(4, 20);

INSERT INTO cliente (nome, sobrenome, cpf, fidelidade, data_criacao) VALUES
('João', 'Silva', '123.456.789-10', 50.00, NOW()),
('Maria', 'Oliveira', '987.654.321-00', 20.00, NOW()),
('Carlos', 'Santos', '111.222.333-44', 100.00, NOW());

INSERT INTO funcionario (nome, sobrenome, cpf, ativo, login, senha) VALUES
('Pedro', 'Almeida', '333.444.555-66', 1, 'pedro.almeida', 'senha123'),
('Ana', 'Costa', '444.555.666-77', 1, 'ana.costa', 'senha456'),
('Lucas', 'Pereira', '555.666.777-88', 0, 'lucas.pereira', 'senha789');

INSERT INTO pedido (funcionario_id, cliente_id, produto_id, data_pedido, previsao_entrega, data_entrega, estoque_id) VALUES
(1, 1, 1, NOW(), NOW() + INTERVAL '7 days', NULL, 1),
(2, 2, 2, NOW(), NOW() + INTERVAL '5 days', NULL, 2);

INSERT INTO pagamento (pedido_id, funcionario_id, cliente_id, valor, data_pagamento) VALUES
(1, 1, 1, 1800.00, NOW()),
(2, 2, 2, 200.00, NOW());

INSERT INTO item_pedido (pedido_id, produto_id) VALUES
(1, 1),
(2, 2);