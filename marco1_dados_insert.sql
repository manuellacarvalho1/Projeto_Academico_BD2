INSERT INTO tb_pais (id_pais, nome_pais, sigla_pais, codigo_pais) VALUES (1, 'Brasil', 'BR', 'BRA');
INSERT INTO tb_estado (id_estado, id_pais, nome_estado, uf_estado) VALUES (1, 1, 'Brasília', 'DF');
INSERT INTO tb_municipio (id_municipio, id_estado, nome_municipio) VALUES (1, 1, 'Brasília-Asa Sul');
INSERT INTO tb_cidade (id_cidade, id_municipio, nome_cidade) VALUES (1, 1, 'Brasília');
INSERT INTO tb_campus (id_campus, id_cidade, codigo_campus, nome_campus) VALUES (1, 1, 'CAMP-0110', 'Campus Asa Sul');
INSERT INTO tb_predio (id_predio, id_campus, nome_predio, codigo_predio) VALUES 
(1, 1, 'Prédio 1', 'PREDIO-01'), 
(2, 1, 'Prédio 2', 'PREDIO-02'), 
(3, 1, 'Prédio 3', 'PREDIO-03'),
(4, 1, 'Prédio 4', 'PREDIO-04');
INSERT INTO tb_bloco (id_bloco, id_predio, nome_bloco, codigo_bloco) VALUES 
(1, 1, 'Bloco A', 'BLOCO-A'),
(2, 2, 'Bloco B', 'BLOCO-B'),
(3, 2, 'Bloco C', 'BLOCO-C'),
(4, 2, 'Bloco D', 'BLOCO-D'),
(5, 3, 'Bloco E', 'BLOCO-E'),
(6, 3, 'Bloco F', 'BLOCO-F'),
(7, 4, 'Bloco G', 'BLOCO-G');
INSERT INTO tb_sala (id_sala, id_bloco, codigo_sala, nome_sala, numero_sala, tipo_sala, capacidade_sala) VALUES
(1, 7, 'SL-CC-01',  'Laboratório de Informática Avançada', '741', 'Laboratório', 40),
(2, 5, 'SL-DIR-01', 'Sala de Aula Teórica', '531', 'Teórica', 40),
(3, 3, 'SL-GAS-01', 'Cozinha Industrial', '321', 'Prática', 40),
(4, 7, 'SL-ENG-01', 'Laboratório de Engenharia', '742', 'Laboratório', 40),
(5, 7, 'SL-MED-01', 'Laboratório de Anatomia Humana', '743', 'Laboratório', 40),
(6, 2, 'SL-EDF-01', 'Quadra Poliesportiva Coberta', '221', 'Prática', 40),
(7, 5, 'SL-ECO-01', 'Sala de Aula Teórica', '532', 'Teórica', 40);

INSERT INTO tb_curso (id_curso, id_campus, codigo_curso, nome_curso, grau_curso, modalidade_curso, duracao_curso, ativo_curso, ch_total_curso) VALUES 
(1, 1, 'CC01', 'Ciência da Computação', 'Bacharelado', 'Presencial', 4, TRUE, 3000),
(2, 1, 'D01', 'Direito', 'Bacharelado', 'Presencial', 5, TRUE, 3700),
(3, 1, 'G01', 'Gastronomia', 'Tecnólogo', 'Presencial', 3, TRUE, 2400),
(4, 1, 'ENGC01', 'Engenharia Civil', 'Bacharelado', 'Presencial', 5, TRUE, 3600),
(5, 1, 'MED01', 'Medicina', 'Bacharelado', 'Presencial', 6, TRUE, 7200),
(6, 1, 'PP01', 'Publicidade e Propaganda', 'Bacharelado', 'Presencial', 4, TRUE, 2700),
(7, 1, 'EDF01', 'Educação Física', 'Licenciatura', 'Presencial', 4, TRUE, 3200),
(8, 1, 'CE01', 'Ciências Econômicas', 'Bacharelado', 'Presencial', 4, TRUE, 3000);

