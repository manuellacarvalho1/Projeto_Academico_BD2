CREATE DOMAIN nota_t AS NUMERIC(4,2) CHECK (VALUE >= 0 AND VALUE <= 10);
CREATE DOMAIN pct_t AS NUMERIC(5,2) CHECK (VALUE >= 0 AND VALUE <= 100);
CREATE TYPE situacao_t AS ENUM ('Aprovado', 'Reprovado', 'Trancado');
CREATE TYPE tipo_usuario_t AS ENUM ('Administrador', 'Professor', 'Aluno', 'Secretaria');
CREATE TYPE vinculo_r AS ENUM ('Pré-requisito', 'Co-requisito', 'Recomendado');

CREATE TABLE tb_pais (
    id_pais SMALLINT PRIMARY KEY,
    nome_pais VARCHAR(60) UNIQUE,
    sigla_pais CHAR(2) UNIQUE,
    codigo_pais CHAR(3) UNIQUE
);

CREATE TABLE tb_estado (
    id_estado SMALLINT PRIMARY KEY,
    id_pais SMALLINT,
    nome_estado VARCHAR(60) UNIQUE,
    uf_estado CHAR(2) UNIQUE,

    CONSTRAINT fk_estado_pais FOREIGN KEY (id_pais) REFERENCES tb_pais(id_pais)
);

CREATE TABLE tb_municipio (
    id_municipio SMALLINT PRIMARY KEY,
    id_estado SMALLINT,
    nome_municipio VARCHAR(100),
    
    CONSTRAINT fk_municipio_estado FOREIGN KEY (id_estado) REFERENCES tb_estado(id_estado)
);

CREATE TABLE tb_cidade (
    id_cidade INT PRIMARY KEY,
    id_municipio SMALLINT,
    nome_cidade VARCHAR(100),
    
    CONSTRAINT fk_cidade_municipio FOREIGN KEY (id_municipio) REFERENCES tb_municipio(id_municipio)
);

CREATE TABLE tb_feriado (
    id_feriado INT PRIMARY KEY,
    id_pais SMALLINT,
    id_estado SMALLINT,
    id_municipio SMALLINT,
    id_cidade INT,
    nome_feriado VARCHAR(100),
    tipo_feriado VARCHAR(20),
    descricao_feriado VARCHAR(120),
    data_feriado DATE,

    CONSTRAINT fk_pais_feriado FOREIGN KEY (id_pais) REFERENCES tb_pais(id_pais),
    CONSTRAINT fk_estado_feriado FOREIGN KEY (id_estado) REFERENCES tb_estado(id_estado),
    CONSTRAINT fk_municipio_feriado FOREIGN KEY (id_municipio) REFERENCES tb_municipio(id_municipio),
    CONSTRAINT fk_cidade_feriado FOREIGN KEY (id_cidade) REFERENCES tb_cidade(id_cidade)
);

CREATE TABLE tb_campus (
    id_campus SMALLINT PRIMARY KEY,
    id_cidade INT,
    codigo_campus VARCHAR(20) UNIQUE,
    nome_campus VARCHAR(120),
    endereco_campus VARCHAR(200),
    bairro_campus VARCHAR(80),
    complemento_campus VARCHAR(100),
    telefone_campus VARCHAR(20),
    cep_campus CHAR(8),
    observacao_campus TEXT,

    CONSTRAINT fk_campus_cidade FOREIGN KEY (id_cidade) REFERENCES tb_cidade(id_cidade)
);

CREATE TABLE tb_predio (
    id_predio INT PRIMARY KEY,
    id_campus SMALLINT,
    nome_predio VARCHAR(80),
    codigo_predio VARCHAR(20) UNIQUE,

    CONSTRAINT fk_predio_campus FOREIGN KEY (id_campus) REFERENCES tb_campus(id_campus)
);

CREATE TABLE tb_bloco (
    id_bloco INT PRIMARY KEY,
    id_predio INT,
    nome_bloco VARCHAR(50),
    codigo_bloco VARCHAR(20) UNIQUE,

    CONSTRAINT fk_bloco_predio FOREIGN KEY (id_predio) REFERENCES tb_predio(id_predio)
);

