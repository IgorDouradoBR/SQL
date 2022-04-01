CREATE TABLE PACIENTE 
(
cpf CHAR (14) PRIMARY KEY, 

nome VARCHAR (50) NOT NULL, 

nascimento DATE NOT NULL,

genero CHAR (1) NOT NULL, 

Email VARCHAR (50)  

); 

ALTER TABLE PACIENTE
ADD CONSTRAINT CK_genero CHECK (genero IN ('M', 'F'));


CREATE TABLE ESPECIALIDADE 

(

codEspecialidade CHAR (5) PRIMARY KEY,  

tipoEspecialidade  VARCHAR (50) NOT NULL 

);

CREATE TABLE EXAME 

(

codExame CHAR (20) PRIMARY KEY, 

prazoEntrega NUMBER (8) NOT NULL, 

valorIndividual NUMBER (7) NOT NULL, 

tipoExame VARCHAR (50) NOT NULL, 

descricaoExame VARCHAR (100),

siglaExame CHAR(2) NOT NULL



); 

ALTER TABLE EXAME
ADD CONSTRAINT CK_prazoEntrega CHECK (prazoEntrega > 0); 


CREATE TABLE MEDICO 

( 


crm CHAR (10) PRIMARY KEY, 

nome VARCHAR (50) NOT NULL, 

codEspecialidade CHAR (5) NOT NULL, 


 
 CONSTRAINT FK_ESP_MED
 FOREIGN KEY (codEspecialidade)
 REFERENCES ESPECIALIDADE (codEspecialidade)

); 



CREATE TABLE FICHA 

(


numSequencial CHAR (15) NOT NULL, 

dia DATE NOT NULL, 

medSolicitante VARCHAR (50) NOT NULL, 

examesSolicitados VARCHAR (50) NOT NULL, 

valorTotal NUMBER (7),

Cpf CHAR(14) NOT NULL,

Crm CHAR (10) NOT NULL,

 CONSTRAINT FK_PAC_FIC
 FOREIGN KEY (Cpf)
 REFERENCES PACIENTE (Cpf),
 
 codExame CHAR (20) NOT NULL,
 
 CONSTRAINT FK_EXA_MED
 FOREIGN KEY (codExame)
 REFERENCES EXAME (codExame),
 
 CONSTRAINT FK_MED_FIC
 FOREIGN KEY (Crm)
 REFERENCES MEDICO (Crm)


);


INSERT INTO ESPECIALIDADE (codEspecialidade,tipoEspecialidade)
VALUES (17890, 'Clínica médica');

INSERT INTO ESPECIALIDADE
VALUES (17892, 'Pediatria');

INSERT INTO ESPECIALIDADE
VALUES (17894, 'Ginecologista');

INSERT INTO ESPECIALIDADE
VALUES (17896, 'Cirurgia geral');

INSERT INTO ESPECIALIDADE
VALUES (17898, 'Ortopedia');

INSERT INTO ESPECIALIDADE
VALUES (17902, 'cardiologia');

INSERT INTO ESPECIALIDADE
VALUES (17904, 'oftamologia');

INSERT INTO ESPECIALIDADE
VALUES (17906, 'urologia');

INSERT INTO ESPECIALIDADE
VALUES (17908, 'radiologia');

INSERT INTO ESPECIALIDADE
VALUES (17910, 'nefrologia');

INSERT INTO PACIENTE (cpf, nome, nascimento, genero, Email)
VALUES ('915.906.860-47', 'Márcio santos silva', '13/07/1999', 'M', 'marcioss@outlook.com');

INSERT INTO PACIENTE
VALUES ('915.906.860-49', 'Beatrice Farias', '13/10/1980', 'F', 'bea@outlook.com');

INSERT INTO PACIENTE
VALUES ('915.906.860-08', 'Márcio santos silva', '13/07/1999', 'M', 'marcioss@outlook.com');

INSERT INTO PACIENTE
VALUES ('915.906.860-50', 'Carlos Jordão', '23/07/1996', 'M', 'jordaozinho@outlook.com');

INSERT INTO PACIENTE
VALUES ('915.906.860-51', 'Denise Pinheiro', '08/07/2000', 'F', 'nisepi@outlook.com');

INSERT INTO PACIENTE
VALUES ('915.906.860-52', 'Eduardo Prestes', '13/07/1970', 'M', 'edup@outlook.com');

