-- teste das procedures

CALL CRUD_Categoria(NULL, 'nome teste', 1);
CALL CRUD_Categoria(5, 'nome atualização', 0);
CALL CRUD_Categoria(5, NULL, -1);
select * from categoria;



CALL CRUD_Fornecedor(NULL, 'cnpj teste', 'endereço teste', 1);
CALL CRUD_Fornecedor(6, 'cnpj', 'endereço atualização', 0);
CALL CRUD_Fornecedor(6, NULL, NULL, -1);
select * from fornecedor;



CALL CRUD_Desconto(NULL, 'nome teste', 15.00, 1);
CALL CRUD_Desconto(4, 'nome atualização', 20.00, 0);
CALL CRUD_Desconto(4, NULL, NULL, -1);
select * from desconto;



CALL CRUD_Produto(NULL, 1, 1, 'nome teste', 'descrição teste', 'marca teste', 2000.00, 1);
CALL CRUD_Produto(11, 2, 2, 'nome atualização', 'descrição atualização', 'marca atualização', 2200.00, 0);
CALL CRUD_Produto(11, NULL, NULL, NULL, NULL, NULL, NULL, -1);
select * from produto;



CALL CRUD_Estoque(12, 100, 1);
CALL CRUD_Estoque(12, 150, 0);
CALL CRUD_Estoque(12, NULL, -1);
select p.nome,e.quantidade from estoque e inner join produto p on e.produto_id = p.produto_id;



CALL CRUD_Cliente(NULL, 'nome teste', 'sobrenome teste', 'cpf teste', 1);
CALL CRUD_Cliente(6, 'nome atualização', 'sobrenome atualização', 'cpf', 0);
CALL CRUD_Cliente(6, NULL, NULL, NULL, -1);
select * from cliente;



CALL CRUD_Funcionario(NULL, 'nome teste', 'teste', 'teste', 1, 'teste', 'teste', 1);
CALL CRUD_Funcionario(1, 'nome atualização', 'att', 'att', 1, 'att', 'att', 0);
CALL CRUD_Funcionario(1, NULL, NULL, NULL, NULL, NULL, NULL, -1);
select * from funcionario;



CALL CRUD_Pedido(NULL, 1, 1, NULL, 5, 1);
CALL CRUD_Pedido(4, 2, 1, NULL, 7, 0);
CALL CRUD_Pedido(4, NULL, NULL, NULL, NULL, -1);
select * from pedido;



CALL CRUD_Pagamento(NULL, 1, 1, 1, 1, 1);
CALL CRUD_Pagamento(4, NULL, NULL, NULL, NULL, -1);
select * from pagamento;



CALL CRUD_Item_Pedido(2, 4, 3, 1);
CALL CRUD_Item_Pedido(2, 1, NULL, -1);
select ip.pedido_id,p.produto_id, p.nome, ip.quantidade from item_pedido ip 
inner join produto p on ip.produto_id = p.produto_id order by pedido_id, quantidade;
