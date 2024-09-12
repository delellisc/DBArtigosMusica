-- Ismaelly
-- visualiza informações básicas de um pedido
CREATE VIEW resumo_simples AS
SELECT pe.pedido_id, cl.nome AS cliente, p.nome AS produto FROM pedido pe
INNER JOIN cliente cl ON pe.cliente_id = cl.cliente_id
INNER JOIN item_pedido ip ON pe.pedido_id = ip.pedido_id
INNER JOIN produto p ON ip.produto_id = p.produto_id;
-- seleciona a view
SELECT * FROM resumo_simples;