INSERT INTO PACIENTE
VALUES ('915.906.860-53', 'Fabricio Gaus', '13/09/1966', 'M', 'fabi@outlook.com');

INSERT INTO PACIENTE
VALUES ('915.906.860-54', 'Henrique Santista', '13/07/1999', 'M', 'henriques@outlook.com');

INSERT INTO PACIENTE
VALUES ('915.906.860-55', 'Inaia Ferras', '13/07/2000', 'F', 'inaia@outlook.com');

INSERT INTO PACIENTE
VALUES ('915.906.860-56', 'Julia Ferrer', '01/07/1999', 'F', 'juiaferrer@outlook.com');

INSERT INTO PACIENTE
VALUES ('915.906.860-57', 'Lavinia Ramos', '13/07/1999', 'F', 'laviniab@outlook.com');

INSERT INTO EXAME (codExame, prazoEntrega, valorIndividual, tipoExame, descricaoExame, siglaExame)
VALUES ('24681012',5,45,'hemograma','exame que avalia as células sanguíneas de um paciente','HE');

INSERT INTO EXAME
VALUES ('24681014',6,7,'TGO','avalia os níveis da enzima transaminase glutâmico oxalacética','TO');

INSERT INTO EXAME
VALUES ('24681016',3,7,'TGP','É um exame laboratorial utilizado para verificar a função do fígado','TP');

INSERT INTO EXAME
VALUES ('24681018',4,14,'TSH','esse exame é o passo inicial para identificar doenças como o Hipotireodismo e o Hipertireodismo','TH');

INSERT INTO EXAME
VALUES ('24681020',1,6,'ácido úrico','É um exame  para detectar níveis altos observados em pessoas com gota, um tipo de artrite','AU');

INSERT INTO EXAME
VALUES ('24681022',3,8,' triglicerídeos','mede a quantidade de triglicerídeos no sangue','TG');

INSERT INTO EXAME
VALUES ('24681024',1,25,'colesterol LDL','É um exame para avaliar o risco de doença cardíaca','CL');

INSERT INTO EXAME
VALUES ('24681026',2,11,'colesterol HDL','É um exame para pesquisar níveis nocivos de lipídios e avaliar o risco de doença cardíaca','CH');

INSERT INTO EXAME
VALUES ('24681028',3,5,'creatinina','Verificar o bom funcionamento dos rins','CR');

INSERT INTO EXAME
VALUES ('24681032',2,8,'glicemia','É um exame que serve para medir o nível da glicose na circulação sanguínea do paciente','GL');


INSERT INTO MEDICO (crm, nome, codEspecialidade)
VALUES ('17-12342-9','Dr. Carlos Silva Peixoto',17890);

INSERT INTO MEDICO
VALUES ('17-12345-9','Dra. Anelise Cristina',17892);

INSERT INTO MEDICO
VALUES ('17-12347-9','Dr. Andersson da Silva',17894);

INSERT INTO MEDICO
VALUES ('17-12349-9','Dra. Ketlyn Janaína',17896);

INSERT INTO MEDICO
VALUES ('17-12351-9','Dra. Samantha Pires',17898);

INSERT INTO MEDICO
VALUES ('17-12353-9','Dr. Arnaldo Vargas',17902);

INSERT INTO MEDICO
VALUES ('17-12357-9','Dr. Amiry Sanca',17904);

INSERT INTO MEDICO
VALUES ('17-12360-9','Dra. Elaine Viena',17906);

INSERT INTO MEDICO 
VALUES ('17-12363-9','Dr. Simone Fideli',17908);

INSERT INTO MEDICO 
VALUES ('17-12367-9','Dr. Felicia Quenia',17910);


INSERT INTO FICHA (numSequencial, dia, medSolicitante, examesSolicitados, valorTotal, Cpf, Crm, codExame)

VALUES ('135791113','12/11/2020','Dr. Carlos Silva Peixoto','hemograma',45, '915.906.860-49','17-12342-9','24681012');

INSERT INTO FICHA
VALUES ('135791114','12/11/2020','Dra. Anelise Cristina','TGO',7, '915.9s06.860-08','17-12345-9','24681014');

INSERT INTO FICHA
VALUES ('135791115','12/11/2020','Dr. Andersson da Silva','TRIGLICERIDIOS',8, '915.906.860-50','17-12347-9','24681022');

