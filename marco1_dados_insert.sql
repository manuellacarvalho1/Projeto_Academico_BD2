INSERT INTO tb_pais (id_pais, nome_pais, sigla_pais, codigo_pais) VALUES (1, 'Brasil', 'BR', 'BRA');
INSERT INTO tb_estado (id_estado, id_pais, nome_estado, uf_estado) VALUES (1, 1, 'Brasília', 'DF');
INSERT INTO tb_municipio (id_municipio, id_estado, nome_municipio) VALUES (1, 1, 'Brasília-Asa Sul');
INSERT INTO tb_cidade (id_cidade, id_municipio, nome_cidade) VALUES (1, 1, 'Brasília');
INSERT INTO tb_campus (id_campus, id_cidade, codigo_campus, nome_campus) VALUES (1, 1, 'CAMP-0110', 'Campus Asa Sul');

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
-- Ciência da Computação (1 a 6)
(1, 'CC001', 'Algoritmos e Programação I', 'Lógica e algoritmos.', 30, 30, 60),
(2, 'CC002', 'Banco de Dados I', 'Modelagem relacional e SQL.', 30, 30, 60),
(3, 'CC003', 'Banco de Dados II', 'SGBD, transações e otimização.', 30, 30, 60),
(4, 'CC004', 'Engenharia de Software', 'Ciclo de vida de sistemas.', 60, 0, 60),
(5, 'CC005', 'Estruturas de Dados', 'Listas, árvores e grafos.', 30, 30, 60),
(6, 'CC006', 'Sistemas Operacionais', 'Processos, memória e concorrência.', 40, 20, 60),

-- Direito (7 a 12)
(7, 'DIR01', 'Direito Constitucional I', 'Princípios fundamentais.', 60, 0, 60),
(8, 'DIR02', 'Direito Civil I', 'Pessoas e bens.', 60, 0, 60),
(9, 'DIR03', 'Direito Penal I', 'Teoria do crime.', 60, 0, 60),
(10, 'DIR04', 'Direito do Trabalho', 'Relações de trabalho.', 60, 0, 60),
(11, 'DIR05', 'Direito Tributário', 'Impostos e taxas.', 60, 0, 60),
(12, 'DIR06', 'Direito Administrativo', 'Atos administrativos.', 60, 0, 60),

-- Gastronomia (13 a 18)
(13, 'GAS01', 'Higiene e Segurança Alimentar', 'Boas práticas na cozinha.', 30, 30, 60),
(14, 'GAS02', 'Cozinha Clássica I', 'Técnicas fundamentais.', 20, 40, 60),
(15, 'GAS03', 'Panificação e Confeitaria', 'Massas e sobremesas.', 20, 40, 60),
(16, 'GAS04', 'Cozinha Brasileira', 'Gastronomia regional.', 20, 40, 60),
(17, 'GAS05', 'Enologia e Enogastronomia', 'Harmonização de vinhos.', 30, 30, 60),
(18, 'GAS06', 'Gestão de Restaurantes', 'Custos e salão.', 60, 0, 60),

-- Engenharia Civil (19 a 24)
(19, 'ENG01', 'Cálculo Diferencial I', 'Limites e derivadas.', 60, 0, 60),
(20, 'ENG02', 'Física Geral I', 'Mecânica clássica.', 40, 20, 60),
(21, 'ENG03', 'Resistência dos Materiais', 'Tensões e deformações.', 40, 20, 60),
(22, 'ENG04', 'Mecânica dos Solos', 'Propriedades do solo.', 30, 30, 60),
(23, 'ENG05', 'Estruturas de Concreto', 'Dimensionamento de vigas.', 30, 30, 60),
(24, 'ENG06', 'Hidráulica', 'Escoamento e tubulações.', 30, 30, 60),

-- Medicina (25 a 30)
(25, 'MED01', 'Anatomia Humana I', 'Sistemas do corpo.', 30, 30, 60),
(26, 'MED02', 'Histologia Humana', 'Tecidos biológicos.', 30, 30, 60),
(27, 'MED03', 'Fisiologia Humana', 'Funcionamento dos órgãos.', 40, 20, 60),
(28, 'MED04', 'Patologia Geral', 'Processos de doença.', 30, 30, 60),
(29, 'MED05', 'Farmacologia', 'Ação dos medicamentos.', 60, 0, 60),
(30, 'MED06', 'Semiologia Médica', 'Exame físico e diagnóstico.', 20, 40, 60),

