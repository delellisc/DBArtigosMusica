-- Ismaelly
-- seleciona nome e categoria de um produto
SELECT p.nome AS produto, c.nome AS categoria
FROM produto p
INNER JOIN categoria c ON p.categoria_id = c.categoria_id;
-- seleciona cliente e funcionario envolvidos num pedido
SELECT pe.pedido_id, cl.nome AS cliente, f.nome AS funcionario
FROM pedido pe
INNER JOIN cliente cl ON pe.cliente_id = cl.cliente_id
INNER JOIN funcionario f ON pe.funcionario_id = f.funcionario_id;
-- seleciona valor e data de pagamento de um pedido
SELECT pe.pedido_id, pa.valor AS valor_pagamento, pa.data_pagamento
FROM pedido pe
INNER JOIN pagamento pa ON pa.pagamento_id = pa.pagamento_id;