INSERT INTO tb_curriculo (id_curriculo, id_curso, codigo_curriculo, periodo_vigencia, ativo_curriculo) VALUES
(1, 1, 'CURR-CC-20262',  '2026.2', TRUE), 
(2, 2, 'CURR-DIR-20262', '2026.2', TRUE), 
(3, 3, 'CURR-GAS-20262', '2026.2', TRUE), 
(4, 4, 'CURR-ENG-20262', '2026.2', TRUE), 
(5, 5, 'CURR-MED-20262', '2026.2', TRUE), 
(6, 7, 'CURR-EDF-20262', '2026.2', TRUE),
(7, 8, 'CURR-ECO-20262', '2026.2', TRUE); 

INSERT INTO tb_disciplina (id_disciplina, codigo_disciplina, nome_disciplina, ementa_disciplina, ch_teorica_disciplina, ch_pratica_disciplina, ch_total_disciplina) VALUES
-- Ciência da Computação (1 a 3 têm turmas, 4 está vazia)
(1, 'CC001', 'Algoritmos e Programação I', 'Lógica e algoritmos.', 30, 30, 60),
(2, 'CC002', 'Banco de Dados I', 'Modelagem relacional e SQL.', 30, 30, 60),
(3, 'CC003', 'Banco de Dados II', 'SGBD, transações e otimização.', 30, 30, 60),
(4, 'CC004', 'Engenharia de Software', 'Ciclo de vida de sistemas.', 60, 0, 60),

-- Direito (7 a 9 têm turmas, 10 está vazia)
(7, 'DIR01', 'Direito Constitucional I', 'Princípios fundamentais.', 60, 0, 60),
(8, 'DIR02', 'Direito Civil I', 'Pessoas e bens.', 60, 0, 60),
(9, 'DIR03', 'Direito Penal I', 'Teoria do crime.', 60, 0, 60),
(10, 'DIR04', 'Direito do Trabalho', 'Relações de trabalho.', 60, 0, 60),

-- Gastronomia (13 a 15 têm turmas, 16 está vazia)
(13, 'GAS01', 'Higiene e Segurança Alimentar', 'Boas práticas na cozinha.', 30, 30, 60),
(14, 'GAS02', 'Cozinha Clássica I', 'Técnicas fundamentais.', 20, 40, 60),
(15, 'GAS03', 'Panificação e Confeitaria', 'Massas e sobremesas.', 20, 40, 60),
(16, 'GAS04', 'Cozinha Brasileira', 'Gastronomia regional.', 20, 40, 60),

-- Engenharia Civil (19 a 21 têm turmas, 22 está vazia)
(19, 'ENG01', 'Cálculo Diferencial I', 'Limites e derivadas.', 60, 0, 60),
(20, 'ENG02', 'Física Geral I', 'Mecânica clássica.', 40, 20, 60),
(21, 'ENG03', 'Resistência dos Materiais', 'Tensões e deformações.', 40, 20, 60),
(22, 'ENG04', 'Mecânica dos Solos', 'Propriedades do solo.', 30, 30, 60),

-- Medicina (25 a 27 têm turmas, 28 está vazia)
(25, 'MED01', 'Anatomia Humana I', 'Sistemas do corpo.', 30, 30, 60),
(26, 'MED02', 'Histologia Humana', 'Tecidos biológicos.', 30, 30, 60),
(27, 'MED03', 'Fisiologia Humana', 'Funcionamento dos órgãos.', 40, 20, 60),
(28, 'MED04', 'Patologia Geral', 'Processos de doença.', 30, 30, 60),

-- Educação Física (31 a 33 têm turmas, 34 está vazia)
(31, 'EDF01', 'Cinesiologia e Biomecânica', 'Movimento humano.', 30, 30, 60),
(32, 'EDF02', 'Fisiologia do Exercício', 'Respostas ao treino.', 40, 20, 60),
(33, 'EDF03', 'Recreação e Lazer', 'Atividades lúdicas.', 30, 30, 60),
(34, 'EDF04', 'Atletismo e Desportos', 'Fundamentos esportivos.', 20, 40, 60),

