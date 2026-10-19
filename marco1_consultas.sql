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


-- CONSULTA 7: Função de janela com LAG para evolução do rendimento
-- Objetivo: Calcular a média do aluno por semestre e compará-la com o semestre imediatamente anterior.
WITH MediaSemestral AS (
    SELECT 
        a.id_aluno,
        a.nome_aluno,
        pl.ano_periodo_letivo,
        pl.semestre_periodo_letivo,
        AVG(h.media_final_historico) AS cr_semestre
    FROM tb_historico h
    INNER JOIN tb_matricula m ON h.id_matricula = m.id_matricula
    INNER JOIN tb_aluno a ON m.id_aluno = a.id_aluno
    INNER JOIN tb_turma t ON m.id_turma = t.id_turma
    INNER JOIN tb_periodo_letivo pl ON t.id_periodo_letivo = pl.id_periodo_letivo
    WHERE h.media_final_historico IS NOT NULL
    GROUP BY a.id_aluno, a.nome_aluno, pl.ano_periodo_letivo, pl.semestre_periodo_letivo
)
SELECT 
    nome_aluno,
    ano_periodo_letivo,
    semestre_periodo_letivo,
    ROUND(cr_semestre, 2) AS media_atual,
    -- LAG pega a métrica da linha temporal anterior daquele aluno
    ROUND(LAG(cr_semestre) OVER (PARTITION BY id_aluno ORDER BY ano_periodo_letivo, semestre_periodo_letivo), 2) AS media_anterior,
    -- Variação: Positiva (melhorou) ou Negativa (piorou)
    ROUND(cr_semestre - LAG(cr_semestre) OVER (PARTITION BY id_aluno ORDER BY ano_periodo_letivo, semestre_periodo_letivo), 2) AS evolucao_pontos
FROM MediaSemestral
ORDER BY id_aluno, ano_periodo_letivo, semestre_periodo_letivo;


-- CONSULTA 8: Múltiplas CTEs estruturais (Versão Simplificada)
-- Objetivo: Usar duas CTEs simples para comparar o total de alunos com o total de aprovados por turma.

WITH TotalNaTurma AS (
    -- Primeira CTE: Quantos alunos existem em cada turma?
    SELECT id_turma, COUNT(id_matricula) AS qtd_matriculas
    FROM tb_matricula
    GROUP BY id_turma
),
AprovadosNaTurma AS (
    -- Segunda CTE: Quantos alunos foram aprovados em cada turma?
    SELECT m.id_turma, COUNT(h.id_historico) AS qtd_aprovados
    FROM tb_historico h
    INNER JOIN tb_matricula m ON h.id_matricula = m.id_matricula
    WHERE h.situacao_historico::varchar = 'Aprovado'
    GROUP BY m.id_turma
)
-- Consulta Principal: Junta as duas caixas e mostra o resultado
SELECT 
    t.codigo_turma, 
    d.nome_disciplina, 
    tnt.qtd_matriculas, 
    ant.qtd_aprovados
FROM tb_turma t
INNER JOIN tb_disciplina d ON t.id_disciplina = d.id_disciplina
INNER JOIN TotalNaTurma tnt ON t.id_turma = tnt.id_turma
INNER JOIN AprovadosNaTurma ant ON t.id_turma = ant.id_turma;


-- CONSULTA 9: Consulta recursiva para a árvore de pré-requisitos (Versão Simplificada)
-- Objetivo: Ver todos os pré-requisitos necessários para cursar uma disciplina avançada (Ex: ID 10)

WITH RECURSIVE BuscaRequisitos AS (
    -- PASSO 1: A Âncora. Quais os pré-requisitos diretos da disciplina ID 10?
    SELECT id_disciplina, id_disciplina_requisito
    FROM tb_pre_requisito
    WHERE id_disciplina = 10
    
    UNION ALL
    
    -- PASSO 2: A Recursão. Buscar os requisitos dos requisitos que acabei de encontrar.
    SELECT pr.id_disciplina, pr.id_disciplina_requisito
    FROM tb_pre_requisito pr
    INNER JOIN BuscaRequisitos br ON pr.id_disciplina = br.id_disciplina_requisito
)
-- PASSO 3: Depois de a recursão acabar, mostramos o nome de tudo o que foi encontrado.
SELECT 
    d.nome_disciplina AS nome_do_requisito_necessario
FROM BuscaRequisitos br
INNER JOIN tb_disciplina d ON br.id_disciplina_requisito = d.id_disciplina;


-- CONSULTA 10: Consulta recursiva para as disciplinas que um aluno pode cursar
-- Objetivo: Olhar para as aprovações do Aluno 1 e ver que "caminhos" futuros ele desbloqueou.

WITH RECURSIVE HistoricoAprovado AS (
    -- PASSO 1: Guardar apenas os IDs das disciplinas onde o Aluno 1 já passou
    SELECT t.id_disciplina
    FROM tb_historico h
    INNER JOIN tb_matricula m ON h.id_matricula = m.id_matricula
    INNER JOIN tb_turma t ON m.id_turma = t.id_turma
    WHERE m.id_aluno = 1 
      AND h.situacao_historico::varchar = 'Aprovado'
),
TrilhaFutura AS (
    -- PASSO 2: Âncora. O que é que o histórico aprovado libera imediatamente a seguir?
    SELECT pr.id_disciplina
    FROM tb_pre_requisito pr
    INNER JOIN HistoricoAprovado ha ON pr.id_disciplina_requisito = ha.id_disciplina
    
    UNION ALL
    
    -- PASSO 3: Recursão. O que é que as novas disciplinas vão liberar mais para a frente?
    SELECT pr.id_disciplina
    FROM tb_pre_requisito pr
    INNER JOIN TrilhaFutura tf ON pr.id_disciplina_requisito = tf.id_disciplina
)
-- PASSO 4: Mostrar as disciplinas desbloqueadas, garantindo que removemos as que ele já fez.
SELECT DISTINCT d.nome_disciplina AS proximas_disciplinas_disponiveis
FROM TrilhaFutura tf
INNER JOIN tb_disciplina d ON tf.id_disciplina = d.id_disciplina
WHERE tf.id_disciplina NOT IN (SELECT id_disciplina FROM HistoricoAprovado);