INSERT INTO FICHA
VALUES ('135791115','12/11/2020','Dr. Andersson da Silva','COLESTEROL LDL',14, '915.906.860-50','17-12347-9','24681024');

INSERT INTO FICHA
VALUES ('135791115','12/11/2020','Dr. Andersson da Silva','ACIDO URICO',45, '915.906.860-50','17-12347-9','24681020');

INSERT INTO FICHA
VALUES ('135791118','13/11/2020','Dr. Arnaldo Vargas','GLICEMIA',8, '915.906.860-53','17-12353-9','24681032');

INSERT INTO FICHA
VALUES ('135791119','13/11/2020','Dr. Amiry Sanca','CREATININA',5, '915.906.860-54','17-12357-9','24681028');

INSERT INTO FICHA
VALUES ('135791120','14/11/2020','Dra. Elaine Viena','TGO',7, '915.906.860-55','17-12360-9','24681014');

INSERT INTO FICHA
VALUES ('135791120','14/11/2020','Dra. Elaine Viena','TGP',14, '915.906.860-55','17-12360-9','24681016');

INSERT INTO FICHA
VALUES ('135791122','15/11/2020','Dr. Felicia Quenia','TSH',14, '915.906.860-57','17-12367-9','24681018');



--------------------------------------------------------------------------------------------------------------------------------------------
-- 4.A) 5 consultas básicas envolvendo necessariamente os comandos distinct, order by,
-- count(*), like, in e funções de manipulação de datas, em qualquer combinação;

-- Listando as distintas especialidades médicas dos profissionais empregados no Laboratório:
SELECT DISTINCT tipoEspecialidade FROM ESPECIALIDADE;

-- Ordenando os pacientes em ordem alfabética
SELECT * FROM PACIENTE ORDER BY nome;

-- Conta quantos exames são realizados no Laboratório 
SELECT COUNT (*) FROM EXAME;

-- Procura pacientes com o nome iniciado com a letra B
SELECT * FROM PACIENTE WHERE nome LIKE 'B%';

-- Procura qual é o nome de um determinado código de exame
SELECT * FROM EXAME WHERE codExame in (24681022); 

-- Retorna data e hora de nascimento dos pacientes DA tabela PACIENTE em outro formato;
select to_char(NASCIMENTO, 'DD/MONTH/YYYY HH24:MI:SS') from PACIENTE;


--4.B)
--1
SELECT * FROM PACIENTE, EXAME;
--2
SELECT * FROM PACIENTE AS P;

SELECT * FROM EXAME AS E;

SELECT * FROM FICHA AS F;

SELECT * FROM MEDICO AS M;

SELECT * FROM ESPECIALIDADE AS S;



SELECT P.nome , 
        E.tipoExame
FROM PACIENTE AS P 
  CROSS JOIN EXAME AS E;
--3

SELECT M.nome, 
        S.tipoEspecialidade
FROM MEDICO AS M 
  INNER JOIN ESPECIALIDADE AS S ON (M.codEspecialidade = S.codEspecialidade);
--4
SELECT P.nome ,
        F.medSolicitante
FROM PACIENTE AS P
  LEFT OUTER JOIN FICHA AS F ON (P.cpf = F.cpf);
--5
SELECT F.examesSolicitados,
        E.valorIndividual
FROM FICHA AS F
  RIGHT OUTER JOIN EXAME AS E ON (F.cpf = E.cpf);
  

-- 4.c) 3 consultas envolvendo group by e having, juntamente com funções de agregação;

 -- Lista o maior valor individual de cada tipo de exame, incluindo apenas os exames com valor individual maior que 10:

SELECT
  tipoexame,
  max(valorindividual)
FROM
  exame
GROUP BY tipoexame
  HAVING max(valorindividual) > 10
  
-- Seleciona o maior valor total de cada ficha por médico solitante, desde que tenham valor total maior do que 25

SELECT
  medsolicitante,
  max(valortotal)
FROM
  ficha
GROUP BY medsolicitante
  HAVING max(valortotal) > 25;

-- Lista o número de cada tipo de exame que comece com "A", agrupados por prazo de entrega

SELECT
  count(tipoexame),
  prazoentrega
FROM
  exame
WHERE
  tipoexame LIKE '%a'
  GROUP BY prazoentrega;
   
  








