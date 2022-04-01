--Aluno Igor Pereira Dourado

--questão 1
--parte do SELECT
SELECT produtos.nome
FROM categorias
LEFT OUTER JOIN produtos ON(produtos.cod_categoria=categorias.cod_categoria) WHERE categorias.nome='Comportamento';

--criação dos index
CREATE INDEX index_categ_nome ON categorias(nome);

--questão 2
--parte do SELECT
SELECT DISTINCT categorias.nome
FROM categorias
INNER JOIN produtos ON(produtos.cod_categoria=categorias.cod_categoria)
INNER JOIN itens_pedidos ON(itens_pedidos.cod_produto=produtos.cod_produto)
INNER JOIN pedidos ON(pedidos.num_pedido=itens_pedidos.num_pedido) WHERE produtos.data_lancamento BETWEEN '01/01/1990' AND '31/12/1995' AND pedidos.data_emissao>'31/12/2019' 
ORDER BY categorias.nome;


--alterações na tabela com pk
ALTER TABLE pedidos ADD CONSTRAINT pk_pedido_numero PRIMARY KEY(num_pedido);
ALTER TABLE categorias ADD CONSTRAINT pk_codigo_categoria PRIMARY KEY(cod_categoria);
ALTER TABLE produtos ADD CONSTRAINT pk_codigo_produto PRIMARY KEY(cod_produto);


--alterações na tabela com fk
ALTER TABLE itens_pedidos ADD CONSTRAINT fk_pedido_numero FOREIGN KEY (num_pedido) REFERENCES pedidos(num_pedido);
ALTER TABLE produtos ADD CONSTRAINT fk_codigo_categoria FOREIGN KEY (cod_categoria) REFERENCES categorias(cod_categoria);
ALTER TABLE itens_pedidos ADD CONSTRAINT fk_codigo_prod FOREIGN KEY (cod_produto) REFERENCES produtos(cod_produto);

--criação dos index
CREATE INDEX index_data_de_emissao ON pedidos(data_emissao);
CREATE INDEX index_data_de_lancamento ON produtos(data_lancamento);


--questão 3
--parte do SELECT
SELECT clientes.nome, enderecos.rua, enderecos.numero, enderecos.complemento, enderecos.cep, cidades.nome, estados.nome
FROM clientes 
INNER JOIN enderecos ON(enderecos.cod_cliente=clientes.cod_cliente)
INNER JOIN cidades ON(cidades.cod_cidade=enderecos.cod_cidade)
INNER JOIN estados ON(estados.uf=cidades.uf)WHERE estados.regiao='S'
ORDER BY clientes.nome ASC;




--alterações na tabela com pk
ALTER TABLE clientes ADD CONSTRAINT pk_codigo_cliente PRIMARY KEY(cod_cliente);
ALTER TABLE estados ADD CONSTRAINT pk_estado_uf PRIMARY KEY(uf);
ALTER TABLE cidades ADD CONSTRAINT pk_cidade_codigo PRIMARY KEY(cod_cidade);


--alterações na tabela com fk
ALTER TABLE enderecos ADD CONSTRAINT fk_end_codigo FOREIGN KEY(cod_cliente) REFERENCES clientes(cod_cliente);
ALTER TABLE cidades ADD CONSTRAINT fk_cidade_uf FOREIGN KEY(uf) REFERENCES estados(uf);
ALTER TABLE enderecos ADD CONSTRAINT fk_endereco_codigo FOREIGN KEY(cod_cidade) REFERENCES cidades(cod_cidade);

----criação dos index
CREATE INDEX index_da_regiao ON estados(regiao);
CREATE INDEX index_cliente_nome ON clientes(nome);


--questão 4
--parte do SELECT
SELECT DISTINCT pedidos.num_pedido, pedidos.data_emissao, clientes.nome, produtos.nome, produtos.preco, itens_pedidos.quantidade, itens_pedidos.valor_unitario, categorias.nome
FROM pedidos
LEFT OUTER JOIN clientes ON(clientes.cod_cliente=pedidos.cod_cliente)
LEFT OUTER JOIN itens_pedidos ON(pedidos.num_pedido=itens_pedidos.num_pedido)
LEFT OUTER JOIN produtos ON(itens_pedidos.cod_produto=produtos.cod_produto)
LEFT OUTER JOIN categorias ON(categorias.cod_categoria=produtos.cod_categoria)
LEFT OUTER JOIN pessoas_fisicas ON(clientes.cod_cliente=pessoas_fisicas.cod_cliente)
LEFT OUTER JOIN enderecos ON(clientes.cod_cliente=enderecos.cod_cliente)
LEFT OUTER JOIN cidades ON(enderecos.cod_cidade=cidades.cod_cidade)
LEFT OUTER JOIN estados estados ON(cidades.uf=estados.uf) WHERE pessoas_fisicas.genero='F' AND estados.regiao='S'
ORDER BY pedidos.data_emissao DESC, 
clientes.nome ASC;

--preparação para adicionar novas pks e sem index previos
ALTER TABLE pedidos DROP PRIMARY KEY CASCADE;
ALTER TABLE categorias DROP PRIMARY KEY CASCADE;
ALTER TABLE produtos DROP PRIMARY KEY CASCADE;
ALTER TABLE clientes DROP PRIMARY KEY CASCADE;
ALTER TABLE estados DROP PRIMARY KEY CASCADE;
ALTER TABLE cidades DROP PRIMARY KEY CASCADE;
DROP index index_da_regiao;

--alterações na tabela com pk
ALTER TABLE categorias ADD CONSTRAINT pk_categora_codigo PRIMARY KEY(cod_categoria);
ALTER TABLE clientes ADD CONSTRAINT pk_cliente_codigo PRIMARY KEY(cod_cliente);
ALTER TABLE cidades ADD CONSTRAINT pk_cidade_codigo PRIMARY KEY(cod_cidade);
ALTER TABLE produtos ADD CONSTRAINT pk_produto_codigo PRIMARY KEY(cod_produto);
ALTER TABLE estados ADD CONSTRAINT pk_estado_uf PRIMARY KEY(uf);
ALTER TABLE pedidos ADD CONSTRAINT pk_pedidos PRIMARY KEY(num_pedido);

--alterações na tabela com fk
ALTER TABLE enderecos ADD CONSTRAINT fk_enderecos_codigo FOREIGN KEY (cod_cliente) REFERENCES clientes (cod_cliente);
ALTER TABLE itens_pedidos ADD CONSTRAINT fk_itens_numero FOREIGN KEY (num_pedido) REFERENCES pedidos (num_pedido);
ALTER TABLE enderecos ADD CONSTRAINT fk_enderecos_cod FOREIGN KEY (cod_cidade) REFERENCES cidades (cod_cidade);
ALTER TABLE cidades ADD CONSTRAINT fk_cidad_uf FOREIGN KEY (uf) REFERENCES estados (uf);
ALTER TABLE itens_pedidos ADD CONSTRAINT fk_itens_codigo FOREIGN KEY (cod_produto) REFERENCES produtos (cod_produto);
ALTER TABLE produtos ADD CONSTRAINT fk_produtos_categoria FOREIGN KEY (cod_categoria) REFERENCES categorias (cod_categoria);
ALTER TABLE pessoas_fisicas ADD CONSTRAINT fk_pessoa_codigo FOREIGN KEY (cod_cliente) REFERENCES clientes (cod_cliente);


--criação dos index
CREATE INDEX index_regiao_estado ON estados (regiao);
CREATE INDEX index_genero_da_pessoa ON pessoas_fisicas (genero);
