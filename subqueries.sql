-- Fernanda
-- produtos acima da média de preço da categoria
SELECT p.produto_id, p.nome, p.valor, p.categoria_id
FROM produto p
WHERE p.valor > (
    SELECT AVG(p2.valor)
    FROM produto p2
    WHERE p2.categoria_id = p.categoria_id
);

-- produto mais vendido (acima da média em relação aos outros produtos)
SELECT p.nome, COUNT(ip.pedido_id) AS total_vendido
FROM produto p
JOIN item_pedido ip ON p.produto_id = ip.produto_id
GROUP BY p.nome
HAVING COUNT(ip.pedido_id) > (
    SELECT AVG(sub.total_vendido)
    FROM (
        SELECT COUNT(ip2.pedido_id) AS total_vendido
        FROM produto p2
        JOIN item_pedido ip2 ON p2.produto_id = ip2.produto_id
        GROUP BY p2.produto_id
    ) AS sub
);

-- cliente com maior valor gasto
SELECT c.nome, c.sobrenome, SUM(pg.valor) AS total_gasto
FROM cliente c
JOIN pedido pe ON c.cliente_id = pe.cliente_id
JOIN pagamento pg ON pe.pedido_id = pg.pedido_id
GROUP BY c.nome, c.sobrenome
HAVING SUM(pg.valor) = (
    SELECT MAX(total_gasto)
    FROM (
        SELECT SUM(pg2.valor) AS total_gasto
        FROM cliente c2
        JOIN pedido pe2 ON c2.cliente_id = pe2.cliente_id
        JOIN pagamento pg2 ON pe2.pedido_id = pg2.pedido_id
        GROUP BY c2.cliente_id
    ) AS sub
);