-- Ciências Econômicas (37 a 39 têm turmas, 40 está vazia)
(37, 'ECO01', 'Introdução à Economia', 'Conceitos fundamentais.', 60, 0, 60),
(38, 'ECO02', 'Microeconomia I', 'Oferta, demanda e mercado.', 60, 0, 60),
(39, 'ECO03', 'Macroeconomia I', 'PIB, inflação e emprego.', 60, 0, 60),
(40, 'ECO04', 'Econometria', 'Modelos estatísticos.', 30, 30, 60),

-- Publicidade e Propaganda
(43, 'PP001', 'Redação Publicitária I', 'Técnicas de texto.', 30, 30, 60),
(44, 'PP002', 'Direção de Arte', 'Fundamentos visuais.', 20, 40, 60),
(45, 'PP003', 'Planejamento de Comunicação', 'Estratégias de marca.', 60, 0, 60),
(46, 'PP004', 'Pesquisa de Mercado', 'Análise de dados.', 40, 20, 60);

INSERT INTO tb_curriculo_disciplina (id_curriculo, id_disciplina, periodo_curriculo_disciplina, ch_curriculo_disciplina) VALUES
-- CC (Currículo 1)
(1, 1, 1, 60), (1, 2, 1, 60), (1, 3, 2, 60), (1, 4, 2, 60),
-- Direito (Currículo 2)
(2, 7, 1, 60), (2, 8, 1, 60), (2, 9, 2, 60), (2, 10, 2, 60),
-- Gastronomia (Currículo 3)
(3, 13, 1, 60), (3, 14, 1, 60), (3, 15, 2, 60), (3, 16, 2, 60),
-- Engenharia Civil (Currículo 4)
(4, 19, 1, 60), (4, 20, 1, 60), (4, 21, 2, 60), (4, 22, 2, 60),
-- Medicina (Currículo 5)
(5, 25, 1, 60), (5, 26, 1, 60), (5, 27, 2, 60), (5, 28, 2, 60),
-- Educação Física (Currículo 6)
(6, 31, 1, 60), (6, 32, 1, 60), (6, 33, 2, 60), (6, 34, 2, 60),
-- Ciências Econômicas (Currículo 7)
(7, 37, 1, 60), (7, 38, 1, 60), (7, 39, 2, 60), (7, 40, 2, 60);

INSERT INTO tb_pre_requisito (id_disciplina, id_disciplina_requisito, vinculo_pre_requisito) VALUES
-- Ciência da Computação: BD II (3) exige BD I (2). Eng de Software (4) exige Algoritmos (1).
(3, 2, 'Pré-requisito'),
(4, 1, 'Pré-requisito'),
-- Direito: Direito do Trabalho (10) exige Direito Civil I (8).
(10, 8, 'Pré-requisito'),
-- Gastronomia: Panificação (15) exige Cozinha Clássica I (14).
(15, 14, 'Pré-requisito'),
-- Engenharia Civil: Resistência dos Materiais (21) exige Cálculo (19) e Física (20).
(21, 19, 'Pré-requisito'),
(21, 20, 'Pré-requisito'),
-- Medicina: Fisiologia (27) exige Anatomia (25) e Histologia (26).
(27, 25, 'Pré-requisito'),
(27, 26, 'Pré-requisito'),
-- Educação Física: Atletismo (34) exige Cinesiologia (31).
(34, 31, 'Pré-requisito'),
-- Economia: Microeconomia (38) e Macroeconomia (39) exigem Introdução à Economia (37).
(38, 37, 'Pré-requisito'),
(39, 37, 'Pré-requisito'),
-- PP: Planejamento (45) exige Redação (43).
(45, 43, 'Pré-requisito');

INSERT INTO tb_periodo_letivo (id_periodo_letivo, ano_periodo_letivo, semestre_periodo_letivo, data_inicio_periodo_letivo, data_fim_periodo_letivo) VALUES
(1, 2026, 2, '2026-08-01', '2026-11-30');

