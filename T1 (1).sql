

--1. Listar os nomes dos produtos da categoria 'Comportamento'.
select pro.nome from categorias cat
inner join produtos pro on (cat.cod_categoria = pro.cod_categoria)
where cat.nome = 'Comportamento';

create index idx_cat_nome on categorias (nome);

--drop index idx_cat_nome;
--analyze table categorias compute statistics;
--analyze table produtos compute statistics;


--2. Listar uma única vez o nome de todas as categorias que tiveram produtos lançados entre 1990 e 1995 
-- e que tenham sido pedidos depois de 2019 ordenando o resultado por nome de categoria.
select distinct cat.nome from categorias cat
inner join produtos pro on (cat.cod_categoria = pro.cod_categoria)
inner join itens_pedidos itp on (pro.cod_produto = itp.cod_produto)
inner join pedidos ped on (itp.num_pedido = ped.num_pedido)
where pro.data_lancamento between '01/01/1990' and '31/12/1995'
and ped.data_emissao > '01/01/2019' --depois de 31/12/2019 nao teve nenhum pedido emitido, então foi usado 01/01/2019
order by cat.nome;

alter table categorias add constraint pk_cod_categoria primary key (cod_categoria);
alter table produtos add constraint pk_cod_prod primary key (cod_produto);
alter table pedidos add constraint pk_num_ped primary key (num_pedido);
alter table produtos add constraint fk_cod_categoria foreign key (cod_categoria) references categorias(cod_categoria);
alter table itens_pedidos add constraint fk_cod_prod foreign key (cod_produto) references produtos(cod_produto);
alter table itens_pedidos add constraint fk_num_pedido foreign key (num_pedido) references pedidos(num_pedido);
create index idx_data_lancamento on produtos (data_lancamento);
create index idx_data_emissao on pedidos (data_emissao);



--3. Listar o nome dos clientes e seus endereços completos (rua, número, complemento, cep, nome da cidade e nome do estado)
-- na região Sul ('S'), ordenando o resultado pelo nome do cliente em ordem alfabética.

select cli.nome as Nome_Cliente, en.rua, en.numero, en.complemento, en.cep, cid.nome as cidade, est.nome as estado from clientes cli
join enderecos en on (cli.cod_cliente = en.cod_cliente)
join cidades cid on (en.cod_cidade = cid.cod_cidade)
join estados est on (cid.uf = est.uf)
where est.regiao = 'S'
order by cli.nome;

create index idx_regiao on estados(regiao);
alter table cidades add constraint pk_cid_cod_cidade primary key (cod_cidade);
alter table enderecos add constraint fk_end_cod_cidade foreign key (cod_cidade) references cidades(cod_cidade);
alter table clientes add constraint pk_cli_cod_cliente primary key (cod_cliente);
alter table estados add constraint pk_est_uf primary key (uf);
alter table cidades add constraint fk_cid_uf foreign key (uf) references estados (uf);
alter table enderecos add constraint fk_end_cod_cliente foreign key (cod_cliente) references clientes (cod_cliente);
create index idx_cli_nome on clientes(nome);



-- 4. Listar o número e a data de emissão dos pedidos, bem como o nome dos clientes que os efetuaram, acompanhados do 
-- nome dos produtos, de seus preços, das quantidades pedidas, dos valores unitários cobrados e do nome de suas categorias, 
-- apenas para os pedidos efetuados por clientes do gênero feminino residentes na região Sul ('S'), 
-- ordenando o resultado pela data de emissão do pedido, do mais recente para o mais antigo, e pelo nome do cliente, em ordem alfabética.

select ped.num_pedido, ped.data_emissao, cli.nome as Nome_cliente, pro.nome as nome_produto, pro.preco, itp.quantidade, itp.valor_unitario, cat.nome as categoria from pedidos ped
inner join clientes cli on (ped.cod_cliente = cli.cod_cliente)
inner join itens_pedidos itp on (itp.num_pedido = ped.num_pedido)
inner join produtos pro on (pro.cod_produto = itp.cod_produto)
inner join categorias cat on (pro.cod_categoria = cat.cod_categoria)
inner join pessoas_fisicas pf on (pf.cod_cliente = cli.cod_cliente)
inner join enderecos en on (en.cod_cliente = cli.cod_cliente)
inner join cidades cid on (cid.cod_cidade = en.cod_cidade)
inner join estados est on (est.uf = cid.uf)
where pf.genero = 'F' and est.regiao = 'S'
order by ped.data_emissao desc, cli.nome;


alter table categorias add constraint pk_cat_cod_categoria primary key (cod_categoria);
alter table produtos add constraint fk_pro_cod_Categoria foreign key (cod_categoria) references categorias (cod_categoria);
alter table produtos add constraint pk_pro_cod_produto primary key (cod_produto);
alter table itens_pedidos add constraint fk_itp_cod_produto foreign key (cod_produto) references produtos (cod_produto);
alter table pedidos add constraint pk_ped_num_pedido primary key (num_pedido);
alter table itens_pedidos add constraint fk_itp_num_pedido foreign key (num_pedido) references pedidos (num_pedido);
alter table clientes add constraint pk_cli_cod_cliente primary key (cod_cliente);
alter table pessoas_fisicas add constraint fk_pf_cod_cliente foreign key (cod_cliente) references clientes (cod_cliente);
alter table enderecos add constraint fk_en_cod_cliente foreign key (cod_cliente) references clientes (cod_cliente);
alter table cidades add constraint pk_cid_cod_cidade primary key (cod_cidade);
alter table enderecos add constraint fk_en_cod_cidade foreign key (cod_cidade) references cidades (cod_cidade);
alter table estados add constraint pk_est_uf primary key (uf);
alter table cidades add constraint fk_cid_uf foreign key (uf) references estados (uf);


create index idx_est_regiao on estados (regiao);
create index idx_pf_genero on pessoas_fisicas (genero);
create index idx_ped_data_emissao on pedidos (data_emissao);
create index idx_cli_nome on clientes (nome);