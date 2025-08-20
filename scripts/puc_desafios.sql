--Quantida de votos por filme = Matrix
SELECT
    id_filme
    ,dsc_filme
    ,SUM(qtd_votos) AS qtd_votos
    ,num_nota_media
FROM filmes
WHERE dsc_filme = 'Matrix'
GROUP BY 
    id_filme
    ,dsc_filme
    ,num_nota_media

--Filmes com nota média maior ou igual a 81 e quantidade de votos menor ou igual a 823
SELECT 
    id_filme
    ,dsc_filme
    ,qtd_votos
    ,num_nota_media
FROM filmes
WHERE num_nota_media >= 81
AND qtd_votos <= 823

--Todos os resultados das tabelas de empresgado, depatarmento e projeto
SELECT *
FROM bd_empresa.dbo.empregado e
INNER JOIN bd_empresa.dbo.departamento d on e.cod_depto = d.cod_depto
INNER JOIN bd_empresa.dbo.projeto p on e.cod_depto = p.cod_projeto

--Selecionar todos os projetos que acontecem em BH
SELECT * 
FROM bd_empresa.dbo.projeto
WHERE nom_local = 'BH'

--Selecionar todos os os empregados do sexo masculino que moram em MG
SELECT *
FROM bd_empresa.dbo.empregado
WHERE sex_empregado = 'M'
AND sig_uf= 'MG'

--Selecionar os filmes que não possuem link para foto
SELECT * 
FROM filmes
WHERE dsc_link_foto IS NULL

--Listar nome e data de lançamento dos filmes que contenham a palavra 'Bela'
SELECT
    dsc_filme
    ,dat_lancamento
FROM filmes
WHERE dsc_filme LIKE '%Bela%'

--Liste apenas os nomes dos filmes que contenham a palavra 'Bela' retirando os itens duplicados
SELECT DISTINCT
    dsc_filme
FROM filmes
WHERE dsc_filme LIKE '%Bela%'

--Listar
SELECT 
    dsc_filme
    ,qtd_votos
FROM filmes
WHERE qtd_votos > 1000
ORDER BY 2 DESC

--NOT EXISTS + SUBQUERY
SELECT nom_empregado, 
       nom_depto
FROM bd_empresa.dbo.empregado e
JOIN bd_empresa.dbo.departamento d on d.cod_depto = e.cod_depto
WHERE NOT EXISTS (SELECT 1 
FROM bd_empresa.dbo.alocacao a 
WHERE a.num_matricula = e.num_matricula)

--NOT IN + SUBQUERY
SELECT 
    nom_empregado
    ,nom_depto
FROM bd_empresa.dbo.empregado e
JOIN bd_empresa.dbo.departamento d on d.cod_depto = e.cod_depto
WHERE NOT EXISTS (SELECT 1 
FROM bd_empresa.dbo.alocacao a  
WHERE a.num_matricula = e.num_matricula)

--Listar o empregado, o número de horas e o projeto cuja 
--alocação de horas no projeto é maior do que a média de alocação do 
--referido projeto.
SELECT a.cod_projeto,
       nom_empregado,  
       nom_projeto, 
       media, 
       SUM(num_horas) AS qtd_horas
FROM bd_empresa.dbo.empregado e
JOIN bd_empresa.dbo.alocacao a on a.num_matricula = e.num_matricula
JOIN bd_empresa.dbo.projeto p on p.cod_projeto = a.cod_projeto
JOIN (SELECT cod_projeto, AVG (num_horas) media
FROM bd_empresa.dbo.alocacao a 
GROUP BY cod_projeto) a_media ON a.cod_projeto = a_media.cod_projeto
GROUP BY a.cod_projeto, nom_empregado, nom_projeto, media
HAVING SUM(num_horas) > media