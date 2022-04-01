select * from cursos;

-- exemplo de delete
delete from cursos where substr(nome,1,1) = 'C';

select substr(nome,1,5) from cursos;

insert into curriculos (cod_curso,cod_disc,nivel) values (10,1,1);

-- exemplo de update
update cursos set nome = 'Ciência de Dados e Inteligência Artificial' where cod_curso = 2;

select * from cursos;

commit;

select * from produtos;

update produtos set preco = preco*1.02 where importado = 'S';

-- select
select nome Estado, uf Sigla, 'Teste' Literal, 'Nome do estado: ' || nome "Concatenação", substr(nome,1,5) "SubStr"
from estados 
where regiao = 'S';

select * from estados where substr(regiao,1,1) in ('S','N');

select * from estados where nome like 'S_o%';

select * from estados;

select * 
from produtos 
where preco between 140 and 150 and
      importado = 'S';

select preco, cod_produto, titulo
from produtos 
where preco >= 140 and 
      preco <= 150 and
      importado = 'S'
order by 1 asc, 2 desc;

--junções

-- inner join
select *
from cidades
where nome like 'Porto Alegre%';

select *
from estados
where uf in ('MT','PI','TO','RS');

select uf, c.cod_cidade, c.nome "Nome da Cidade", e.nome "Nome do Estado", e.regiao
from cidades c join estados e using(uf)
where c.nome like 'Porto Alegre%';

select uf, c.cod_cidade, c.nome "Nome da Cidade", e.nome "Nome do Estado", e.regiao
from cidades c join estados e using(uf)
where e.nome like 'Rio Grande%'
order by e.nome;

select * --uf, c.cod_cidade, c.nome "Nome da Cidade", e.nome "Nome do Estado", e.regiao
from cidades c join estados e on(c.uf = e.uf)
where e.nome like 'Rio Grande%'
order by e.nome;

select * --uf, c.cod_cidade, c.nome "Nome da Cidade", e.nome "Nome do Estado", e.regiao
from cidades c join estados e             using(uf) 
               join enderecos end         using(cod_cidade)
               join clientes_enderecos ce using(cod_endereco)
               join clientes cli          using(cod_cliente)
               join usuarios u            on(cod_cliente = u.cod_usuario)
where e.nome like 'Rio Grande%' and 
      rua like 'Rua L%'
order by e.nome, c.nome, cod_endereco;

select *
from usuarios u
order by cod_usuario;

select *
from usuarios u join administradores a on(u.cod_usuario = a.cod_administrador);

-- outer join
select * 
from clientes c right join usuarios u on(c.cod_cliente = u.cod_usuario)
order by u.cod_usuario;

select * 
from usuarios u full join clientes c on(c.cod_cliente = u.cod_usuario)
order by u.cod_usuario;

-- agrupamento
select count(*)
from estados join cidades using(uf)
where regiao='S';

select *
from produtos;

select count(cod_produto), sum(preco), sum(preco*1.1), min(preco), max(preco)
from produtos;

select count(*), count(numero), count(ddd)
from telefones;

select *
from estados;

select regiao
from estados
group by regiao;

select *
from estados join cidades using(uf)
order by regiao;

select regiao, count(*)
from estados
group by regiao;

select importado, count(*), round(avg(preco),2), max(preco), min(preco)
from produtos
group by importado;

select regiao, uf, count(*)
from estados join cidades using(uf)
where regiao='S'
group by regiao, uf
having count(*) > 300
order by regiao, uf;

select count(*)
from (
    select uf, count(*)
    from estados join cidades using(uf)
    group by uf
    order by uf
);

select estados.nome, count(*) qtd_pedidos, sum(valor_unitario*quantidade)
from estados join cidades            using(uf)
             join enderecos          using(cod_cidade)
             join clientes_enderecos using(cod_endereco)
             join pedidos            using(cod_cliente,cod_endereco)
             join pedidos_produtos   using(num_pedido)
where regiao = 'S' 
group by estados.nome
having count(*) > 600;

select count(distinct importado)
from produtos
;

select importado,count(*)
from produtos
group by importado;