CREATE TABLE tb_sala (
    id_sala INT PRIMARY KEY,
    id_bloco INT,
    codigo_sala VARCHAR(10) UNIQUE,
    nome_sala VARCHAR(100),
    numero_sala VARCHAR(20),
    tipo_sala VARCHAR(40),
    capacidade_sala SMALLINT,

    CONSTRAINT fk_sala_bloco FOREIGN KEY (id_bloco) REFERENCES tb_bloco(id_bloco)
);

CREATE TABLE tb_curso (
    id_curso SMALLINT PRIMARY KEY,
    id_campus SMALLINT,
    codigo_curso VARCHAR(10) UNIQUE,
    nome_curso VARCHAR(120),
    grau_curso VARCHAR(20),
    modalidade_curso VARCHAR(20),
    duracao_curso SMALLINT,
    ativo_curso BOOLEAN,
    ch_total_curso INT,

    CONSTRAINT fk_curso_campus FOREIGN KEY (id_campus) REFERENCES tb_campus(id_campus)
);

CREATE TABLE tb_curriculo (
    id_curriculo INT PRIMARY KEY,
    id_curso SMALLINT,
    codigo_curriculo VARCHAR(20) UNIQUE,
    periodo_vigencia VARCHAR(7),
    ativo_curriculo BOOLEAN,

    CONSTRAINT fk_curriculo_curso FOREIGN KEY (id_curso) REFERENCES tb_curso(id_curso)
);

CREATE TABLE tb_disciplina (
    id_disciplina INT PRIMARY KEY,
    codigo_disciplina VARCHAR(10) UNIQUE,
    nome_disciplina VARCHAR(120),
    ementa_disciplina TEXT,
    ch_teorica_disciplina SMALLINT,
    ch_pratica_disciplina SMALLINT,
    ch_total_disciplina SMALLINT
);

CREATE TABLE tb_curriculo_disciplina (
    id_curriculo INT,
    id_disciplina INT,
    periodo_curriculo_disciplina SMALLINT,
    ch_curriculo_disciplina SMALLINT,

    CONSTRAINT fk_curriculo_disciplina_curriculo FOREIGN KEY (id_curriculo) REFERENCES tb_curriculo(id_curriculo),
    CONSTRAINT fk_curriculo_disciplina_disciplina FOREIGN KEY (id_disciplina) REFERENCES tb_disciplina(id_disciplina),

    PRIMARY KEY (id_curriculo, id_disciplina)
);

CREATE TABLE tb_pre_requisito (
    id_disciplina INT,
    id_disciplina_requisito INT,
    vinculo_pre_requisito vinculo_r,

    CONSTRAINT fk_pre_requisito_disciplina FOREIGN KEY (id_disciplina) REFERENCES tb_disciplina(id_disciplina),
    CONSTRAINT fk_pre_requisito_disciplina_requisito FOREIGN KEY (id_disciplina_requisito) REFERENCES tb_disciplina(id_disciplina),

    PRIMARY KEY (id_disciplina, id_disciplina_requisito)
);

CREATE TABLE tb_periodo_letivo (
    id_periodo_letivo SMALLINT PRIMARY KEY,
    ano_periodo_letivo SMALLINT,
    semestre_periodo_letivo SMALLINT,
    data_inicio_periodo_letivo DATE,
    data_fim_periodo_letivo DATE
);

CREATE TABLE tb_professor (
    id_professor INT PRIMARY KEY,
    nome_professor VARCHAR(120),
    matricula_professor VARCHAR(15) UNIQUE,
    cpf_professor CHAR(11) UNIQUE,
    email_professor VARCHAR(120) UNIQUE,
    telefone_professor VARCHAR(20),
    titulacao_professor VARCHAR(60)
);

