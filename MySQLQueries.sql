-- Tenda
-- 1. Llista el nom de tots els productes que hi ha en la taula producto.
SELECT 
    nombre
FROM
    s22tienda.producto;

-- 2. Llista els noms i els preus de tots els productes de la taula producto.
SELECT 
    nombre,
    precio
FROM
    s22tienda.producto;
    
-- 3.Llista totes les columnes de la taula producto.
SHOW COLUMNS FROM s22tienda.producto;

-- 4. Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD).
SELECT 
    nombre,
    precio,
    ROUND(precio * 0.95, 2)
FROM 
    s22tienda.producto;
    
-- 5. Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD). 
-- Utilitza els següents àlies per a les columnes: nom de producto, euros, dòlars.
SELECT 
    nombre AS nom_de_producto,
    precio AS euros,
    ROUND(precio * 0.95, 2) AS dòlars
FROM 
    s22tienda.producto;
-- 6. Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a majúscula.
SELECT 
    UPPER(nombre),
    precio
FROM 
    s22tienda.producto;
    
-- 7. Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a minúscula.
SELECT 
    LOWER(nombre),
    precio
FROM 
    s22tienda.producto;
-- 8. Llista el nom de tots els fabricants en una columna, i en una altra columna obtingui 
-- en majúscules els dos primers caràcters del nom del fabricant.
SELECT 
	nombre,
    CONCAT(UPPER(LEFT(nombre, 2)), SUBSTRING(nombre, 3)) AS nombre_2Mayus
FROM
	s22tienda.fabricante;
    
-- 9. Llista els noms i els preus de tots els productes de la taula producto, arrodonint el valor del preu.
SELECT 
	nombre,
    ROUND(precio,2)
FROM
	s22tienda.producto;
-- 10. Llista els noms i els preus de tots els productes de la taula producto, truncant el valor del preu
-- per a mostrar-lo sense cap xifra decimal.    
SELECT 
	nombre,
    ROUND(precio)
FROM
	s22tienda.producto;

-- 11. Llista el codi dels fabricants que tenen productes en la taula producto.
SELECT
	codigo_fabricante
FROM 
	s22tienda.producto;

-- 12. Llista el codi dels fabricants que tenen productes en la taula producto, eliminant els codis que apareixen repetits.	
SELECT 	distinct
	codigo_fabricante
FROM 
	s22tienda.producto;

-- 13. Llista els noms dels fabricants ordenats de manera ascendent.
SELECT
	nombre
FROM
	s22tienda.fabricante
ORDER BY 
	nombre ASC;

-- 14. Llista els noms dels fabricants ordenats de manera descendent.
SELECT
	nombre
FROM
	s22tienda.fabricante
ORDER BY 
	nombre desc;
    
-- 15. Llista els noms dels productes ordenats, en primer lloc, pel nom de manera ascendent 
-- i, en segon lloc, pel preu de manera descendent.
SELECT 
	nombre
FROM 
	s22tienda.producto
ORDER BY
nombre ASC, precio DESC;

-- 16. Retorna una llista amb les 5 primeres files de la taula fabricante.
SELECT
	*
FROM
	s22tienda.fabricante
LIMIT
	5;

-- 17. Retorna una llista amb 2 files a partir de la quarta fila de la taula fabricante.
-- La quarta fila també s'ha d'incloure en la resposta.
SELECT 
	*
FROM 
	s22tienda.fabricante
LIMIT 
	2 
OFFSET 3;

-- Universitat
-- 1. Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. 
-- El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
SELECT
	apellido1,
    apellido2,
    nombre
FROM
	persona
ORDER BY
	apellido1 ASC,
    apellido2 ASC,
    nombre ASC;

-- 2. Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
SELECT
	nombre,
    apellido1,
    apellido2
FROM 
	persona
WHERE 
	telefono is null;

-- 3. Retorna el llistat dels alumnes que van néixer en 1999.
SELECT 
	nombre, apellido1, apellido2
FROM
	persona