-- Educação Física (31 a 36)
(31, 'EDF01', 'Cinesiologia e Biomecânica', 'Movimento humano.', 30, 30, 60),
(32, 'EDF02', 'Fisiologia do Exercício', 'Respostas ao treino.', 40, 20, 60),
(33, 'EDF03', 'Recreação e Lazer', 'Atividades lúdicas.', 30, 30, 60),
(34, 'EDF04', 'Atletismo e Desportos', 'Fundamentos esportivos.', 20, 40, 60),
(35, 'EDF05', 'Anatomia Aplicada ao Esporte', 'Musculatura em ação.', 30, 30, 60),
(36, 'EDF06', 'Medidas e Avaliação Física', 'Testes corporais.', 30, 30, 60),

-- Ciências Econômicas (37 a 42)
(37, 'ECO01', 'Introdução à Economia', 'Conceitos fundamentais.', 60, 0, 60),
(38, 'ECO02', 'Microeconomia I', 'Oferta, demanda e mercado.', 60, 0, 60),
(39, 'ECO03', 'Macroeconomia I', 'PIB, inflação e emprego.', 60, 0, 60),
(40, 'ECO04', 'Econometria', 'Modelos estatísticos.', 30, 30, 60),
(41, 'ECO05', 'História Econômica', 'Evolução dos mercados.', 60, 0, 60),
(42, 'ECO06', 'Economia Brasileira', 'Desenvolvimento do país.', 60, 0, 60),

-- Publicidade e Propaganda (43 a 48)
(43, 'PP001', 'Redação Publicitária I', 'Técnicas de texto para anúncios e campanhas.', 30, 30, 60),
(44, 'PP002', 'Direção de Arte', 'Fundamentos visuais, tipografia e layout.', 20, 40, 60),
(45, 'PP003', 'Planejamento de Comunicação', 'Estratégias de marca e posicionamento.', 60, 0, 60),
(46, 'PP004', 'Pesquisa de Mercado', 'Comportamento do consumidor e análise de dados.', 40, 20, 60),
(47, 'PP005', 'Mídia e Performance', 'Planejamento de mídia on e off-line.', 40, 20, 60),
(48, 'PP006', 'Atendimento e Gestão de Contas', 'Relação com cliente e fluxo em agência.', 60, 0, 60);

INSERT INTO tb_curriculo_disciplina (id_curriculo, id_disciplina, periodo_curriculo_disciplina, ch_curriculo_disciplina) VALUES
-- Currículo 1: Ciência da Computação (Disciplinas 1 a 6)
(1, 1, 1, 60), (1, 2, 1, 60), (1, 3, 2, 60), (1, 4, 2, 60), (1, 5, 3, 60), (1, 6, 3, 60),

-- Currículo 2: Direito (Disciplinas 7 a 12)
(2, 7, 1, 60), (2, 8, 1, 60), (2, 9, 2, 60), (2, 10, 2, 60), (2, 11, 3, 60), (2, 12, 3, 60),

-- Currículo 3: Gastronomia (Disciplinas 13 a 18)
(3, 13, 1, 60), (3, 14, 1, 60), (3, 15, 2, 60), (3, 16, 2, 60), (3, 17, 3, 60), (3, 18, 3, 60),

-- Currículo 4: Engenharia Civil (Disciplinas 19 a 24)
(4, 19, 1, 60), (4, 20, 1, 60), (4, 21, 2, 60), (4, 22, 2, 60), (4, 23, 3, 60), (4, 24, 3, 60),

-- Currículo 5: Medicina (Disciplinas 25 a 30)
(5, 25, 1, 60), (5, 26, 1, 60), (5, 27, 2, 60), (5, 28, 2, 60), (5, 29, 3, 60), (5, 30, 3, 60),

-- Currículo 6: Educação Física (Disciplinas 31 a 36)
(6, 31, 1, 60), (6, 32, 1, 60), (6, 33, 2, 60), (6, 34, 2, 60), (6, 35, 3, 60), (6, 36, 3, 60),

