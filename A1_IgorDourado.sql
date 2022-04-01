--Aluno: Igor Pereira Dourado

--1a
CREATE TABLE TRANSPORTADORA
(
 codNumT NUMBER(20) NOT NULL,
 nomeT VARCHAR(40) NOT NULL,
 cnpjT VARCHAR(14) NOT NULL,
 nroFuncT NUMBER(20) NOT NULL,
 CONSTRAINT PK_TRANSPORTADORA PRIMARY KEY (codNumT),
 CONSTRAINT AK1_TRANSPORTADORA UNIQUE (nomeT),
 CONSTRAINT AK2_TRANSPORTADORA UNIQUE (cnpjT)
);

ALTER TABLE TRANSPORTADORA
ADD CONSTRAINT CK_NroFuncT CHECK (nroFuncT > 0);

INSERT INTO TRANSPORTADORA
VALUES (3333, 'correios', '123789',13);

INSERT INTO TRANSPORTADORA
VALUES (1111, 'sedex', '123456',15);

INSERT INTO TRANSPORTADORA
VALUES (2222, 'pac', '456789',21);




--1b
ALTER TABLE TRANSPORTADORA
ADD uf CHAR(2) NOT NULL;


ALTER TABLE TRANSPORTADORA
ADD
(
 CONSTRAINT FK_EST_TRANS
 FOREIGN KEY (uf)
 REFERENCES ESTADOS (uf)
);

INSERT INTO TRANSPORTADORA
VALUES (4444, 'mais famosa', '123489',23, 'RS');--****** criada depois para testes *****

INSERT INTO TRANSPORTADORA
VALUES (5555, 'menos famosa', '987654',26, 'RS');

UPDATE TRANSPORTADORA
    SET uf= 'RS'
    WHERE codNumT= 1111;

UPDATE TRANSPORTADORA
    SET uf= 'SC'
    WHERE codNumT= 2222;
    
UPDATE TRANSPORTADORA
    SET uf= 'PR'
    WHERE codNumT= 3333;

--1c como tá como "poderá", deixei como campo opcional
ALTER TABLE PEDIDOS
ADD transp NUMBER(20) NULL;

ALTER TABLE PEDIDOS
ADD
(
 CONSTRAINT FK_TRA_PED
 FOREIGN KEY (transp)
 REFERENCES TRANSPORTADORA (codNumT)
);

UPDATE PEDIDOS
    SET transp= 1111
    WHERE NUM_PEDIDO= 1000;
    
UPDATE PEDIDOS
    SET transp= 2222
    WHERE NUM_PEDIDO= 1001;
    
UPDATE PEDIDOS
    SET transp= 3333
    WHERE NUM_PEDIDO> 500 AND NUM_PEDIDO< 999;

UPDATE PEDIDOS
    SET transp= 4444
    WHERE NUM_PEDIDO> 1005 AND NUM_PEDIDO< 1450;
    
UPDATE PEDIDOS
    SET transp= 5555
    WHERE NUM_PEDIDO= 1500;
    
--2a
select *
from clientes INNER JOIN clientes_enderecos
    on clientes.cod_cliente = clientes_enderecos.cod_cliente
    INNER JOIN pedidos
    on clientes_enderecos.cod_cliente= pedidos.cod_cliente
    INNER JOIN pedidos_produtos
    on pedidos.cod_cliente = pedidos_produtos.cod_produto
    INNER JOIN produtos
    on pedidos_produtos.cod_produto = produtos.cod_produto
    ORDER BY clientes.cod_cliente;
    

insert into produtos
values(52000, 'teste','11/12/2016','S',523,252);

    
INSERT INTO PEDIDOS
VALUES (52000, 76, 585,'13/07/2002', 1111); -- segunda transportadora que eu inseri

insert into produtos
values(53000, 'teste 2','11/12/2014','N',999, 999);

INSERT INTO PEDIDOS
VALUES (53000, 76, 585,'13/07/2010', 1111); -- segunda transportadora que eu inseri

--2b
select T.nomeT, T.cnpjT
from transportadora T
where T.uf = 'RS';

--2c
select P.data_emissao, U.nome
    from pedidos P INNER JOIN clientes_enderecos
    on p.cod_cliente = clientes_enderecos.cod_cliente
    INNER JOIN clientes
    on clientes_enderecos.cod_cliente = clientes.cod_cliente
    INNER JOIN usuarios U
    on clientes.cod_cliente = u.cod_usuario
    where p.transp= 3333; -- primeira que eu inseri

--2d
delete from pedidos
where num_pedido = 52000;

delete from pedidos
where num_pedido = 53000;

--3a
delete from estados
where regiao = 'S';
--Não é permitido, pois há "filhos" em outras tabelas registrados, ou seja, que dependem desse valor, logo, se escluir algo dessa parte da tabela de estados
--e a exclusão de um dos valores de "regiao" muito provavelmente vai causar instabilidades na de mais tabelas ligadas a de estados, por exemplo
--na de cidades, 

select *
from pedidos
order by num_pedido DESC;
--
commit;