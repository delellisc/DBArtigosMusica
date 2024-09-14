-- Fernanda
-- lista produtos com quantidade menor do que 10 no estoque
CREATE OR REPLACE FUNCTION listar_produtos_com_estoque_baixo()
RETURNS VOID AS $$
DECLARE
    cur_estoque_baixo CURSOR FOR
    SELECT p.produto_id, p.nome, e.quantidade
    FROM produto p
    JOIN estoque e ON p.produto_id = e.produto_id
    WHERE e.quantidade < 10;
    
    produto_id INTEGER;
    nome TEXT;
    quantidade INTEGER;
BEGIN
    OPEN cur_estoque_baixo;
    
    LOOP
        FETCH cur_estoque_baixo INTO produto_id, nome, quantidade;
        EXIT WHEN NOT FOUND;
        
        RAISE NOTICE 'Produto ID: %, Nome: %, Quantidade em estoque: %', produto_id, nome, quantidade;
    END LOOP;
    
    CLOSE cur_estoque_baixo;
END
$$ LANGUAGE plpgsql;
-- exemplo:
SELECT listar_produtos_com_estoque_baixo();

-- atualiza valor de produto com base em percentual por marca
CREATE OR REPLACE FUNCTION ajustar_valor_produtos_por_marca(
    p_marca TEXT,             -- Marca específica
    p_percentual NUMERIC      -- Percentual de ajuste (ex.: 1.10 para +10%, 0.90 para -10%)
)
RETURNS VOID AS $$
DECLARE
    cur_atualizar_produto CURSOR FOR
    SELECT produto_id, valor
    FROM produto
    WHERE marca = p_marca;

    id_produto INTEGER;
    valor_produto NUMERIC;
BEGIN
    OPEN cur_atualizar_produto;

    LOOP
        FETCH cur_atualizar_produto INTO id_produto, valor_produto;
        EXIT WHEN NOT FOUND;

        UPDATE produto
        SET valor = valor_produto * p_percentual,
            ultima_atualizacao = CURRENT_TIMESTAMP
        WHERE produto_id = id_produto;

        RAISE NOTICE 'Produto ID: %, Valor antigo: %, Valor novo: %', 
                     id_produto, valor_produto, valor_produto * p_percentual;
    END LOOP;

    CLOSE cur_atualizar_produto;
END
$$ LANGUAGE plpgsql;
-- exemplo:
SELECT ajustar_valor_produtos_por_marca('Fender', 1.05);