/*7. Nómina de las provincias que en los 2 últimos censos disminuyeron su población.*/
WITH poblacion_prov AS(
  SELECT
    fiaxo,
    fvpro,
    SUM(fbfmp + fbnbp + fbmsp) AS pob
  FROM q_detc
  GROUP BY fiaxo, fvpro 
  ORDER BY fiaxo
)
SELECT 
  x.fvpro
FROM poblacion_prov x
WHERE x.fiaxo = (
  SELECT MAX(a.fiaxo)
  FROM poblacion_prov a
)
AND x.pob < (
  SELECT y.pob
  FROM poblacion_prov y
  WHERE y.fvpro = x.fvpro
    AND y.fiaxo = (
      SELECT MAX(b.fiaxo)
      FROM poblacion_prov b
      WHERE b.fiaxo < x.fiaxo
    )
);