-- Currículo 7: Ciências Econômicas (Disciplinas 37 a 42)
(7, 37, 1, 60), (7, 38, 1, 60), (7, 39, 2, 60), (7, 40, 2, 60), (7, 41, 3, 60), (7, 42, 3, 60);

INSERT INTO tb_pre_requisito (id_disciplina, id_disciplina_requisito, vinculo_pre_requisito) VALUES

-- 1. CIÊNCIA DA COMPUTAÇÃO
-- Banco de Dados II (3) exige Banco de Dados I (2)
(3, 2, 'Pré-requisito'),
-- Engenharia de Software (4) exige Algoritmos I (1)
(4, 1, 'Pré-requisito'),
-- Estruturas de Dados (5) exige Algoritmos I (1), BD I (2) e BD II (3)
(5, 1, 'Pré-requisito'),
(5, 2, 'Pré-requisito'),
(5, 3, 'Pré-requisito'),
-- Sistemas Operacionais (6) exige Algoritmos I (1)
(6, 1, 'Pré-requisito'),

-- 2. DIREITO
-- Direito do Trabalho (10) exige Direito Civil I (8)
(10, 8, 'Pré-requisito'),
-- Direito Tributário (11) exige Direito Constitucional I (7)
(11, 7, 'Pré-requisito'),
-- Direito Administrativo (12) exige Direito Constitucional I (7)
(12, 7, 'Pré-requisito'),

-- 3. GASTRONOMIA
-- Panificação e Confeitaria (15) exige Cozinha Clássica I (14)
(15, 14, 'Pré-requisito'),
-- Cozinha Brasileira (16) exige Higiene (13) e Cozinha Clássica I (14)
(16, 13, 'Pré-requisito'),
(16, 14, 'Pré-requisito'),
-- Enologia (17) tem como recomendado Cozinha Clássica I (14)
(17, 14, 'Recomendado'),
-- Gestão de Restaurantes (18) exige Higiene e Segurança Alimentar (13)
(18, 13, 'Pré-requisito'),

-- 4. ENGENHARIA CIVIL
-- Resistência dos Materiais (21) exige Cálculo I (19) e Física I (20)
(21, 19, 'Pré-requisito'),
(21, 20, 'Pré-requisito'),
-- Mecânica dos Solos (22) exige Física I (20)
(22, 20, 'Pré-requisito'),
-- Estruturas de Concreto (23) exige Resistência dos Materiais (21)
(23, 21, 'Pré-requisito'),
-- Hidráulica (24) exige Física I (20)
(24, 20, 'Pré-requisito'),


-- 5. MEDICINA
-- Fisiologia Humana (27) exige Anatomia I (25) e Histologia (26)
(27, 25, 'Pré-requisito'),
(27, 26, 'Pré-requisito'),
-- Patologia Geral (28) exige Histologia (26)
(28, 26, 'Pré-requisito'),
-- Farmacologia (29) exige Fisiologia Humana (27)
(29, 27, 'Pré-requisito'),
-- Semiologia Médica (30) exige Anatomia I (25) e Patologia Geral (28)
(30, 25, 'Pré-requisito'),
(30, 28, 'Pré-requisito'),


-- 6. EDUCAÇÃO FÍSICA
-- Atletismo e Desportos (34) exige Cinesiologia e Biomecânica (31)
(34, 31, 'Pré-requisito'),
-- Anatomia Aplicada ao Esporte (35) exige Cinesiologia e Biomecânica (31)
(35, 31, 'Pré-requisito'),
-- Medidas e Avaliação Física (36) exige Fisiologia do Exercício (32)
(36, 32, 'Pré-requisito'),

-- 7. CIÊNCIAS ECONÔMICAS
-- Microeconomia I (38) exige Introdução à Economia (37)
(38, 37, 'Pré-requisito'),
-- Macroeconomia I (39) exige Introdução à Economia (37)
(39, 37, 'Pré-requisito'),
-- Econometria (40) exige Microeconomia I (38)
(40, 38, 'Pré-requisito'),
-- História Econômica (41) tem como recomendado Introdução à Economia (37)
(41, 37, 'Recomendado'),
-- Economia Brasileira (42) exige Macroeconomia I (39)
(42, 39, 'Pré-requisito');

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
    'prof' || i || '@iesb.br',
    '619811100' || LPAD(i::text, 2, '0'),
    'Mestre'
