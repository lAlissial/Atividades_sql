-- Questão 1
-- 1.1 O que a seguinte consulta apresenta/mostra 
SELECT * FROM filme;
SELECT * FROM estudio;

select f.titulo
from filme f
where f.codest in (select e.codest
               	from estudio e
               	where nomeest like 'P%');
				
-- 1.2 O Mostre as descrições de categorias que estão na tabela Filme (associadas a filmes)  
SELECT titulo, codcateg FROM filme;
SELECT desccateg, codcateg FROM categoria;

SELECT c.desccateg
FROM categoria c
WHERE c.codcateg in (SELECT f.codcateg
               		FROM filme f);

-- 1.3 Qual o nome do artista cujo nome de personagem é ‘Natalie’ (1,0)
SELECT codart, nomeart FROM artista;
SELECT codart, nomepers FROM personagem;

SELECT a.nomeart
FROM artista a
WHERE a.codart in (SELECT p.codart
				  FROM personagem p
				  WHERE p.nomepers = 'Natalie');		

-- 1.4 Existe algum artista cadastrado que não esteja na tabela Personagem
SELECT codart, nomeart FROM artista;
SELECT codart, nomepers FROM personagem;
SELECT a.nomeart
FROM artista a
WHERE a.codart not in (SELECT p.codart
				  	   FROM personagem p);
-- 1.5 Reescreva a consulta da questão 1.1 usando o operador exists
SELECT * FROM filme;
SELECT * FROM estudio;

SELECT f.titulo
FROM filme f
WHERE EXISTS (SELECT e.codest
             FROM estudio e
             WHERE e.codest = f.codest AND nomeest like 'P%');		
			 
-- Questão 2 Crie uma tabela filmeEst (use create table as) que mostre os filmes (títulos) e seus estúdios (nomes) associados.
/*Use um JOIN para isso. Consulte a tabela criada e mostre seus dados */
CREATE TABLE filmeEst AS
SELECT f.Titulo AS "Título", est.NomeEst "Estudio"
FROM Filme f JOIN Estudio est ON est.CodEst = f.CodEst;
			 
SELECT * FROM filmeEst;			
					
-- Questão 3 O que o comando retorna?
/*Reescreva-o usando JOIN.
Os resultados das consultas com subconsulta e com JOIN são semelhantes? Explique.*/
  

select a.nomeart
from artista a 
where a.codart in (select p.codart
              	from personagem p
              	where p.codfilme in (select f.codfilme
                                 	from filme f
                                 	where f.duracao > 120))
									
SELECT DISTINCT a.nomeArt AS "Artistas"
FROM personagem p JOIN artista a ON a.codart = p.codart JOIN filme f ON f.codfilme = p.codfilme
WHERE f.duracao > 120;									

-- Questão 4
/* 	Verifique o comando seguinte
 O que o comando retorna?
 Refaça-o usando uma subquery.
 Depois, refaça-o usando JOIN.
Compare os resultados e explique-os.
*/
SELECT * FROM artista;

select a.codart
from artista a
where pais = 'USA'
   INTERSECT
select p.codart
from personagem p;

SELECT a.codart
FROM artista a
WHERE pais = 'USA' AND a.codart IN (SELECT p.codart
									FROM personagem p);

SELECT DISTINCT a.codart
FROM artista a JOIN personagem p ON p.codart = a.codart
WHERE a.pais = 'USA';	


-- Questão 5. Verifique agora o seguinte comando 
/*O que o comando retorna?
Refaça-o usando uma subquery.
Depois, refaça-o usando JOIN (Utilize o left ou right join).

** EXCEPT retorna todas as linhas que estão no resultado de consulta 1, mas não no resultado de consulta 2 
(operação diferença entre conjuntos).*/
SELECT * FROM artista;
SELECT * FROM personagem;
SELECT * FROM filme;

select a.codart
from artista a
  EXCEPT
select p.codart
from personagem p;
 
SELECT a.codart
FROM artista a
WHERE NOT EXISTS(SELECT p.codart
			FROM personagem p
			WHERE p.codart = a.codart);
					

SELECT a.codart
FROM artista a LEFT OUTER JOIN personagem p ON p.codart = a.codart
WHERE p.nomepers IS NULL;

SELECT a.codart
FROM personagem p RIGHT OUTER JOIN artista a ON a.codart = p.codart
WHERE p.nomepers IS NULL;

select a.nomeart, p.nomepers
from artista a left outer join personagem p on a.codart = p.codart;

-- Questão 6.  	Verifique agora o seguinte comando (1,0):
/*O que o comando retorna?
É possível executá-lo sem a subconsulta? Por quê?*/
SELECT * FROM artista;
SELECT * FROM personagem;

select a.nomeart
from artista a join personagem p on a.codart = p.codart
where p.cache = (select max(p.cache) from personagem p);


/*SELECT a.nomeart
FROM artista a JOIN personagem p ON p.codart = a.codart
GROUP BY a.nomeart
ORDER BY MAX(p.cache) DESC
LIMIT 1;*/

SELECT a.nomeart
FROM artista a JOIN personagem p ON p.codart = a.codart
ORDER BY p.cache DESC
LIMIT 1;

