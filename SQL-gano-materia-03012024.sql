-- Crear vista a partir de la consulta del procedimiento almacenado
CREATE VIEW GanoMateria AS

SELECT DISTINCT
    e.id_estudiante, 
    CONCAT(e.apellido1_estudiante, ' ', 
e.apellido2_estudiante, ' ', 
e.nombre1_estudiante, ' ', 
e.nombre2_estudiante) 
AS NombreCompleto,
    nc.Ano,
    nc.Periodo,
    CONCAT(nc.NotaC1,'-', nc.NotaDp1,'-', nc.NotaPr1) AS Primer_Momento,
    CONCAT(nc.NotaC2,'-', nc.NotaDp2,'-', nc.NotaPr2) AS Segundo_Momento,
    CONCAT(nc.NotaC3,'-', nc.NotaDp3,'-', nc.NotaPr3) AS Tercer_Momento,
    SUM(nc.NotaC1+nc.NotaDp1+nc.NotaPr1)* 1 AS Nota1,
    SUM(nc.NotaC2+nc.NotaDp2+nc.NotaPr2)* 1.166 AS Nota2,
    SUM(nc.NotaC3+nc.NotaDp3+nc.NotaPr3)* 1.166 AS Nota3,	
    (SUM(nc.NotaC1+nc.NotaDp1+nc.NotaPr1) + SUM(nc.NotaC2+nc.NotaDp2+nc.NotaPr2)* 1.166 + SUM(nc.NotaC3+nc.NotaDp3+nc.NotaPr3)* 1.166) / 100 AS Promedio,
    IIF
(SUM((nc.NotaC1 + nc.NotaDp1 + nc.NotaPr1)* 1.0 / 100.0 + (nc.NotaC2 + nc.NotaDp2 + nc.NotaPr2)* 1.166 / 100.0 + (nc.NotaC3 + nc.NotaDp3 + nc.NotaPr3)* 1.166 / 100.0) > 3.5, 'Es competente', 'Aún no es competente') 
AS Gano_Materia,
    prof.nombre_profesor,
    prof.Correo_Institucional,
    Ma.descripcion_materia,
    Pro.descripcion_programa
FROM 
    Estudiantes e,
    Asesoria Ase,
    Notas nc,
    cupo cu,
    Profesores prof,
    materias ma,
    programas Pro
WHERE 
    e.codigo_hoja_vida = Ase.codigo_hoja_vida
    AND Ase.codigo_estudiante = nc.codigo_estudiante
    AND cu.codigo_materia_cupo = nc.codigo_materia_cupo
    AND prof.id_profesor = cu.id_profesor
    AND ma.codigo_materia = cu.codigo_materia
    AND Ase.codigo_programa = Pro.codigo_programa
    AND e.id1_estudiante IN ('11111', '2222')
    AND prof.Correo_Institucional = 'elprofe'
    AND ma.descripcion_materia = 'Introducción a la Programación'
GROUP BY
    e.nombre1_estudiante,
   e.nombre2_estudiante,
    e.apellido1_estudiante,
   e.apellido2_estudiante,
    e.id1_estudiante,
    Ase.codigo_estudiante,
    Ase.codigo_asesoria,
    Ase.codigo_programa,
    Ase.nivel_estudiante,
    prof.nombre_profesor,
    prof.Correo_Institucional,
    Ma.descripcion_materia,
    Pro.descripcion_programa,
    nc.Ano,
    nc.Periodo,
    nc.NotaC1,
    nc.NotaDp1,
    nc.NotaPr1,
    nc.NotaC2, 
    nc.NotaDp2, 
    nc.NotaPr2,
    nc.NotaC3,
    nc.NotaDp3,
    nc.NotaPr3;

/* Orden de  resultados ORDER BY NombreCompleto ASC despues al hacer select * from Gano Materia
select * from GanoMateria ORDER BY NombreCompleto ASC; */