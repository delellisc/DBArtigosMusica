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

-- Thiago 
-- seleciona nome do produto, quantidade em estoque e cnpj do fornecedor
SELECT p.nome AS produto, e.quantidade AS quantidade_estoque, f.cnpj AS fornecedor
FROM produto p
INNER JOIN estoque e ON p.produto_id = e.produto_id
INNER JOIN fornecedor f ON p.fornecedor_id = f.fornecedor_id;

-- seleciona nome do produto, título do desconto aplicado e valor total do pagamento
SELECT pe.pedido_id AS pedido, STRING_AGG(p.nome, ', ') AS produtos, d.titulo AS desconto, pa.valor AS valor_pagamento
FROM pagamento pa
INNER JOIN pedido pe ON pa.pedido_id = pe.pedido_id
INNER JOIN item_pedido ip ON ip.pedido_id = pe.pedido_id
INNER JOIN produto p ON ip.produto_id = p.produto_id
INNER JOIN desconto d ON pa.desconto_id = d.desconto_id
GROUP BY pe.pedido_id, d.titulo, pa.valor;

-- seleciona nome do cliente, nome do produto e quantidade do item no pedido
SELECT c.nome AS cliente, p.nome AS produto, ip.quantidade AS quantidade
FROM item_pedido ip
INNER JOIN pedido pe ON ip.pedido_id = pe.pedido_id
INNER JOIN cliente c ON pe.cliente_id = c.cliente_id
INNER JOIN produto p ON ip.produto_id = p.produto_id;