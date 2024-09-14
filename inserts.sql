-- Populando o banco de dados
INSERT INTO categoria (nome, ultima_atualizacao) VALUES
('Instrumentos Musicais', NOW()),
('Equipamentos de Áudio', NOW()),
('Acessórios', NOW()),
('Mídias Musicais', NOW());

INSERT INTO fornecedor (cnpj, endereco, ultima_atualizacao) VALUES
('12.345.678/0001-90', 'Rua das Flores, 123, São Paulo', NOW()),
('98.765.432/0001-10', 'Av. dos Andradas, 456, Belo Horizonte', NOW()),
('11.222.333/0001-55', 'Praça da Liberdade, 789, Rio de Janeiro', NOW()),
('55.444.333/0001-20', 'Rua XV de Novembro, 1010, Curitiba', NOW()),
('66.777.888/0001-30', 'Av. Paulista, 1500, São Paulo', NOW());

INSERT INTO desconto (titulo, valor_desconto) VALUES
('Desconto de Inauguração', 15.00),
('Desconto de Verão', 20.00),
('Desconto de Músico Profissional', 25.00);

INSERT INTO produto (categoria_id, fornecedor_id, nome, descricao, marca, valor, ultima_atualizacao) VALUES
(1, 1, 'Guitarra Elétrica', 'Guitarra Elétrica Stratocaster', 'Fender', 3500.00, NOW()),
(1, 1, 'Ukulele Concert', 'Ukulele Concert Mogno', 'Shelby', 260.00, NOW()),
(2, 2, 'Mesa de Som', 'Mesa de Som Analógica 16 canais', 'Yamaha', 2500.00, NOW()),
(3, 3, 'Cabo P10', 'Cabo P10 de 3 metros', 'Santo Ângelo', 50.00, NOW()),
(4, 1, 'Vinil The Beatles - Abbey Road', 'Álbum de vinil clássico dos Beatles', 'EMI', 150.00, NOW()),
(1, 2, 'Violão Clássico', 'Violão de Nylon 39"', 'Yamaha', 1200.00, NOW()),
(2, 3, 'Pedal de Distortion', 'Pedal Boss DS-1', 'Boss', 450.00, NOW()),
(3, 4, 'Encordoamento para Guitarra', 'Encordoamento .010', 'Daddario', 35.00, NOW()),
(1, 5, 'Baixo Elétrico', 'Baixo Jazz Bass 4 cordas', 'Fender', 2800.00, NOW()),
(4, 2, 'Vinil Pink Floyd - Dark Side of the Moon', 'Álbum de vinil clássico do Pink Floyd', 'EMI', 180.00, NOW());

INSERT INTO estoque (produto_id, quantidade, ultima_atualizacao) VALUES
(1, 50, NOW()),
(2, 100, NOW()),
(3, 200, NOW()),
(4, 20, NOW()),
(5, 5, NOW()),
(6, 3, NOW()),
(7, 150, NOW()),
(8, 7, NOW()),
(9, 12, NOW());

INSERT INTO cliente (nome, sobrenome, cpf, data_criacao, ultima_atualizacao) VALUES
('Eliezio', 'Soares', '123.456.789-10', NOW(), NOW()),
('Moroni', 'Neres', '987.654.321-00', NOW(), NOW()),
('Keylly', 'Eyglys', '111.222.333-44', NOW(), NOW());

INSERT INTO funcionario (nome, sobrenome, cpf, ativo, login, senha, data_criacao, ultima_atualizacao) VALUES
('Thiago', 'Alves', '333.444.555-66', 1, 'thiago.alves', 'canalha123', NOW(), NOW()),
('Ismaelly', 'Eyre', '444.555.666-77', 1, 'ismaelly.eyre', 'pegaavisao456', NOW(), NOW()),
('Maria', 'Fernanda', '555.666.777-88', 1, 'maria.fernanda', 'nomenosabonete789', NOW(), NOW());

INSERT INTO pedido (funcionario_id, cliente_id, produto_id, data_pedido, previsao_entrega, estoque_id, ultima_atualizacao) VALUES
(1, 1, 1, NOW(), NOW() + INTERVAL '7 days', 1, NOW()),
(2, 2, 2, NOW(), NOW() + INTERVAL '5 days', 2, NOW()),
(2, 3, 1, NOW(), NOW() + INTERVAL '5 days', 2, NOW());

INSERT INTO pagamento (pedido_id, funcionario_id, cliente_id, desconto_id, valor, data_pagamento) VALUES
(1, 1, 1, 1, 1800.00, NOW()),
(2, 2, 2, 2, 200.00, NOW()),
(3, 1, 2, 1, 1200.00, NOW());

INSERT INTO item_pedido (pedido_id, produto_id, quantidade, ultima_atualizacao) VALUES
(1, 1, 1, NOW()),
(1, 2, 1, NOW()),
(1, 4, 1, NOW()),
(2, 2, 1, NOW()),
(2, 3, 1, NOW()),
(3, 2, 1, NOW());