INSERT INTO tb_professor (
    id_professor, 
    nome_professor, 
    matricula_professor, 
    cpf_professor, 
    email_professor, 
    telefone_professor, 
    titulacao_professor
)
SELECT 
    i,
    'Professor ' || i,
    'PROF' || i,
    LPAD(i::text, 11, '0'),
    'prof' || i || '@iesb.edu.br',
    '61999125' || LPAD(i::text, 2, '0'),
    'Mestre'
FROM generate_series(1, 21) AS i;

INSERT INTO tb_turma (id_turma, id_disciplina, id_professor, id_periodo_letivo, codigo_turma, turno_turma, vagas_turma, capacidade_turma) VALUES
-- 1. Ciência da Computação (Professores 1, 2 e 3)
(1, 1, 1, 2, 'TURMA-CC-A', 'Matutino', 15, '30'),
(2, 2, 2, 2, 'TURMA-CC-B', 'Vespertino', 8, '30'),
(3, 3, 3, 2, 'TURMA-CC-C', 'Noturno', 7, '30'),

-- 2. Direito (Professores 4, 5 e 6)
(4, 7, 4, 2, 'TURMA-DIR-A', 'Matutino', 11, '30'),
(5, 8, 5, 2, 'TURMA-DIR-B', 'Vespertino', 9, '30'),
(6, 9, 6, 2, 'TURMA-DIR-C', 'Noturno', 10, '30'),

