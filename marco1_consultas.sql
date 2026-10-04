-- CONSULTA 1: Listagem simples (Filtro e Ordenação)
-- Objetivo: Listar todos os alunos ativos de um determinado curso ordenados por nome.
SELECT 
    matricula_aluno, 
    nome_aluno, 
    email_aluno 
FROM tb_aluno 
WHERE ativo_aluno = true 
  AND id_curso = 1 
ORDER BY nome_aluno ASC;


-- CONSULTA 2: Agrupamento Simples (GROUP BY)
-- Objetivo: Contar a quantidade de alunos matriculados por curso.
SELECT 
    c.nome_curso, 
    COUNT(a.id_aluno) AS total_alunos
FROM tb_curso c
INNER JOIN tb_aluno a ON c.id_curso = a.id_curso
WHERE a.ativo_aluno = true
GROUP BY c.nome_curso
ORDER BY total_alunos DESC;


-- CONSULTA 3: INNER JOINs múltiplos + Filtro de Grupo (HAVING)
-- Objetivo: Encontrar currículos ativos cuja carga horária total exigida ultrapasse 300 horas.
SELECT 
    c.nome_curso, 
    cr.codigo_curriculo, 
    SUM(d.ch_total_disciplina) AS carga_horaria_total
FROM tb_curso c
INNER JOIN tb_curriculo cr ON c.id_curso = cr.id_curso
INNER JOIN tb_curriculo_disciplina cd ON cr.id_curriculo = cd.id_curriculo
INNER JOIN tb_disciplina d ON cd.id_disciplina = d.id_disciplina
WHERE cr.ativo_curriculo = true
GROUP BY c.nome_curso, cr.codigo_curriculo
HAVING SUM(d.ch_total_disciplina) > 300
ORDER BY carga_horaria_total DESC;

-- CONSULTA 4: Junção externa com agregação (LEFT JOIN)
-- Objetivo: Listar TODAS as disciplinas cadastradas e quantas turmas já foram abertas para elas.
SELECT 
    d.codigo_disciplina, 
    d.nome_disciplina, 
    COUNT(t.id_turma) AS total_turmas_ofertadas
FROM tb_disciplina d
LEFT JOIN tb_turma t ON d.id_disciplina = t.id_disciplina 
GROUP BY d.codigo_disciplina, d.nome_disciplina
ORDER BY total_turmas_ofertadas ASC, d.nome_disciplina;


-- CONSULTA 5: Cruzamento avançado com Subconsulta (Subquery)
-- Objetivo: Identificar alunos que atingiram média final superior à média geral.
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
WHERE h.media_final_historico > (
    SELECT AVG(media_final_historico) 
    FROM tb_historico 
    WHERE media_final_historico IS NOT NULL
)
ORDER BY h.media_final_historico DESC;


-- CONSULTA 6: Função de janela com ranking e percentil (DENSE_RANK e PERCENT_RANK)
-- Objetivo: Criar um quadro de medalhas (ranking) e o percentil de desempenho dos alunos 
-- DENTRO de cada turma, ignorando empates na contagem.
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


-- CONSULTA 8: Múltiplas CTEs estruturais
-- Objetivo: Isolar os cálculos de matriculados e reprovados para criar uma Taxa de Reprovação por disciplina.
WITH TotalMatriculas AS (
    SELECT t.id_disciplina, COUNT(m.id_matricula) AS total_alunos
    FROM tb_matricula m
    INNER JOIN tb_turma t ON m.id_turma = t.id_turma
    GROUP BY t.id_disciplina
),
Reprovacoes AS (
    SELECT t.id_disciplina, COUNT(h.id_historico) AS total_reprovados
    FROM tb_historico h
    INNER JOIN tb_matricula m ON h.id_matricula = m.id_matricula
    INNER JOIN tb_turma t ON m.id_turma = t.id_turma
    -- Assumindo que 'situacao_t' possui esses status ou equivalentes
    WHERE h.situacao_historico::varchar IN ('Reprovado por Nota', 'Reprovado por Falta') 
    GROUP BY t.id_disciplina
)
SELECT 
    d.nome_disciplina,
    tm.total_alunos,
    COALESCE(r.total_reprovados, 0) AS total_reprovados,
    ROUND((COALESCE(r.total_reprovados, 0) * 100.0) / tm.total_alunos, 2) AS taxa_reprovacao_pct
FROM TotalMatriculas tm
INNER JOIN tb_disciplina d ON tm.id_disciplina = d.id_disciplina
LEFT JOIN Reprovacoes r ON tm.id_disciplina = r.id_disciplina
ORDER BY taxa_reprovacao_pct DESC;


