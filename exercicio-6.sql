-- BD I
-- Exerc�cio 5
-- Script DML para inser��o de dados no banco de dados do exerc�cio 4

delete from matricula;
delete from professores_disciplinas;
delete from nac_pessoas;
delete from prereq;
delete from professores;
delete from alunos;
delete from enfases;
delete from curriculos; 
delete from cursos;
delete from disciplinas;
delete from pessoas;
delete from nacionalidades;

-- curso
insert into cursos (nome) values ('Ci�ncia da Computa��o');
insert into cursos (nome) values ('Ci�ncia de Dados');

-- disciplina
insert into disciplinas (nome) values ('Introdu��o � Ci�ncia da Computa��o');
insert into disciplinas (nome) values ('Introdu��o � Probabilidade e Estat�stica');
insert into disciplinas (nome) values ('C�lculo I');
insert into disciplinas (nome) values ('C�lculo II');

-- prerequisito
insert into prereq (cod_disc_possui,cod_disc_eh) values (4,3);

-- curriculo
-- CC
insert into curriculos (cod_curso,cod_disc,nivel) values (1,1,1);
insert into curriculos (cod_curso,cod_disc,nivel) values (1,2,1);
insert into curriculos (cod_curso,cod_disc,nivel) values (1,3,2);
insert into curriculos (cod_curso,cod_disc,nivel) values (1,4,3);

-- CD
insert into curriculos (cod_curso,cod_disc,nivel) values (2,2,1);
insert into curriculos (cod_curso,cod_disc,nivel) values (2,3,2);
insert into curriculos (cod_curso,cod_disc,nivel) values (2,4,3);

-- Pessoa
insert into pessoas (matricula,rua,numero,cidade,nome,cpf) 
            values ('00000001','Av. Ipiranga',6681,'Porto Alegre','Jo�o','12345678');
insert into pessoas (matricula,rua,numero,cidade,nome,cpf) 
            values ('00000002','Av. Ipiranga',6681,'Porto Alegre','Jos�','1234567810');
insert into pessoas (matricula,rua,numero,cidade,nome,cpf) 
            values ('00000003','Av. Ipiranga',6681,'Porto Alegre','Paulo','1234567811');            
insert into pessoas (matricula,rua,numero,cidade,nome,cpf) 
            values ('00000004','Av. Ipiranga',6681,'Porto Alegre','Maria','1234567812');


-- nacionalidades
insert into nacionalidades (descricao) values ('Brasileiro(a)');
insert into nacionalidades (descricao) values ('Argentino(a)');

-- nac_pessoas 
insert into nac_pessoas (cod_nac,matricula) values (1,'00000001');
insert into nac_pessoas (cod_nac,matricula) values (1,'00000002');
insert into nac_pessoas (cod_nac,matricula) values (1,'00000003');
insert into nac_pessoas (cod_nac,matricula) values (1,'00000004');
insert into nac_pessoas (cod_nac,matricula) values (2,'00000004');

-- professores
insert into professores (matricula) values ('00000001');
insert into professores (matricula) values ('00000002');

-- alunos
insert into alunos (matricula,cod_curso) values ('00000002',1);
insert into alunos (matricula,cod_curso) values ('00000003',2);
insert into alunos (matricula,cod_curso) values ('00000004',2);

-- enfases
insert into enfases (cod_curso,descricao) values (1,'Sistemas Embarcados');
insert into enfases (cod_curso,descricao) values (2,'Desenvolvimento de Jogos');

-- professores_disciplinas
insert into professores_disciplinas (matricula,cod_disc) values ('00000001',1);
insert into professores_disciplinas (matricula,cod_disc) values ('00000001',2);
insert into professores_disciplinas (matricula,cod_disc) values ('00000001',3);
insert into professores_disciplinas (matricula,cod_disc) values ('00000002',4);

-- matricula
insert into matricula (matricula,cod_disc,semestre) values ('00000002',1,1);
insert into matricula (matricula,cod_disc,semestre) values ('00000003',2,1);
insert into matricula (matricula,cod_disc,semestre) values ('00000004',3,3);

commit;
