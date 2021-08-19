-- Questão 1
INSERT INTO filme VALUES(default,'Superman',2018,120,null,3);

-- Questão 2
-- Verifique quais os títulos dos filmes que possuem duração maior que 120 min 

//SELECT * FROM filme;
// SELECT Titulo, Duracao FROM filme;
SELECT Titulo FROM filme WHERE Duracao > 120;

-- Questão 3
-- Na tabela ARTISTA, quais artistas possuem cidade nula? Após a consulta, atualize as cidades nulas encontradas para três artistas
//SELECT NomeART, Cidade FROM artista;
SELECT NomeART AS Nome FROM Artista WHERE Cidade IS NULL;
UPDATE Artista SET Cidade='Los Angeles' WHERE nomeArt LIKE '%C%';

-- Questão 4  	
-- Qual a descrição da categoria do filme ‘Coringa’
//SELECT Titulo, CodCATEG FROM filme WHERE Titulo='Coringa';
//SELECT * FROM Categoria WHERE CodCATEG=6;
SELECT f.Titulo AS "Título", cat.DescCATEG "Descrição da Categoria"
FROM (Filme f JOIN Categoria cat ON cat.CodCATEG = f.CodCATEG )
WHERE Titulo='Coringa';

-- Questão 5
-- Mostre os títulos de filmes, seus estúdios e suas categorias
/*SELECT f.Titulo AS "Título", cat.DescCATEG "Descrição da Categoria", est.NomeEst "Estudio"
FROM Filme f JOIN Categoria cat ON cat.CodCATEG = f.CodCATEG JOIN Estudio est ON est.CodEst = f.CodEst;*/

SELECT f.Titulo AS "Título", est.NomeEst "Estudio", cat.DescCATEG "Descrição da Categoria" 
FROM Filme f JOIN Estudio est ON est.CodEst = f.CodEst JOIN Categoria cat ON cat.CodCATEG = f.CodCATEG ;


-- Questão 6
-- Qual o nome dos artistas que fizeram o filme ‘Encontro Explosivo’
SELECT * from personagem;
SELECT * FROM filme;
SELECT * FROM artista;

/*SELECT Titulo AS "Título", CodFILME "Código"
FROM filme
WHERE Titulo ='Encontro Explosivo'*/
/*SELECT f.Titulo AS "Título", art.NomeART AS "Artista"
FROM Personagem pers JOIN Filme f ON f.CodFILME = pers.CodFILME JOIN Artista art ON art.CodART = pers.CodART
WHERE Titulo ='Encontro Explosivo';*/

SELECT art.NomeART AS "Artista"
FROM Personagem pers JOIN Filme f ON f.CodFILME = pers.CodFILME JOIN Artista art ON art.CodART = pers.CodART
WHERE Titulo ='Encontro Explosivo';

/*SELECT art.NomeART AS "Artista", perso.NomePers "Nome Personagem"
FROM (Personagem perso 
WHERE CodFILME = 1;*/


-- Questão 7
-- Selecione os artistas que tem o nome iniciando com a letra ‘B’ e participaram de filmes da categoria ‘Aventura’ (1,0).
/*SELECT cat.DescCATEG AS "Categoria", art.NomeART AS "Artista"
FROM Personagem pers JOIN Filme f ON f.CodFILME = pers.CodFILME JOIN Categoria cat ON cat.CodCATEG = f.CodCATEG JOIN Artista art ON art.CodART = pers.CodART
WHERE art.NomeART like 'B%' AND cat.DescCATEG='Aventura';*/

SELECT art.NomeART AS "Artista"
FROM Personagem pers JOIN Filme f ON f.CodFILME = pers.CodFILME JOIN Categoria cat ON cat.CodCATEG = f.CodCATEG JOIN Artista art ON art.CodART = pers.CodART
WHERE art.NomeART LIKE 'B%' AND cat.DescCATEG='Aventura';
	  
	  
-- Questão 8 
-- Apresente quantos filmes existem por categoria. Para isso mostre a descrição da categoria e sua respectiva contagem (1,0).
SELECT * FROM Filme;
SELECT * FROM  Categoria;
	  
SELECT cat.DescCATEG AS "Categoria", COUNT(*) AS "Quantidade"
FROM Filme f JOIN Categoria cat ON cat.CodCATEG = f.CodCATEG
GROUP BY cat.DescCATEG;

-- Questão 9 
-- Altere a questão anterior acrescentando a cláusula “having”. Explique o que a consulta retorna no contexto que você implementou
SELECT cat.DescCATEG AS "Categoria", COUNT(*) AS "Quantidade"
FROM Filme f JOIN Categoria cat ON cat.CodCATEG = f.CodCATEG
GROUP BY cat.DescCATEG
HAVING COUNT(f.CodFILME)>1;

-- Questão 10
-- O que o seguinte comando mostra (1,0)? 
select a.nomeart, p.nomepers
from artista a left outer join personagem p on a.codart = p.codart;
	
-- Questão 11  
-- O que a seguinte consulta retorna (1,0)?
Select f.titulo as Filme, c.desccateg as Categoria
From filme f right join categoria c on f.codcateg = c.codcateg
Where c.codcateg is null;


//se for left
--Questão 12
-- Crie uma consulta sua ao banco Filmes. Use operadores SQL e algum tipo de JOIN. Formule o enunciado da consulta e mostre sua solução (1,0). 
SELECT fil.Titulo AS "Filme", cat.descCATEG AS "Categoria"
FROM Filme fil RIGHT OUTER JOIN categoria cat ON cat.CodCATEG = fil.CodCATEG;

SELECT fil.Titulo AS "Filme", cat.descCATEG AS "Categoria"
FROM Filme fil JOIN categoria cat ON cat.CodCATEG = fil.CodCATEG
WHERE cat.descCATEG LIKE 'A%'
ORDER BY Titulo;