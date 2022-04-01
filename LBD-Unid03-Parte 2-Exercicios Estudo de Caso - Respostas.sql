------------------------------------
-- Laboratorio de Banco de Dados
-- Escola Politecnica - PUCRS
------------------------------------

---------------------------------------------------------------------------------------------------------------------
-- Exercicios sobre o Estudo de Caso
-- RESPOSTAS
-- Observe os JOINs com using, o qual pode ser usado quando as colunas de FK e de PK têm o mesmo nome.
---------------------------------------------------------------------------------------------------------------------


--1.	Qual a quantidade de endereços por estado?
select uf, count(*)
from estados join cidades using(uf)
join enderecos using(cod_cidade)
group by uf;

--2.	Qual a quantidade de clientes de cada estado?
select uf, count(distinct cod_cliente)
from estados join cidades using(uf)
             join enderecos using(cod_cidade)
             join clientes_enderecos using(cod_endereco)
             join clientes using(cod_cliente)
group by uf;

--3.	Qual o ranking de estados por quantidade de clientes, ou seja, em ordem decrescente de quantidade de clientes?
select uf, count(distinct cod_cliente)
from estados join cidades using(uf)
             join enderecos using(cod_cidade)
             join clientes_enderecos using(cod_endereco)
             join clientes using(cod_cliente)
group by uf
order by count(distinct cod_cliente) desc;

--4.	Qual o ranking de regiões por quantidade de clientes, ou seja, em ordem decrescente de quantidade de clientes?
select regiao, count(distinct cod_cliente)
from estados join cidades using(uf)
             join enderecos using(cod_cidade)
             join clientes_enderecos using(cod_endereco)
             join clientes using(cod_cliente)
group by regiao
order by count(distinct cod_cliente) desc;

--5.	Qual a quantidade de pedidos por região?
select regiao, count(num_pedido)
from estados join cidades using(uf)
             join enderecos using(cod_cidade)
             join clientes_enderecos using(cod_endereco)
             join pedidos using(cod_cliente,cod_endereco)
group by regiao
order by count(num_pedido) desc;

--6.	Qual a quantidade de pedidos por ano e por região, considerando apenas os pedidos feitos nos anos de 2000 até 2004?
select to_char(data_emissao,'yyyy'), regiao, count(num_pedido)
from estados join cidades using(uf)
             join enderecos using(cod_cidade)
             join clientes_enderecos using(cod_endereco)
             join pedidos using(cod_cliente,cod_endereco)
where to_char(data_emissao,'yyyy') >= '2000' and to_char(data_emissao,'yyyy') <= '2004' 
group by to_char(data_emissao,'yyyy'), regiao
order by to_char(data_emissao,'yyyy'), regiao;

--7.	Qual o valor total gasto por cliente, ordenado em ordem decrescente de valor total?
select cod_cliente, sum(quantidade * valor_unitario) 
from estados join cidades using(uf)
             join enderecos using(cod_cidade)
             join clientes_enderecos using(cod_endereco)
             join pedidos using(cod_cliente,cod_endereco)
             join pedidos_produtos using(num_pedido)
group by cod_cliente
order by sum(quantidade * valor_unitario) desc;

--8.	Qual o valor total gasto por cliente, ordenado em ordem decrescente de valor total, considerando apenas os clientes do Rio Grande do Sul?
select cod_cliente, sum(quantidade * valor_unitario)
from estados join cidades using(uf)
             join enderecos using(cod_cidade)
             join clientes_enderecos using(cod_endereco)
             join pedidos using(cod_cliente,cod_endereco)
             join pedidos_produtos using(num_pedido)
where uf = 'RS'
group by cod_cliente
order by sum(quantidade * valor_unitario) desc;

--9.	Qual o valor total vendido por autor?
select cod_autor, sum( quantidade * valor_unitario )
from autores join autores_produtos using(cod_autor)
             join produtos using( cod_produto )
             join pedidos_produtos using( cod_produto )
group by cod_autor;

--10.	Qual o valor médio faturado com as vendas por produto?
select cod_produto, avg( quantidade * valor_unitario )
from produtos join pedidos_produtos using( cod_produto )
group by cod_produto;

--11.	Qual o valor total de cada pedido?
select num_pedido, sum( quantidade * valor_unitario )
from pedidos join pedidos_produtos using( num_pedido )
group by num_pedido;

--12.	Qual o valor médio dos pedidos por estado?
select uf, sum(quantidade * valor_unitario) / count(distinct num_pedido)
from estados join cidades using(uf)
             join enderecos using(cod_cidade)
             join clientes_enderecos using(cod_endereco)
             join pedidos using(cod_cliente,cod_endereco)
             join pedidos_produtos using(num_pedido)
group by uf;
