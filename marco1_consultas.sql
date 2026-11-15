-- CONSULTA 1: Listagem simples (Filtro e Ordenação)
-- Objetivo: Listar todos os alunos ativos de um determinado curso ordenados pelo ID (Como coloquei o ID com números de 1 a 215 e os nomes também, é como se tivesse ordenando por nome).
SELECT               -- Usado para selecionar cada coluna da tabela 
    matricula_aluno,
    nome_aluno,
    email_aluno
FROM tb_aluno     -- A tabela da qual está selecionando as colunas que vão ser utilizadas/aparecer
WHERE ativo_aluno = true -- O WHERE está sendo utilizado para filtrar, ou seja, vão aparecer somente os alunos que estão realmente cursando.
  AND id_curso = 1 -- o AND significa que ele está filtrando mais uma coisa, ele não quer de todos os cursos, ele quer apenas do curso 'Ciência da Computação' que é identificado pelo ID = 1
ORDER BY id_aluno ASC; -- ORDER BY vai listar os alunos em ordem, escolhi eles serem organizados pelo ID, de forma crescente ASC. (menor para o maior)

-- CONSULTA 2: Agrupamento com GROUP BY
-- Objetivo: Contar a quantidade de alunos matriculados por curso (Só aparece os cursos onde tem alunos matriculados).
SELECT                   -- Aqui nesse SELECT, como vamos fazer uma junção de duas tabelas, precisamos colocar o apelido do nome da tabela antes de escrever a coluna que desejamos selecionar
    c.nome_curso, -- Estamos querendo selecionar o nome_curso da tabela curso apelidada por C
    COUNT(a.id_aluno) AS total_alunos -- Aqui estamos utilizando uma função de agregação para contar quantos alunos terão no curso e apelidamos a coluna com o AS total_alunos.
FROM tb_curso c -- O nome da tabela + o apelido 
INNER JOIN tb_aluno a ON c.id_curso = a.id_curso -- A junção com a tabela + apelido onde o id do curso = id do aluno (ou seja, o ALUNO do ID 1 está no curso do ID 1)
WHERE a.ativo_aluno = true -- Filtra para serem contados apenas os alunos que estão ativos no curso.
GROUP BY c.nome_curso -- O group by avisa o COUNT que ele precisa reiniciar a contagem toda vez que mudar de curso, nisso ele está agrupando todos os alunos que cursam determinado curso nele mesmo.
ORDER BY total_alunos DESC; -- Ordenar a contagem dos alunos do curso que tem mais alunos para o que tem menos (DESC - decrescente), é opcional. 
-- O INNER JOIN exige correspondência obrigatória nos dois lados.

-- CONSULTA 3: LEFT JOIN para contar até os cursos vazios -  Junção externa com agregação
-- Objetivo: Contar a quantidade de alunos matriculados por curso (Aparece até os cursos onde não tem alunos matriculados).
SELECT 
    c.nome_curso, 
    COUNT(a.id_aluno) AS total_alunos -- O COUNT + LEFTJOIN registra apenas as linhas que são realmente reais! Se utilizassemos COUNT(*) + LEFTJOIN 
FROM tb_curso c -- A tabela depois do FROM é considerada a tabela da esquerda para o LEFT JOIN. (a tabela que vai ser preservada, todos os cursos irão aparecer)
LEFT JOIN tb_aluno a ON c.id_curso = a.id_curso AND a.ativo_aluno = true -- Aqui estamos filtrando apenas os alunos ativos no AND dentro do próprio LEFT JOIN. 
GROUP BY c.nome_curso 
ORDER BY total_alunos DESC;
-- Como estamos utilizando o LEFT JOIN vai mostrar todos os cursos, mesmo aqueles que não tem alunos.

-- CONSULTA 4: Subconsulta Simples com Múltiplos INNER JOINs (5 tabelas).
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
WHERE d.id_disciplina IN (1, 2, 3, 4) -- Filtra para mostrar apenas as disciplinas do curso de Ciência da Computação.
  AND h.media_final_historico > ( -- Outro filtro, mostrar apenas os alunos em que a média final é maior do que a média geral.
      SELECT AVG(media_final_historico) -- Função que calcula a média da média final de todos os alunos, ela ignora os valores NULL.
      FROM tb_historico 
  )
ORDER BY h.media_final_historico DESC; -- Ordena a média final de cada aluno de forma descrescente (maior para o menor)


-- CONSULTA 5: Função de janela com ranking e percentil (DENSE_RANK e PERCENT_RANK)
-- Objetivo: Criar um quadro de medalhas (ranking) e o percentil de desempenho dos alunos DENTRO de cada turma de cada curso, ignorando empates na contagem.
SELECT 
    a.nome_aluno,
    t.codigo_turma,
    h.media_final_historico,
    
    DENSE_RANK() OVER (PARTITION BY t.id_turma ORDER BY h.media_final_historico DESC) AS ranking_na_turma, -- Faz um ranking (sem repetir colocações de empate) e põe cada turma em grupos
    -- diferentes (cada turma com seu grupo de alunos) ordenando pela média final de forma decrescente DESC. 
    
    ROUND(CAST(PERCENT_RANK() OVER (PARTITION BY t.id_turma ORDER BY h.media_final_historico ASC) AS NUMERIC), 2) AS percentil_desempenho -- Calcula a posição relativa de cada aluno dentro da turma, 
    -- retornando um número decimal que varia de 0 a 1, e retorna um valor do tipo double precision com muitas casas decimais, precisamos transformá-lo no tipo numeric para podermos arredondá-lo para 2
    -- casas decimais. Utilizamos ORDER BY + ASC para que o aluno com maior nota tenha 100% de aproveitamento e o de menor perto de 0% de aproveitamento. 
FROM tb_historico h
INNER JOIN tb_matricula m ON h.id_matricula = m.id_matricula
INNER JOIN tb_aluno a ON m.id_aluno = a.id_aluno
INNER JOIN tb_turma t ON m.id_turma = t.id_turma
WHERE h.media_final_historico IS NOT NULL AND t.id_turma IN (1, 6, 11) -- Filtra para ser consultada apenas as turmas com ID = 1, 6 e 11 (Cursos de Ciência da Computação, Direito e Engenharia)
ORDER BY t.codigo_turma, ranking_na_turma; 

-- CONSULTA 6: Função de janela com LAG
-- Objetivo: evolução do rendimento dos alunos das disciplinas de Ciência da Computação.
SELECT 
    a.nome_aluno,
    d.nome_disciplina,
    h.media_final_historico AS nota_atual,
    LAG(h.media_final_historico, 1) OVER ( -- Acessa o valor da nota_anterior de cada aluno, o 1 siginifca que vai retornar uma linha para trás.
        PARTITION BY a.id_aluno  -- Separa os grupos de alunos, a linha de cada um aparece
        ORDER BY m.id_matricula ASC -- Ordena pelo ID da matricula, ordem crescente
    ) AS nota_anterior,
    h.media_final_historico - LAG(h.media_final_historico, 1) OVER (
        PARTITION BY a.id_aluno 
        ORDER BY m.id_matricula ASC
    ) AS quanto_rendeu
FROM tb_historico h
INNER JOIN tb_matricula m ON h.id_matricula = m.id_matricula
INNER JOIN tb_aluno a ON m.id_aluno = a.id_aluno
INNER JOIN tb_turma t ON m.id_turma = t.id_turma
INNER JOIN tb_disciplina d ON t.id_disciplina = d.id_disciplina
WHERE d.id_disciplina IN (1, 2, 3, 4);

-- CONSULTA 7: Uma consulta recursiva para a árvore de pré-requisitos;
