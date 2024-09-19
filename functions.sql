-- PAGAMENTO
-- CALCULAR VALOR TOTAL DO PAGAMENTO DE UM PEDIDO (COM DESCONTO, SE HOUVER)
CREATE OR REPLACE FUNCTION Calcular_Valor_Total_Pagamento(pedido_id_entrada INTEGER, desconto_id_entrada INTEGER) 
RETURNS NUMERIC AS $$
DECLARE
    desconto NUMERIC := 0;
    valor_total NUMERIC := 0;
    valor_produto NUMERIC;
    quantidade_item INTEGER;
BEGIN
    IF desconto_id_entrada IS NOT NULL THEN
        SELECT valor_desconto INTO desconto FROM Desconto
        WHERE desconto_id = desconto_id_entrada;
    	IF desconto IS NULL THEN
        	desconto := 0;
        END IF;
    END IF;
    
    FOR valor_produto, quantidade_item IN
        SELECT p.valor, ip.quantidade FROM Produto p
        INNER JOIN item_pedido ip ON p.produto_id = ip.produto_id
        WHERE ip.pedido_id = pedido_id_entrada
    LOOP
        valor_total := valor_total + (valor_produto * quantidade_item);
    END LOOP;
    valor_total := valor_total - desconto;
    RETURN valor_total;
END;
$$ LANGUAGE PLPGSQL;


-- PEDIDO
-- CALCULA PREVISÃO DE ENTREGA DE UM PEDIDO
CREATE OR REPLACE FUNCTION calcular_previsao_entrega(dias INTEGER) 
RETURNS TIMESTAMP AS $$
BEGIN
	RETURN CURRENT_TIMESTAMP + (dias || ' DAY')::INTERVAL;
END;
$$ LANGUAGE PLPGSQL;
