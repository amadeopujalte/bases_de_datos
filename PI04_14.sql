--14. Justifique que provincia representa al país en cada censo.
--(La que mas poblacion tiene en cada uno)
WITH pob_prov AS (
    SELECT 
        x.fiaxo,
        x.fvpro,
        SUM(x.fbfmp + x.fbnbp + x.fbmsp) AS poblacion_total
    FROM q_detc x
    GROUP BY x.fiaxo, x.fvpro
)
SELECT 
    x.fiaxo,
    x.fvpro,
    y.fvpro,
    x.poblacion_total
FROM pob_prov x,
     q_prov y
WHERE x.fvpro = y.fvpro
  AND x.poblacion_total = (
      SELECT MAX(z.poblacion_total)
      FROM pob_prov z
      WHERE z.fiaxo = x.fiaxo
  )
ORDER BY x.fiaxo;
