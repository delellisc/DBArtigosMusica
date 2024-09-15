-- Ismaelly
-- visualiza informações básicas de um pedido
CREATE VIEW resumo_simples AS
SELECT pe.pedido_id, cl.nome AS cliente, p.nome AS produto FROM pedido pe
INNER JOIN cliente cl ON pe.cliente_id = cl.cliente_id
INNER JOIN item_pedido ip ON pe.pedido_id = ip.pedido_id
INNER JOIN produto p ON ip.produto_id = p.produto_id;

-- seleciona a view
SELECT * FROM resumo_simples;

-- Thiago
-- visualiza informações de estoque e vendas
CREATE VIEW resumo_estoque_vendas AS
SELECT p.nome AS produto, e.quantidade AS quantidade_estoque, COALESCE(SUM(ip.quantidade), 0) AS quantidade_vendida
FROM produto p
INNER JOIN estoque e ON p.produto_id = e.produto_id
LEFT JOIN item_pedido ip ON p.produto_id = ip.produto_id
GROUP BY p.nome, e.quantidade;

-- seleciona a view
SELECT * FROM resumo_estoque_vendas;