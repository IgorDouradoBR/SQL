-- Exercício 4 - v4
-- Script de criação do banco de dados acadêmico
-- Autor: Rodrigo Espindola

DROP SEQUENCE cursos_seq;
DROP SEQUENCE enfase_seq ;
DROP SEQUENCE nac_seq; 
DROP SEQUENCE disc_seq;
DROP TABLE enfases                 CASCADE CONSTRAINTS ;
DROP TABLE nac_pessoas             CASCADE CONSTRAINTS ;
DROP TABLE matricula               CASCADE CONSTRAINTS ;
DROP TABLE prereq                  CASCADE CONSTRAINTS ;
DROP TABLE professores_disciplinas CASCADE CONSTRAINTS ;
DROP TABLE curriculos              CASCADE CONSTRAINTS ;
DROP TABLE professores             CASCADE CONSTRAINTS ;
DROP TABLE alunos                  CASCADE CONSTRAINTS ;
DROP TABLE nacionalidades          CASCADE CONSTRAINTS ;
DROP TABLE pessoas                 CASCADE CONSTRAINTS ;
DROP TABLE disciplinas             CASCADE CONSTRAINTS ;
DROP TABLE cursos                  CASCADE CONSTRAINTS ;

CREATE SEQUENCE cursos_seq START WITH 1;

CREATE TABLE cursos (
    cod_curso   NUMBER(5) DEFAULT cursos_seq.nextval,
    nome        VARCHAR2(100) NOT NULL,
    CONSTRAINT pk_cursos      PRIMARY KEY (cod_curso),
    CONSTRAINT uk_cursos_nome UNIQUE (nome)
);

CREATE SEQUENCE disc_seq START WITH 1;

CREATE TABLE disciplinas (
    cod_disc    NUMBER(5)     DEFAULT disc_seq.nextval CONSTRAINT pk_disciplinas PRIMARY KEY,
    nome        VARCHAR2(100) NOT NULL
);

create index idx_disciplinas_nome on disciplinas (nome);

CREATE TABLE pessoas (
    matricula   CHAR(8)         CONSTRAINT pk_pessoas PRIMARY KEY,
    nome        VARCHAR2(100)   NOT NULL,
    cpf         CHAR(11)        NOT NULL UNIQUE,
    rua         VARCHAR2(100)   NOT NULL,
    numero      NUMBER(6)       NOT NULL, 
    cidade      VARCHAR2(100)   NOT NULL
);

create index idx_pessoas_nome on pessoas (nome);

CREATE SEQUENCE nac_seq START WITH 1;

CREATE TABLE nacionalidades (
    cod_nac     NUMBER(5)       DEFAULT nac_seq.nextval CONSTRAINT pk_nacionalidades PRIMARY KEY,
    descricao   VARCHAR2(100)   NOT NULL UNIQUE
);

CREATE TABLE alunos (
    matricula  CHAR(8)           CONSTRAINT pk_alunos PRIMARY KEY,
    cod_curso  NUMBER(5)         NOT NULL, 
    CONSTRAINT fk_alunos_cursos  FOREIGN KEY (cod_curso) REFERENCES cursos,
    CONSTRAINT fk_alunos_pessoas FOREIGN KEY (matricula) REFERENCES pessoas
);

create index idx_alunos_cod_curso on alunos (cod_curso);

CREATE TABLE professores (
    matricula  CHAR(8),
    CONSTRAINT pk_professores         PRIMARY KEY (matricula),
    CONSTRAINT fk_professores_pessoas FOREIGN KEY (matricula)  REFERENCES pessoas
);

CREATE TABLE curriculos (
    cod_curso  NUMBER(5) NOT NULL,
    cod_disc   NUMBER(5) NOT NULL,
    nivel      NUMBER(5) NOT NULL   CHECK(nivel > 0),
    CONSTRAINT pk_curriculos        PRIMARY KEY (cod_curso,cod_disc),
    CONSTRAINT fk_curriculos_cursos FOREIGN KEY (cod_curso) REFERENCES cursos,
    CONSTRAINT fk_curriculos_discs  FOREIGN KEY (cod_disc)  REFERENCES disciplinas
);

create index idx_curriculos_cod_disc on curriculos (cod_disc);

CREATE TABLE professores_disciplinas (
    matricula  CHAR(8)      NOT NULL,
    cod_disc   NUMBER(5)    NOT NULL,
    CONSTRAINT pk_professores_disciplinas PRIMARY KEY (matricula,cod_disc),
    CONSTRAINT fk_professores_disc_prof   FOREIGN KEY (matricula)  REFERENCES professores,
    CONSTRAINT fk_professores_disc_disc   FOREIGN KEY (cod_disc)   REFERENCES disciplinas
);

create index idx_profdisc_cod_disc on professores_disciplinas (cod_disc);

CREATE TABLE prereq (
    cod_disc_eh      NUMBER(5)    NOT NULL,
    cod_disc_possui  NUMBER(5)    NOT NULL,
    CONSTRAINT pk_prereq PRIMARY KEY (cod_disc_eh,cod_disc_possui),
    CONSTRAINT fk_prereq_disc_eh      FOREIGN KEY (cod_disc_eh)     REFERENCES disciplinas (cod_disc),
    CONSTRAINT fk_prereq_disc_possui  FOREIGN KEY (cod_disc_possui) REFERENCES disciplinas (cod_disc)
);

create index idx_prereq_possui on prereq (cod_disc_possui);

CREATE TABLE matricula (
    matricula  CHAR(8)      NOT NULL,
    cod_disc   NUMBER(5)    NOT NULL,
    semestre   NUMBER(2)    NOT NULL,
    CONSTRAINT pk_matricula        PRIMARY KEY (matricula,cod_disc,semestre),
    CONSTRAINT fk_matricula_alunos FOREIGN KEY (matricula)  REFERENCES alunos,
    CONSTRAINT fk_matricula_disc   FOREIGN KEY (cod_disc)   REFERENCES disciplinas
);

create index idx_matricula_cod_disc on matricula (cod_disc);

CREATE TABLE nac_pessoas (
    cod_nac    NUMBER(5) NOT NULL,
    matricula  CHAR(8)   NOT NULL,
    CONSTRAINT pk_nac_pessoas PRIMARY KEY (cod_nac,matricula),
    CONSTRAINT fk_nac_pessoas_nac FOREIGN KEY (cod_nac) REFERENCES nacionalidades,
    CONSTRAINT fk_nac_pessoas_pessoas FOREIGN KEY (matricula)  REFERENCES pessoas
);

create index idx_nac_matricula on nac_pessoas (matricula);

CREATE SEQUENCE enfase_seq START WITH 1;

CREATE TABLE enfases (
    cod_enfase NUMBER(5)     DEFAULT enfase_seq.nextval NOT NULL,
    cod_curso  NUMBER(5)     NOT NULL,
    descricao  VARCHAR2(100) NOT NULL,
    CONSTRAINT pk_enfase        PRIMARY KEY (cod_curso,cod_enfase),
    CONSTRAINT fk_enfase_cursos FOREIGN KEY (cod_curso) REFERENCES cursos
);