-- 3. Gastronomia (Professores 7, 8 e 9)
(7, 13, 7, 2, 'TURMA-GAS-A', 'Matutino', 12, '30',
(8, 14, 8, 2, 'TURMA-GAS-B', 'Vespertino', 18, '30'),
(9, 15, 9, 2, 'TURMA-GAS-C', 'Noturno', 0, '30'),

-- 4. Engenharia Civil (Professores 10, 11 e 12)
(10, 19, 10, 2, 'TURMA-ENG-A', 'Matutino', 19, '30'),
(11, 20, 11, 2, 'TURMA-ENG-B', 'Vespertino', 6, '30'),
(12, 21, 12, 2, 'TURMA-ENG-C', 'Noturno', 5, '30'),

-- 5. Medicina (Professores 13, 14 e 15)
(13, 25, 13, 2, 'TURMA-MED-A', 'Integral', 10, '30'),
(14, 26, 14, 2, 'TURMA-MED-B', 'Integral', 10, '30'),
(15, 27, 15, 2, 'TURMA-MED-C', 'Integral', 10, '30'),

-- 6. Educação Física (Professores 16, 17 e 18)
(16, 31, 16, 2, 'TURMA-EDF-A', 'Matutino', 17, '30'),
(17, 32, 17, 2, 'TURMA-EDF-B', 'Vespertino', 13, '30'),
(18, 33, 18, 2, 'TURMA-EDF-C', 'Noturno', 0, '30'),

-- 7. Ciências Econômicas (Professores 19, 20 e 21)
(19, 37, 19, 2, 'TURMA-ECO-A', 'Matutino', 15, '30'),
(20, 38, 20, 2, 'TURMA-ECO-B', 'Vespertino', 14, '30'),
(21, 39, 21, 2, 'TURMA-ECO-C', 'Noturno', 6, '30');

INSERT INTO tb_aluno (
    id_aluno, 
	id_curriculo, 
	id_curso, 
	nome_aluno, 
	matricula_aluno, 
    cpf_aluno, 
	email_aluno, 
	telefone_aluno, 
	data_nascimento_aluno, 
	ingresso_aluno, 
	ativo_aluno
)
SELECT 
    i,
    CASE 
        WHEN i <= 30 THEN 1 
        WHEN i <= 60 THEN 2  
        WHEN i <= 90 THEN 3  
        WHEN i <= 120 THEN 4 
        WHEN i <= 150 THEN 5
        WHEN i <= 180 THEN 6 
        ELSE 7               
    END,
    CASE 
        WHEN i <= 30 THEN 1 
        WHEN i <= 60 THEN 2 
        WHEN i <= 90 THEN 3 
        WHEN i <= 120 THEN 4 
        WHEN i <= 150 THEN 5 
        WHEN i <= 180 THEN 7 
        ELSE 8               
    END,
    'Aluno ' || i,
    '2512130' || LPAD(i::text, 3, '0'),
    LPAD(i::text, 11, '1'),
    'aluno' || i || '@iesb.edu.br', 
    '61998641' || LPAD(i::text, 3, '0'),
    '2000-01-01'::DATE + i,
    '2026-02-01',
    TRUE
FROM generate_series(1, 215) AS i;

INSERT INTO tb_matricula (
	id_matricula, 
	id_aluno, 
	id_turma, 
	data_matricula, 
	status_matricula
)
SELECT 
    i, 
    i, 
    CASE 
        WHEN i <= 15 THEN 1  
        WHEN i <= 23 THEN 2 
        WHEN i <= 30 THEN 3  
        WHEN i <= 41 THEN 4  
        WHEN i <= 50 THEN 5  
        WHEN i <= 60 THEN 6  
        WHEN i <= 72 THEN 7  
        WHEN i <= 90 THEN 8  
        WHEN i <= 109 THEN 10 
        WHEN i <= 115 THEN 11 
        WHEN i <= 120 THEN 12 
        WHEN i <= 130 THEN 13 
        WHEN i <= 140 THEN 14 
        WHEN i <= 150 THEN 15 
        WHEN i <= 167 THEN 16 
        WHEN i <= 180 THEN 17 
        WHEN i <= 195 THEN 19 
        WHEN i <= 209 THEN 20
        ELSE 21               
    END,
    '2026-08-01', 
    'Ativo'
FROM generate_series(1, 215) AS i;

INSERT INTO tb_matricula (
	id_matricula, 
	id_aluno,
	id_turma, 
	data_matricula,
	status_matricula
) 
SELECT 
	i + 300,
	i,
CASE
	WHEN i <= 10 THEN 21
	WHEN i <= 25 THEN 3
	WHEN i <= 35 THEN 20
	WHEN i <= 50 THEN 12
	WHEN i <= 60 THEN 16
	WHEN i <= 73 THEN 2
	WHEN i <= 90 THEN 6
	ELSE 17
END, 
	'2026-08-01',
	'Ativo'
FROM generate_series(1, 100) AS i;

INSERT INTO tb_turma_horario (id_turma_horario, id_turma, id_sala, dia_semana_turma_horario, horario_inicio_turma_horario, horario_fim_turma_horario) VALUES
-- 1. Ciência da Computação
-- MATUTINO
(1, 1, 1, 'Segunda', '08:15:00', '11:00:00'), 
(2, 1, 1, 'Quarta',  '08:15:00', '11:00:00'),
- VESPERTINO
(3, 2, 1, 'Segunda', '14:15:00', '17:00:00'), 
(4, 2, 1, 'Quarta',  '14:15:00', '17:00:00'),
-- NOTURNO
(5, 3, 1, 'Segunda', '19:15:00', '22:00:00'), 
(6, 3, 1, 'Quarta',  '19:15:00', '22:00:00'),

-- 2. Direito 
-- MATUTINO
(7, 4, 2, 'Terca',   '08:15:00', '11:00:00'), 
(8, 4, 2, 'Quinta',  '08:15:00', '11:00:00'),
-- VESPERTINO
(9, 5, 2, 'Terca',   '14:15:00', '17:00:00'), 
(10, 5, 2, 'Quinta', '14:15:00', '17:00:00'),
-- NOTURNO
(11, 6, 2, 'Terca',  '19:15:00', '22:00:00'), 
(12, 6, 2, 'Quinta', '19:15:00', '22:00:00'),

-- 3. Gastronomia
-- MATUTINO
(13, 7, 3, 'Segunda', '08:15:00', '11:00:00'),
(14, 7, 3, 'Quarta',  '08:15:00', '11:00:00'),
-- VESPERTINO
(15, 8, 3, 'Segunda', '14:15:00', '17:00:00'), 
(16, 8, 3, 'Quarta',  '14:15:00', '17:00:00'),
-- NOTURNO
(17, 9, 3, 'Segunda', '19:15:00', '22:00:00'), 
(18, 9, 3, 'Quarta',  '19:15:00', '22:00:00'),

-- 4. Engenharia Civil 
-- MATUTINO
(19, 10, 4, 'Terca',   '08:15:00', '11:00:00'), 
(20, 10, 4, 'Quinta',  '08:15:00', '11:00:00'),
-- VESPERTINO
(21, 11, 4, 'Terca',   '14:15:00', '17:00:00'), 
(22, 11, 4, 'Quinta',  '14:15:00', '17:00:00'),
-- NOTURNO
(23, 12, 4, 'Terca',   '19:15:00', '22:00:00'), 
(24, 12, 4, 'Quinta',  '19:15:00', '22:00:00'),

-- 5. Medicina
-- INTEGRAL
(25, 13, 5, 'Segunda', '08:15:00', '17:00:00'), 
(26, 13, 5, 'Terça', '08:15:00', '17:00:00'),
(27, 14, 5, 'Segunda',   '08:15:00', '17:00:00'), 
(28, 14, 5, 'Terça',   '08:15:00', '17:00:00'),
(29, 15, 5, 'Segunda',  '08:15:00', '17:00:00'), 
(30, 15, 5, 'Terça',  '08:15:00', '17:00:00'),

-- 6. Educação Física
-- MATUTINO
(31, 16, 6, 'Segunda', '08:15:00', '10:00:00'),
(32, 16, 6, 'Quarta',  '08:15:00', '10:00:00'),
-- VESPERTINO
(33, 17, 6, 'Segunda', '14:15:00', '16:00:00'), 
(34, 17, 6, 'Quarta',  '14:15:00', '16:00:00'),
-- NOTURNO
(35, 18, 6, 'Segunda', '19:15:00', '21:00:00'),
(36, 18, 6, 'Quarta',  '19:15:00', '21:00:00'),

-- 7. Ciências Econômicas
-- MATUTINO
(37, 19, 7, 'Terca',   '08:15:00', '11:00:00'), 
(38, 19, 7, 'Quinta',  '08:15:00', '11:00:00'),
-- VESPERTINO
(39, 20, 7, 'Terca',   '14:15:00', '17:00:00'), 
(40, 20, 7, 'Quinta',  '14:15:00', '17:00:00'),
-- NOTURNO
(41, 21, 7, 'Terca',   '19:15:00', '22:00:00'), 
(42, 21, 7, 'Quinta',  '19:15:00', '22:00:00');

INSERT INTO tb_historico (
    id_historico,
    id_matricula,
    nota_p1_historico,
    nota_p2_historico,
    nota_p3_historico,
    frequencia_historico,
    situacao_historico,
    media_final_historico
)
SELECT 
    i, 
    i,
    p1, 
    p2,
    CASE 
        WHEN (0.4 * p1 + 0.6 * p2) >= 5.0 THEN NULL 
        ELSE p3 
    END,  
    frequencia,
    CASE 
        WHEN frequencia < 75 THEN 'Reprovado por Falta'
        WHEN (0.4 * p1 + 0.6 * p2) >= 5.0 THEN 'Aprovado'
        WHEN GREATEST(0.4 * p3 + 0.6 * p2, 0.4 * p1 + 0.6 * p3) >= 5.0 THEN 'Aprovado'
        ELSE 'Reprovado por Nota'
    END,
    CASE 
        WHEN (0.4 * p1 + 0.6 * p2) >= 5.0 THEN ROUND((0.4 * p1 + 0.6 * p2), 2)
        ELSE ROUND(GREATEST(0.4 * p3 + 0.6 * p2, 0.4 * p1 + 0.6 * p3), 2)
    END   
FROM (
    SELECT 
        i,
        ROUND((random() * 10)::numeric, 2) AS p1,
        ROUND((random() * 10)::numeric, 2) AS p2,
        ROUND((random() * 10)::numeric, 2) AS p3,
        ROUND((random() * 30 + 70)::numeric, 2) AS frequencia
    FROM generate_series(1, 315) AS i
) AS notas;

		






