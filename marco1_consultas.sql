-- CONSULTA 1: Listagem simples (Filtro e Ordenação)
-- Objetivo: Listar todos os alunos ativos de um determinado curso ordenados pelo ID (Como coloquei o ID com números de 1 a 215 e os nomes também, é como se tivesse ordenando por nome).
SELECT
    matricula_aluno,
    nome_aluno,
    email_aluno
FROM tb_aluno
WHERE ativo_aluno = true
  AND id_curso = 1
ORDER BY id_aluno ASC;

-- CONSULTA 2: Agrupamento com GROUP BY
-- Objetivo: Contar a quantidade de alunos matriculados por curso (Só aparece os cursos onde tem alunos matriculados).
SELECT 
    c.nome_curso, 
    COUNT(a.id_aluno) AS total_alunos
FROM tb_curso c
INNER JOIN tb_aluno a ON c.id_curso = a.id_curso
WHERE a.ativo_aluno = true
GROUP BY c.nome_curso
ORDER BY total_alunos DESC;


-- CONSULTA 3: LEFT JOIN para contar até os cursos vazios
-- Objetivo: Contar a quantidade de alunos matriculados por curso (Aparece até os cursos onde não tem alunos matriculados).
SELECT 
    c.nome_curso, 
    COUNT(a.id_aluno) AS total_alunos
FROM tb_curso c
LEFT JOIN tb_aluno a ON c.id_curso = a.id_curso AND a.ativo_aluno = true
GROUP BY c.nome_curso
ORDER BY total_alunos DESC;


-- CONSULTA 4: Junção externa com agregação (LEFT JOIN)
-- Objetivo: Listar TODAS as disciplinas cadastradas e quantas turmas já foram abertas para elas.
SELECT 
    d.codigo_disciplina, 
    d.nome_disciplina, 
    COUNT(t.id_turma) AS total_turmas_por_disciplina
FROM tb_disciplina d
LEFT JOIN tb_turma t ON d.id_disciplina = t.id_disciplina 
GROUP BY d.codigo_disciplina, d.nome_disciplina
ORDER BY total_turmas_por_disciplina ASC, d.nome_disciplina;


-- CONSULTA 5: Subconsulta Simples com Múltiplos INNER JOINs (5 tabelas).
-- Objetivo: Identificar alunos que atingiram média final superior à média geral das disciplinas de Ciência da Computação.

SELECT 
    a.matricula_aluno, 
    a.nome_aluno, 
    d.nome_disciplina, 
    h.media_final_historico
FROM tb_historico h
INNER JOIN tb_matricula m ON h.id_matricula = m.id_matricula
INNER JOIN tb_aluno a ON m.id_aluno = a.id_aluno
INNER JOIN tb_turma t ON m.id_turma = t.id_turma
INNER JOIN tb_disciplina d ON t.id_disciplina = d.id_disciplina
WHERE d.id_disciplina IN (1, 2, 3, 4) 
  AND h.media_final_historico > (
      SELECT AVG(media_final_historico) 
      FROM tb_historico 
      WHERE media_final_historico IS NOT NULL
  )
ORDER BY h.media_final_historico DESC;


-- CONSULTA 6: Função de janela com ranking e percentil (DENSE_RANK e PERCENT_RANK)
-- Objetivo: Criar um quadro de medalhas (ranking) e o percentil de desempenho dos alunos DENTRO de cada turma de cada curso, ignorando empates na contagem.
SELECT 
    a.nome_aluno,
    t.codigo_turma,
    h.media_final_historico,
    
    DENSE_RANK() OVER (PARTITION BY t.id_turma ORDER BY h.media_final_historico DESC) AS ranking_na_turma,
   
    ROUND(CAST(PERCENT_RANK() OVER (PARTITION BY t.id_turma ORDER BY h.media_final_historico ASC) AS NUMERIC), 2) AS percentil_desempenho
FROM tb_historico h
INNER JOIN tb_matricula m ON h.id_matricula = m.id_matricula
INNER JOIN tb_aluno a ON m.id_aluno = a.id_aluno
INNER JOIN tb_turma t ON m.id_turma = t.id_turma
WHERE h.media_final_historico IS NOT NULL
ORDER BY t.codigo_turma, ranking_na_turma;
