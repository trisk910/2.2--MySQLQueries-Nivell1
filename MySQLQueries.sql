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