CREATE TABLE tb_turma (
    id_turma INT PRIMARY KEY,
    id_disciplina INT,
    id_professor INT,
    id_periodo_letivo SMALLINT,
    codigo_turma VARCHAR(20) UNIQUE,
    turno_turma VARCHAR(20),
    vagas_turma SMALLINT,
    capacidade_turma VARCHAR(20),

    CONSTRAINT fk_turma_disciplina FOREIGN KEY (id_disciplina) REFERENCES tb_disciplina(id_disciplina),
    CONSTRAINT fk_turma_periodo_letivo FOREIGN KEY (id_periodo_letivo) REFERENCES tb_periodo_letivo(id_periodo_letivo),
    CONSTRAINT fk_turma_professor FOREIGN KEY (id_professor) REFERENCES tb_professor(id_professor)
);

CREATE TABLE tb_turma_horario (
    id_turma_horario INT PRIMARY KEY,
    id_turma INT,
    id_sala INT,
    dia_semana_turma_horario VARCHAR(10),
    horario_inicio_turma_horario TIME,
    horario_fim_turma_horario TIME,

    CONSTRAINT fk_turma_horario_turma FOREIGN KEY (id_turma) REFERENCES tb_turma(id_turma),
    CONSTRAINT fk_turma_horario_sala FOREIGN KEY (id_sala) REFERENCES tb_sala(id_sala)  
);

CREATE TABLE tb_aluno (
    id_aluno INT PRIMARY KEY,
    id_curriculo INT,
    id_curso SMALLINT,
    nome_aluno VARCHAR(120),
    matricula_aluno VARCHAR(15) UNIQUE,
    cpf_aluno CHAR(11) UNIQUE,
    email_aluno VARCHAR(120) UNIQUE,
    telefone_aluno VARCHAR(20),
    data_nascimento_aluno DATE,
    ingresso_aluno DATE,
    ativo_aluno BOOLEAN,

    CONSTRAINT fk_aluno_curriculo FOREIGN KEY (id_curriculo) REFERENCES tb_curriculo(id_curriculo),
    CONSTRAINT fk_aluno_curso FOREIGN KEY (id_curso) REFERENCES tb_curso(id_curso)
);

CREATE TABLE tb_matricula (
    id_matricula INT PRIMARY KEY,
    id_aluno INT,
    id_turma INT,
    data_matricula DATE,
    status_matricula VARCHAR(20),

    CONSTRAINT fk_matricula_aluno FOREIGN KEY (id_aluno) REFERENCES tb_aluno(id_aluno),
    CONSTRAINT fk_matricula_turma FOREIGN KEY (id_turma) REFERENCES tb_turma(id_turma)
);

CREATE TABLE tb_historico (
    id_historico INT PRIMARY KEY,
    id_matricula INT,
    nota_p1_historico nota_t,
    nota_p2_historico nota_t,
    nota_p3_historico nota_t,
    frequencia_historico pct_t,
    situacao_historico situacao_t,
    media_final_historico NUMERIC(4,2) NULL,

    CONSTRAINT fk_historico_matricula FOREIGN KEY (id_matricula) REFERENCES tb_matricula(id_matricula)
);

CREATE TABLE tb_usuario (
    id_usuario INT PRIMARY KEY,
    nome_usuario VARCHAR(120),
    login_usuario VARCHAR(30) UNIQUE,
    senha_usuario VARCHAR(50),
    email_usuario VARCHAR(120) UNIQUE,
    tipo_usuario tipo_usuario_t,
    setor_usuario VARCHAR(100)
    
);

CREATE TABLE tb_log_matricula (
    id_log_matricula BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_matricula INT,
    id_usuario INT,
    operacao_log_matricula VARCHAR(20),
    data_hora_log_matricula TIMESTAMPTZ,
    detalhe_log_matricula JSONB,

    CONSTRAINT fk_log_matricula FOREIGN KEY (id_matricula) REFERENCES tb_matricula(id_matricula),
    CONSTRAINT fk_log_matricula_usuario FOREIGN KEY (id_usuario) REFERENCES tb_usuario(id_usuario)
);