-- TESTE PROCEDURES E TRIGGERS

-- CATEGORIA
-- Inserir
CALL CRUD_Categoria(NULL, 'Eletrônicos', 1);
-- Atualizar
CALL CRUD_Categoria(1, 'Eletrônicos Atualizado', 0);
-- Deletar
CALL CRUD_Categoria(1, NULL, -1);


-- FORNECEDOR
-- Inserir
CALL CRUD_Fornecedor(NULL, '12345678000195', 'Rua A, 123', 1);
-- Atualizar
CALL CRUD_Fornecedor(1, '12345678000196', 'Rua B, 456', 0);
-- Deletar
CALL CRUD_Fornecedor(1, NULL, -1);


-- DESCONTO
-- Inserir
CALL CRUD_Desconto(NULL, 'Desconto Especial', 15.00, 1);
-- Atualizar
CALL CRUD_Desconto(1, 'Desconto Atualizado', 20.00, 0);
-- Deletar
CALL CRUD_Desconto(1, NULL, -1);


-- PRODUTO
-- Inserir
CALL CRUD_Produto(NULL, 1, 1, 'Produto A', 'Descrição do Produto A', 'Marca X', 100.00, 1);
-- Atualizar
CALL CRUD_Produto(1, 1, 1, 'Produto A Atualizado', 'Descrição Atualizada', 'Marca Y', 150.00, 0);
-- Deletar
CALL CRUD_Produto(1, NULL, NULL, NULL, NULL, NULL, NULL, -1);


-- ESTOQUE
-- Inserir
CALL CRUD_Estoque(1, 50, 1);
-- Atualizar
CALL CRUD_Estoque(1, 75, 0);
-- Deletar
CALL CRUD_Estoque(1, NULL, -1);


-- CLIENTE
-- Inserir
CALL CRUD_Cliente(NULL, 'João', 'Silva', '123.456.789-00', 1);
-- Atualizar
CALL CRUD_Cliente(1, 'João Atualizado', 'Silva', '123.456.789-00', 0);
-- Deletar
CALL CRUD_Cliente(1, NULL, NULL, NULL, -1);


-- FUNCIONARIO
-- Inserir
CALL CRUD_Funcionario(NULL, 'Ana', 'Costa', '987.654.321-00', 1, 'anacosta', 'senha123', 1);
-- Atualizar
CALL CRUD_Funcionario(1, 'Ana Atualizada', 'Costa', '987.654.321-00', 0, 'anacosta', 'senha1234', 0);
-- Deletar
CALL CRUD_Funcionario(1, NULL, NULL, NULL, NULL, NULL, NULL, -1);


-- PEDIDO
-- Inserir
CALL CRUD_Pedido(NULL, 1, 1, CURRENT_TIMESTAMP, 5, 1);
-- Atualizar
CALL CRUD_Pedido(1, 1, 1, CURRENT_TIMESTAMP, 10, 0);
-- Deletar
CALL CRUD_Pedido(1, NULL, NULL, NULL, NULL, -1);


-- PAGAMENTO
-- Inserir
CALL CRUD_Pagamento(NULL, 1, 1, 1, 1, 1);
-- Deletar
CALL CRUD_Pagamento(1, NULL, NULL, NULL, NULL, -1);


-- Item_Pedido
-- Inserir
CALL CRUD_Item_Pedido(1, 1, 10, 1);
-- Deletar
CALL CRUD_Item_Pedido(1, 1, NULL, -1);


-- TESTE FUNCTIONS
-- Função Calcular_Valor_Total_Pagamento
SELECT Calcular_Valor_Total_Pagamento(1, NULL);

-- Função calcular_previsao_entrega
SELECT calcular_previsao_entrega(10);