-- CONSULTA 9: Consulta recursiva para a árvore de pré-requisitos
-- Objetivo: Escolher uma disciplina final e buscar regressivamente toda a 
-- cadeia de pré-requisitos que o aluno precisa percorrer até chegar nela.
WITH RECURSIVE ArvoreRequisitos AS (
    -- CASO BASE: Quais são os pré-requisitos DIRETOS da disciplina que estou investigando?
    SELECT 
        pr.id_disciplina,
        d.nome_disciplina AS disciplina_alvo,
        pr.id_disciplina_requisito,
        dr.nome_disciplina AS nome_requisito,
        1 AS nivel_profundidade
    FROM tb_pre_requisito pr
    INNER JOIN tb_disciplina d ON pr.id_disciplina = d.id_disciplina
    INNER JOIN tb_disciplina dr ON pr.id_disciplina_requisito = dr.id_disciplina
    WHERE pr.id_disciplina = 99
    
    UNION ALL
    
    -- PASSO RECURSIVO: Buscar os requisitos dos requisitos (o que eu preciso pra cursar o nível 1?)
    SELECT 
        pr.id_disciplina,
        ar.nome_requisito AS disciplina_alvo,
        pr.id_disciplina_requisito,
        dr.nome_disciplina AS nome_requisito,
        ar.nivel_profundidade + 1
    FROM tb_pre_requisito pr
    INNER JOIN ArvoreRequisitos ar ON pr.id_disciplina = ar.id_disciplina_requisito
    INNER JOIN tb_disciplina dr ON pr.id_disciplina_requisito = dr.id_disciplina
)
SELECT * FROM ArvoreRequisitos ORDER BY nivel_profundidade, disciplina_alvo;


-- CONSULTA 10: Consulta recursiva para as disciplinas que um aluno JÁ PODE cursar
-- Objetivo: Obter todo o histórico aprovado de um aluno, navegar recursivamente pela árvore 
-- a partir do que ele já passou, e filtrar apenas as disciplinas que ele ainda não cursou e que 
-- NÃO POSSUEM mais nenhum requisito pendente.
WITH RECURSIVE AprovacoesAluno AS (
    -- 1. Pega todas as disciplinas que o Aluno de ID = 1 já concluiu (Âncora do grafo de aprovações)
    SELECT t.id_disciplina
    FROM tb_historico h
    INNER JOIN tb_matricula m ON h.id_matricula = m.id_matricula
    INNER JOIN tb_turma t ON m.id_turma = t.id_turma
    WHERE m.id_aluno = 1 
      AND h.situacao_historico::varchar = 'Aprovado'
),
TrilhaDependencias AS (
    -- CASO BASE da Recursão: Quais disciplinas são "filhas" diretas do que o aluno já passou?
    SELECT pr.id_disciplina, pr.id_disciplina_requisito
    FROM tb_pre_requisito pr
    WHERE pr.id_disciplina_requisito IN (SELECT id_disciplina FROM AprovacoesAluno)
    
    UNION ALL
    
    -- PASSO RECURSIVO: Avança na árvore de grafo simulando os caminhos futuros possíveis
    SELECT pr.id_disciplina, tl.id_disciplina AS id_disciplina_requisito
    FROM tb_pre_requisito pr
    INNER JOIN TrilhaDependencias tl ON pr.id_disciplina_requisito = tl.id_disciplina
)
-- Validar as disciplinas da trilha
SELECT DISTINCT d.codigo_disciplina, d.nome_disciplina
FROM TrilhaDependencias td
INNER JOIN tb_disciplina d ON td.id_disciplina = d.id_disciplina
INNER JOIN tb_curriculo_disciplina cd ON d.id_disciplina = cd.id_disciplina
INNER JOIN tb_aluno a ON cd.id_curriculo = a.id_curriculo
WHERE a.id_aluno = 1
  -- REGRA 1: O aluno ainda NÃO cursou essa disciplina
  AND td.id_disciplina NOT IN (SELECT id_disciplina FROM AprovacoesAluno)
  -- REGRA 2: NÃO EXISTE nenhum pré-requisito dessa disciplina que o aluno tenha deixado de cursar
  AND NOT EXISTS (
      SELECT 1 
      FROM tb_pre_requisito pr2 
      WHERE pr2.id_disciplina = td.id_disciplina 
        AND pr2.id_disciplina_requisito NOT IN (SELECT id_disciplina FROM AprovacoesAluno)
  )
ORDER BY d.nome_disciplina;
