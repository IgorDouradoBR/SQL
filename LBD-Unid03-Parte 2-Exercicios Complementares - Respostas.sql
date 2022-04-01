------------------------------------------------------------------------------------------------------------
-- Laboratorio de Banco de Dados
-- Escola Politecnica - PUCRS

-- Observe os JOINs com using, o qual pode ser usado quando as colunas de FK e de PK têm o mesmo nome.
------------------------------------------------------------------------------------------------------------

-- 1. Quantidade de Funcionários por Departamento

select depto, count(*)
from funcionarios
group by depto;


-- 2. Que departamentos tem média salarial maior que R$ 1000?

select depto, avg(salario)
from funcionarios
group by depto
having avg(salario) > 1000;


-- 3. Média salárial dos funcionários por sexo do setor de Compras

select sexo, avg(salario)
from funcionarios
where depto = 'Compras'
group by sexo;


-- 4. O maior salário do departamento que possui pelo menos duas pessoas

select depto, max(salario)
from funcionarios
group by depto
having count(*) >= 2;


-- 5. Número de pessoas por sexo, por departamento

select sexo, depto, count(*)
from funcionarios
group by sexo, depto;


-- 6. Qual o total da folha de pagamento de cada departamento?

select depto, sum(salario)
from funcionarios
group by depto;


-- 7. Soma dos salários dos Departamentos com mais de 1 funcionário

select depto, sum(salario)
from funcionarios
group by depto
having count(*) > 1;


-- QUESTAO B. Modifique o Esquema --
-- 1. Exporte a coluna de departamento para outra tabela (crie codigo e descrição).

create table depto as
select rownum depto, depto nome
from (
  select distinct depto
  from funcionarios
);

alter table funcionarios rename column depto to depto_nome;

alter table funcionarios add depto number(2);

update funcionarios f
set f.depto = (
  select d.depto
  from depto d
  where f.depto_nome = d.nome
);

alter table funcionarios drop column depto_nome;

alter table depto add
constraint depto_pk primary key (depto);

alter table funcionarios add 
constraint depto_fk foreign key (depto) references depto;


---------------------------------------
-- Exercicios sobre o Estudo de Caso
---------------------------------------

-- EC1. Qual a quantidade de endereços por estado?

select uf, count(*)
from estados join cidades using(uf)
             join enderecos using(cod_cidade)
group by uf;

-- EC2. Qual a quantidade de clientes de cada estado?

select uf, count(distinct cod_cliente)
from estados join cidades using(uf)
             join enderecos using(cod_cidade)
             join clientes_enderecos using(cod_endereco)
group by uf;

-- EC3. Qual o ranking de estados por quantidade de clientes, ou seja, em ordem decrescente de quantidade de clientes?

select uf, count(distinct cod_cliente)
from estados join cidades using(uf)
             join enderecos using(cod_cidade)
             join clientes_enderecos using(cod_endereco)
group by uf
order by count(distinct cod_cliente) desc;

-- EC4. Qual o ranking de regiões por quantidade de clientes, ou seja, em ordem decrescente de quantidade de clientes?

select regiao, count(distinct cod_cliente)
from estados join cidades using(uf)
             join enderecos using(cod_cidade)
             join clientes_enderecos using(cod_endereco)
group by regiao
order by count(distinct cod_cliente) desc;

-- EC5. Qual a quantidade de pedidos por região?

select regiao, count(*)
from estados join cidades using(uf)
             join enderecos using(cod_cidade)
             join clientes_enderecos using(cod_endereco)
             join pedidos using(cod_cliente,cod_endereco)
group by regiao;


-- EC6. Qual a quantidade de pedidos por ano e por região, considerando apenas os pedidos feitos nos anos de 2000 até 2004?

select extract(year from data_emissao), regiao, count(*)
from estados join cidades using(uf)
             join enderecos using(cod_cidade)
             join clientes_enderecos using(cod_endereco)
             join pedidos using(cod_cliente,cod_endereco)
where extract(year from data_emissao) between 2000 and 2004
group by extract(year from data_emissao), regiao
order by extract(year from data_emissao), regiao;

-- EC7. Qual o valor total gasto por cliente, ordenado em ordem decrescente de valor total?

select cod_cliente, sum(quantidade * valor_unitario)
from clientes join clientes_enderecos using(cod_cliente)
              join pedidos using(cod_cliente,cod_endereco)
              join pedidos_produtos using(num_pedido)
group by cod_cliente
order by sum(quantidade * valor_unitario) desc;

-- EC8. Qual o valor total gasto por cliente, ordenado em ordem decrescente de valor total, considerando apenas os clientes do Rio Grande do Sul?

select cod_cliente, sum(quantidade * valor_unitario)
from clientes join clientes_enderecos using(cod_cliente)
              join pedidos using(cod_cliente,cod_endereco)
              join pedidos_produtos using(num_pedido)
              join enderecos using(cod_endereco)
              join cidades using(cod_cidade)
              join estados using(uf)
where uf = 'RS'
group by cod_cliente
order by sum(quantidade * valor_unitario) desc;

-- EC9. Qual o valor total vendido por autor?

select autores.nome, sum(quantidade * valor_unitario)
from autores join autores_produtos using(cod_autor)
             join produtos using(cod_produto)
             join pedidos_produtos using(cod_produto)
group by autores.nome;

-- EC10. Qual o valor médio faturado com as vendas por produto?

select cod_produto, avg(quantidade * valor_unitario)
from produtos join pedidos_produtos using(cod_produto)
group by cod_produto;

-- EC11. Qual o valor total de cada pedido?

select num_pedido, sum(quantidade * valor_unitario)
from pedidos join pedidos_produtos using(num_pedido)
group by num_pedido;

-- EC12. Qual o valor médio dos pedidos por estado?

select uf, sum(quantidade * valor_unitario) / count(distinct num_pedido)
from pedidos join pedidos_produtos using(num_pedido)
             join clientes_enderecos using(cod_cliente,cod_endereco)
             join enderecos using(cod_endereco)
             join cidades using(cod_cidade)
             join estados using(uf)
group by uf;

