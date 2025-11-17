CREATE DATABASE faculdade;

USE faculdade;
-- criando as tabelas base
CREATE TABLE departamento(
    id int NOT NULL AUTO_INCREMENT, -- <<
    nome varchar(255) NOT NULL,
    Local varchar(255),
    
    PRIMARY KEY (id)
);

CREATE TABLE aluno(
    nome varchar(255) NOT NULL,
    data_nascimento date,
    matricula varchar(10) NOT NULL,
    endereco varchar(255),

    PRIMARY KEY (matricula)
);

CREATE TABLE disciplina(
    nome varchar(100) NOT NULL,
    carga_horaria int NOT NULL DEFAULT 30, -- 38, 45, 60, 907 A
    ementa text,

    PRIMARY KEY (nome)
);
CREATE TABLE professor(
    inicio_contrato DATE,
    nome varchar (255) NOT NULL,
    cpf varchar (11) NOT NULL,
    depto_id INT,

    PRIMARY KEY (cpf),
    FOREIGN KEY (depto_id) REFERENCES departamento (id)

);
CREATE TABLE professor_contato(
    prof_cpf (11) varchar NOT NULL,
    contato varchar (14) NOT NULL
    

    FOREIGN KEY (prof_cpf) REFERENCES professor (cpf),
    CONSTRAINT PK_professor_contato PRIMARY KEY (prof_cpf, contato)
    

)
CREATE TABLE avaliacao(
    prof_cpf varchar(11) NOT NULL,
    data_hora DATETIME NOT NULL,
    comentario varchar (500),
    nota INT, --mix e max?
    FOREIGN KEY (prof_cpf) REFERENCES professor (cpf)
    PRIMARY KEY (prof_cpf, data_hora)
);
-- adicionando as chaves estrangeiras que nao estavam disponiveis no momento
ALTER TABLE departamento
    ADD prof_chef_cpf varchar (11) --not null?
    ADD FOREIGN KEY prof_chef_cpf REFERENCES professor(cpf);

ALTER TABLE disciplina
    ADD disc_pre_requisito varchar (100),
    ADD FOREIGN KEY (disc_pre_requisito) REFERENCES disciplina (nome);

-- criando tabelas de relacionamento
CREATE TABLE aluno_disciplina(
    matricula varchar (10) NOT NULL,
    nome varchar (100) NOT NULL,
    
    PRIMARY KEY (matricula, nome),
    FOREIGN KEY (matricula) REFERENCES aluno (matricula),
    FOREIGN KEY (nome) REFERENCES disciplina(nome)
);

CREATE TABLE professor_disciplina(
    cpf varchar (11) NOT NULL,
    nome varchar (100) NOT NULL,

    PRIMARY KEY (cpf, nome),
    FOREIGN KEY (cpf) REFERENCES professor (cpf),
    FOREIGN KEY (nome) REFERENCES disciplina (nome)
);
--Inserindo 1 departamento, 5 alunos, 2 professores e 3 disciplinas
INSERT INTO departamento (nome, local) values('Ciências Exatas', 'Belo Horizonte');

INSERT INTO aluno values
    ('Livia Silva', '1990-02-01', '1234567890', 'Rua A, 42'),
    ('Dorothy Vaughan', '1989-03-19', '2234567890', 'Rua B, 6'),
    ('Nina Silva', '1993-12-31', '3334567890', 'Rua C, 190'),
    ('Grace Hopper', '1992-10-20', '4444567890', 'Rua D, 78'),
    ('Margaret Hamilton', '1992-18-20', '5555567890', 'Rua-E, 87');

INSERT INTO professor (inicio_contrato, nome, cpf) values
    ('2024-01-02', 'Hedy Lamarr', '12345678981'),
    ('2024-01-02','Ada Lovelace', '89876543212');

INSERT INTO disciplina values
    ('Introdução a programação', 30, 'A, B, C, D', NULL),
    ('Introdução a banco de dados, 45, X, Y, Z, W', NULL),
    ('Algoritmos e Estruturas de Dados', 60, 'F, G, H, I', 'Introdução a programação');