FROM generate_series(1, 21) AS i;

INSERT INTO tb_turma (id_turma, id_disciplina, id_professor, id_periodo_letivo, codigo_turma, turno_turma, vagas_turma, capacidade_turma) VALUES
-- 1. Ciência da Computação (Professores 1, 2 e 3)
(1, 1, 1, 2, 'TURMA-CC-A', 'Matutino', 10, '20'),
(2, 2, 2, 2, 'TURMA-CC-B', 'Vespertino', 6, '20'),
(3, 3, 3, 2, 'TURMA-CC-C', 'Noturno', 4, '20'),

-- 2. Direito (Professores 4, 5 e 6)
(4, 7, 4, 2, 'TURMA-DIR-A', 'Matutino', 11, '20'),
(5, 8, 5, 2, 'TURMA-DIR-B', 'Vespertino', 9, '20'),
(6, 9, 6, 2, 'TURMA-DIR-C', 'Noturno', 0, '20'),

-- 3. Gastronomia (Professores 7, 8 e 9)
(7, 13, 7, 2, 'TURMA-GAS-A', 'Matutino', 8, '20',
(8, 14, 8, 2, 'TURMA-GAS-B', 'Vespertino', 8, '20'),
(9, 15, 9, 2, 'TURMA-GAS-C', 'Noturno', 4, '20'),

-- 4. Engenharia Civil (Professores 10, 11 e 12)
(10, 19, 10, 2, 'TURMA-ENG-A', 'Matutino', 9, '20'),
(11, 20, 11, 2, 'TURMA-ENG-B', 'Vespertino', 9, '20'),
(12, 21, 12, 2, 'TURMA-ENG-C', 'Noturno', 2, '20'),

-- 5. Medicina (Professores 13, 14 e 15)
(13, 25, 13, 2, 'TURMA-MED-A', 'Integral', 20, '20'),
(14, 26, 14, 2, 'TURMA-MED-B', 'Integral', 20, '20'),
(15, 27, 15, 2, 'TURMA-MED-C', 'Integral', 20, '20'),

-- 6. Educação Física (Professores 16, 17 e 18)
(16, 31, 16, 2, 'TURMA-EDF-A', 'Matutino', 7, '20'),
(17, 32, 17, 2, 'TURMA-EDF-B', 'Vespertino', 13, '20'),
(18, 33, 18, 2, 'TURMA-EDF-C', 'Noturno', 0, '20'),

-- 7. Ciências Econômicas (Professores 19, 20 e 21)
(19, 37, 19, 2, 'TURMA-ECO-A', 'Matutino', 7, '20'),
(20, 38, 20, 2, 'TURMA-ECO-B', 'Vespertino', 7, '20'),
(21, 39, 21, 2, 'TURMA-ECO-C', 'Noturno', 6, '20');



-- TABELAS QUE FALTAM

1. tb_professores
2. tb_alunos
3. tb_matriculas
4. tb_historico
5. tb_sala
6. tb_bloco
7. tb_predio
8. tb_turma_horario

INSERT INTO tb_aluno (id_aluno, id_curriculo, id_curso, nome_aluno, matricula_aluno, cpf_aluno, email_aluno, ativo_aluno)
SELECT 
    i, 
    (i % 8) + 1, 
    (i % 8) + 1, 
    'Aluno' || i, 
    '2026' || LPAD(i::text, 4, '0'), 
    LPAD(i::text, 11, '0'), 
    'aluno' || i || '@iesb.com', 
    true
FROM generate_series(1, 300) AS i;


-- 7. INSERIR 300 MATRÍCULAS E HISTÓRICOS
INSERT INTO tb_matricula (id_matricula, id_aluno, id_turma, data_matricula, status_matricula)
SELECT ROW_NUMBER() OVER () AS id_matricula, a.id_aluno, t.id_turma, CURRENT_DATE, 'Concluída'
FROM tb_aluno a 
CROSS JOIN (SELECT id_turma FROM tb_turma LIMIT 3) t;

INSERT INTO tb_historico (id_historico, id_matricula, situacao_historico, media_final_historico)
SELECT id_matricula, id_matricula, 'Aprovado'::situacao_t, CAST(7.0 + ((id_matricula % 30) / 10.0) AS NUMERIC(4,2))
FROM tb_matricula;