WHERE 
	year(fecha_nacimiento) = 1999;
    
-- 4. Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon
--  en la base de dades i a més el seu NIF acaba en K.
SELECT 
	p.nombre, p.apellido1, p.apellido2, p.nif
FROM 
	persona p
JOIN profesor pr ON p.id = pr.id_profesor
WHERE 
	p.tipo = 'profesor'
	AND (p.telefono IS NULL OR p.telefono = '')
	AND p.nif LIKE '%K';
    
-- 5. Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre,
-- en el tercer curs del grau que té l'identificador 7.
SELECT
	nombre
FROM
	asignatura
WHERE
	asignatura.cuatrimestre = 1
    AND asignatura.id_grado = 7;

-- 6. Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats. El llistat ha de
-- retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament.
--  El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.
SELECT 
	p.apellido1, p.apellido2, p.nombre, d.nombre
FROM 
	persona p
JOIN profesor pr ON p.id = pr.id_profesor
JOIN departamento d ON pr.id_departamento = d.id
ORDER BY
	p.apellido1 ASC, p.apellido2, p.nombre;

-- 7. Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
SELECT 
    a.nombre AS Nombre_Asignatura, 
    ce.anyo_inicio AS año_inicio, 
    ce.anyo_fin AS año_fin
FROM 
    persona p
JOIN 
    alumno_se_matricula_asignatura am ON p.id = am.id_alumno
JOIN 
    asignatura a ON am.id_asignatura = a.id
JOIN 
    curso_escolar ce ON am.id_curso_escolar = ce.id
WHERE 
    p.tipo = 'alumno'
ORDER BY 
    p.apellido1, p.apellido2, p.nombre;
	
-- 8. Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna
-- assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
SELECT DISTINCT 
	d.nombre
FROM 
	asignatura a 
JOIN grado g on a.id_grado = g.id 
JOIN profesor pr on pr.id_profesor = a.id_profesor
JOIN departamento d ON pr.id_departamento = d.id 
WHERE 
	g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';
    
-- 9. Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
SELECT distinct
	p.nombre, p.apellido1, p.apellido2
FROM
	alumno_se_matricula_asignatura am
JOIN persona p ON am.id_alumno = p.id
JOIN curso_escolar ce ON am.id_curso_escolar = ce.id
WHERE
	ce.anyo_inicio = 2018 AND ce.anyo_fin = 2019;
    
-- Left/Right Join
-- 1. Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats.
-- El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. 
-- El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a.
-- El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.
SELECT 	
	p.nombre, p.apellido1, p.apellido2,
    COALESCE(d.nombre, 'Sin departamento') AS nom_departament
FROM 
	persona p 
JOIN profesor pr ON pr.id_profesor = p.id 
LEFT JOIN departamento d ON pr.id_departamento = d.id
ORDER BY
	p.apellido1 ASC, p.apellido2 ASC, p.nombre ASC,  d.nombre ASC;
    
-- 2. Retorna un llistat amb els professors/es que no estan associats a un departament.
SELECT 	
	p.nombre, p.apellido1, p.apellido2
FROM 
	persona p 
JOIN profesor pr ON pr.id_profesor = p.id 
LEFT JOIN departamento d ON pr.id_departamento = d.id
WHERE
	d.id is null
ORDER BY
	p.apellido1 ASC, p.apellido2 ASC, p.nombre ASC,  d.nombre ASC;
    
-- 3. Retorna un llistat amb els departaments que no tenen professors/es associats.
SELECT 
	d.nombre 
FROM 
	profesor pr 
RIGHT JOIN departamento d on pr.id_departamento = d.id 
WHERE 
	pr.id_profesor is null;

-- 4. Retorna un llistat amb els professors/es que no imparteixen cap assignatura.
SELECT 
    p.nombre, p.apellido1, p.apellido2
FROM 
    persona p
JOIN profesor pr ON pr.id_profesor = p.id
LEFT JOIN asignatura a ON a.id_profesor = pr.id_profesor
WHERE 
    a.id IS NULL;

