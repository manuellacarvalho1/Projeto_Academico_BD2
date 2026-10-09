-- 1. DADOS BASE
INSERT INTO tb_pais (id_pais, nome_pais, sigla_pais, codigo_pais) VALUES (1, 'Brasil', 'BR', 'BRA');
INSERT INTO tb_estado (id_estado, id_pais, nome_estado, uf_estado) VALUES (1, 1, 'Brasília', 'DF');
INSERT INTO tb_municipio (id_municipio, id_estado, nome_municipio) VALUES (1, 1, 'Brasília-Asa Sul');
INSERT INTO tb_cidade (id_cidade, id_municipio, nome_cidade) VALUES (1, 1, 'Brasília');
INSERT INTO tb_campus (id_campus, id_cidade, codigo_campus, nome_campus) VALUES (1, 1, 'CAMP-0110', 'Campus Asa Sul');


-- 2. CRIAR 8 CURSOS E 8 CURRÍCULOS
-- gera os cursos automaticamente
INSERT INTO tb_curso (id_curso, id_campus, codigo_curso, nome_curso, ativo_curso, ch_total_curso) 
SELECT i, 1, 'CUR-' || i, 'Curso ' || i, true, 3000 
FROM generate_series(1, 8) AS i;

-- gera 8 matrizes curriculares (uma para cada curso)
INSERT INTO tb_curriculo (id_curriculo, id_curso, codigo_curriculo, ativo_curriculo) 
SELECT i, i, 'IESB-' || i, true 
FROM generate_series(1, 8) AS i;

-- 3. DISCIPLINAS E PRÉ-REQUISITOS
INSERT INTO tb_disciplina (id_disciplina, codigo_disciplina, nome_disciplina, ch_total_disciplina) VALUES 
(1, 'D01', 'Algoritmos I', 60), 
(2, 'D02', 'Algoritmos II', 60), 
(3, 'D03', 'Estrutura de Dados', 60), 
(4, 'D04', 'Banco de Dados', 60), 
(5, 'D05', 'Sistemas Operacionais', 90), 
(6, 'D06', 'Engenharia de Software', 90),
(99, 'TCC', 'Trabalho de Conclusão', 120);

-- Vincula todas as 8 disciplinas aos 8 currículos gerados
INSERT INTO tb_curriculo_disciplina (id_curriculo, id_disciplina, periodo_curriculo_disciplina) 
SELECT c.id_curriculo, d.id_disciplina, 1 
FROM generate_series(1, 8) AS c(id_curriculo) 
CROSS JOIN (VALUES (1), (2), (3), (4), (5), (6), (99)) AS d(id_disciplina);

INSERT INTO tb_pre_requisito (id_disciplina, id_disciplina_requisito, vinculo_pre_requisito) VALUES 
(2, 1, 'Pré-requisito'), 
(3, 2, 'Pré-requisito'), 
(99, 3, 'Pré-requisito');


-- 4. PERÍODO E PROFESSORES
INSERT INTO tb_periodo_letivo (id_periodo_letivo, ano_periodo_letivo, semestre_periodo_letivo) VALUES (1, 2026, 1), (2, 2026, 2);
INSERT INTO tb_professor (id_professor, nome_professor, matricula_professor, cpf_professor, email_professor) VALUES (1, 'Rodrigo', 'PROF-001', '11111111111', 'roberto@iesb.com');


-- 5. INSERIR 300 ALUNOS DISTRIBUÍDOS PELOS 8 CURSOS
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


-- 6. INSERIR 8 TURMAS
INSERT INTO tb_turma (id_turma, id_disciplina, id_professor, id_periodo_letivo, codigo_turma, vagas_turma)
SELECT i, (i % 3) + 1, 1, (i % 2) + 1, 'TURMA-00' || i, 50 
FROM generate_series(1, 8) AS i;


-- 7. INSERIR 300 MATRÍCULAS E HISTÓRICOS
INSERT INTO tb_matricula (id_matricula, id_aluno, id_turma, data_matricula, status_matricula)
SELECT ROW_NUMBER() OVER () AS id_matricula, a.id_aluno, t.id_turma, CURRENT_DATE, 'Concluída'
FROM tb_aluno a 
CROSS JOIN (SELECT id_turma FROM tb_turma LIMIT 3) t;

INSERT INTO tb_historico (id_historico, id_matricula, situacao_historico, media_final_historico)
SELECT id_matricula, id_matricula, 'Aprovado'::situacao_t, CAST(7.0 + ((id_matricula % 30) / 10.0) AS NUMERIC(4,2))
FROM tb_matricula;
