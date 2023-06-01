-- QUERO OS 10 PRIMEIROS PRODUTOS DA TABELA Products
SELECT *
FROM Products
LIMIT 10 --Limite de linhas que vc gostaria de consultar. Mesma função do TOP 10 do SQL
 
---------------------------------------------------------------------------------------
-- QUERO SABER A SOMA O TOTAL DA SOMA ENTRE units_in_stock E unit_price
SELECT 
      product_name,
	  unit_price,
	  units_in_stock,
	  units_in_stock + unit_price as "Receita Total" -- Vc pode fazer operações matemáticas no select
FROM products

---------------------------------------------------------------------------------------
-- QUERO SABER QUEM SÃO OS FUNCIONARIOS NACIDOS NO ANO 1993
SELECT *
FROM Employees
WHERE hire_date >= '1993-01-01' and hire_date <= '1993-12-31'
LIMIT 10

---------------------------------------------------------------------------------------
-- QUERO SABER TODOS OS FUNCIONÁRIOS QUE ESTÃO TRABALHANDO DE LONDRES
SELECT *
FROM Employees
WHERE city = 'London'
LIMIT 10

---------------------------------------------------------------------------------------
-- QUERO SABER TODOS OS FUNCIONARIOS QUE SAO DA AREA DE VENDAS
SELECT *
FROM Employees
WHERE title LIKE '%Sales%'

---------------------------------------------------------------------------------------
-- QUERO SABER APENAS OS FUNCINARIO QUE COMEÇAS COM A LETRA M
SELECT *
FROM Employees
WHERE first_name LIKE 'M%'

---------------------------------------------------------------------------------------

-- EM UNIDADES, QUANTAS UNIDADES NO TOTAL FORAM VENDIDAS?

SELECT *, unit_price * quantity as "VALOR TOTAL CADA PRODUTO"
FROM order_details
IF (discount = '0.15')THEN
    "VALOR TOTAL CADA PRODUTO" * 0.15;
END IF	
GROUP BY  discount --CODIGO AINDA ESTA INCOMPLETO FALTA TERMINAR

---------------------------------------------------------------------------------------

-- FUNÇÕES AGREGADAS
  -- CONTAGEM  -- COUNT ()
  -- SOMA  -- SUM ()
  -- MEDIA
  -- MAXIMA
  -- MINIMA
  
-- QUERO SABER O TOTAL DE UNIDADES VENDIDAS?
SELECT SUM(quantity) AS "TOTAL DE UNIDADES VENDIDAS"
FROM order_details

---------------------------------------------------------------------------------------
  
-- QUERO SABER O TOTAL VENDIDO DE CADA PRODUTO?
SELECT product_id, SUM(quantity) AS "QUANTIDADE VENDIDA POR UNIDADE"
FROM order_details
GROUP BY product_id
ORDER BY "QUANTIDADE VENDIDA POR UNIDADE"

---------------------------------------------------------------------------------------
  
-- QUERO SABER QUANTAS VNDAS TIVEMOS NO MES
SELECT date_trunc('month', order_date) AS "DATA PEDIDOS DO MÊS", COUNT(order_id) AS "PEDIDOS DO MÊS"
FROM orders
GROUP BY order_date
ORDER BY order_date 

SELECT date_trunc('month', order_date) AS "DATA PEDIDOS DO MÊS", COUNT(order_id) AS "PEDIDOS DO MÊS"
FROM orders
GROUP BY "DATA PEDIDOS DO MÊS"
ORDER BY "DATA PEDIDOS DO MÊS"

---------------------------------------------------------------------------------------
  
-- QUERO SABER QUAIS OS PRODUTOS QUE EU VENDI MAIS DE 1000?
SELECT product_id, SUM(quantity) AS "UNIDADES VENDIDAS"
FROM order_details
GROUP BY product_id
HAVING SUM(quantity) >= 1000

---------------------------------------------------------------------------------------
  -- USANDO INNER JOIN
SELECT 
     product_name,
	 quantity_per_unit,
	 unit_price,
	 category_name,
	 description
FROM products
INNER JOIN categories ON categories.category_id = products.category_id

---------------------------------------------------------------------------------------
-- SUBCELECT (SUBQUERY)
-- FAÇA A COMPARAÇÃO DA MEDIA DE CADA PRODUTO DE CADA VENDA
SELECT *
FROM order_details
WHERE quantity >(
          SELECT AVG(quantity)
          FROM order_details
)

--OU POSSO RESPONDER ESTA PERGUNTA USANDO O COMANDO WITH
-- CTE (COMMON TABLE EXPRESSION) É UM CONJUNTO DE TABELAS QUE SO FUNCIONA ENQUANTO O SQL ESTA RODANDO
-- ESTAS TABELAS NÃO FICAM ARMAZENAS
WITH media AS (
          SELECT AVG(quantity) AS quantidade_media
          FROM order_details 
)
SELECT *
FROM order_details, media
WHERE quantity > media.quantidade_media

---------------------------------------------------------------------------------------

-- INDICES
CREATE INDEX idx_category ON products(category_id)  -- CRIAÇÃO DO INDICE NA COLUNA category_id

SELECT *
FROM products
WHERE category_id > 6   -- TESTANDO O INDICE CRIADO