-- 5. Retorna un llistat amb les assignatures que no tenen un professor/a assignat.
SELECT 
    a.nombre as nom_asignatura
FROM 
    asignatura a
LEFT JOIN profesor pr ON a.id_profesor = pr.id_profesor
WHERE 
    pr.id_profesor is null;

-- 6. Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
SELECT
	d.nombre as departamento
from
	departamento d
LEFT JOIN curso_escolar ce ON d.id = ce.id
WHERE
	ce.id is null;

-- Consultes resum
-- 1. Retorna el nombre total d'alumnes que hi ha.
SELECT 
	COUNT(p.id) as número_alumnes
FROM 
	persona p
WHERE
	p.tipo = 'alumno';

-- 2. Calcula quants alumnes van néixer en 1999.
SELECT 
	COUNT(p.id) as número_alumnes
FROM 
	persona p
WHERE
	year(fecha_nacimiento) ='1999';
    
-- 3. Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, 
-- una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. 
-- El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar
-- ordenat de major a menor pel nombre de professors/es.
SELECT 
    d.nombre AS nom_departamento,
    COUNT(pr.id_profesor) AS num_profesores
FROM 
    departamento d
JOIN profesor pr ON d.id = pr.id_departamento
GROUP BY 
    d.nombre
ORDER BY
	num_profesores DESC;

-- 4. Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. 
-- Tingui en compte que poden existir departaments que no tenen professors/es associats.
-- Aquests departaments també han d'aparèixer en el llistat.    
SELECT 
    d.nombre AS nom_departamento,
    COUNT(pr.id_profesor) AS num_profesores
FROM 
    departamento d
LEFT JOIN profesor pr ON d.id = pr.id_departamento
GROUP BY 
    d.nombre
ORDER BY
	num_profesores;

-- 5. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. 
-- Tingues en compte que poden existir graus que no tenen assignatures associades. 
-- Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
SELECT
	g.nombre as nom_grau, COUNT(a.id) as nombre_asignatures
FROM
	grado g
LEFT JOIN asignatura a ON g.id = a.id
GROUP BY 
    g.nombre
ORDER BY
	nombre_asignatures DESC;
    
-- 6. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun,
-- dels graus que tinguin més de 40 assignatures associades.
SELECT
	g.nombre as nom_grau, COUNT(a.id) as nombre_asignatures
FROM
	grado g
LEFT JOIN asignatura a ON g.id = a.id
GROUP BY 
    g.nombre
HAVING
	COUNT(a.id) > 40;
    
-- 7. Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura.
-- El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures
-- que hi ha d'aquest tipus.
SELECT
	g.nombre as nom_grau,a.tipo as tipus_asignatura, SUM(a.creditos) as numero_credits
FROM
	grado g
JOIN asignatura a ON g.id = a.id
GROUP BY 
    g.nombre, a.tipo;

-- 8. Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars.
-- El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb
-- el nombre d'alumnes matriculats.
SELECT 
	ce.anyo_inicio, COUNT(DISTINCT al.id_alumno) as num_alumnes
FROM 
	alumno_se_matricula_asignatura al 
RIGHT JOIN curso_escolar ce ON al.id_curso_escolar = ce.id 
GROUP BY
	ce.anyo_inicio;

-- 9.Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. El llistat ha de tenir en compte aquells
-- professors/es que no imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i
-- nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.
SELECT
    p.id, p.nombre, p.apellido1, p.apellido2, COUNT(a.id) AS num_asignaturas
FROM
    persona p
JOIN profesor pr ON p.id = pr.id_profesor
LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor
GROUP BY
    p.id, p.nombre, p.apellido1, p.apellido2
ORDER BY
    num_asignaturas DESC;

 -- 10.Retorna totes les dades de l'alumne/a més jove.   
 SELECT
	*
FROM
	persona
WHERE
	persona.tipo = 'alumno' AND persona.fecha_nacimiento = (SELECT MAX(fecha_nacimiento) FROM persona WHERE tipo = 'alumno');
    