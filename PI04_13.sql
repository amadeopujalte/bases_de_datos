--13. Justifique que provincia recomendaría para vivir a un soltero
WITH pob_prov AS (
    SELECT 
        x.fvpro,
        SUM(x.fbfmp) AS mujeres,
        SUM(x.fbfmp + x.fbnbp + x.fbmsp) AS poblacion_total
    FROM q_detc x
    WHERE x.fiaxo = (
        SELECT MAX(fiaxo)
        FROM q_detc
    )
    GROUP BY x.fvpro
)
SELECT 
    x.fvpro,
    x.mujeres,
    x.poblacion_total,
    x.mujeres / x.poblacion_total AS proporcion_mujeres
FROM pob_prov x
ORDER BY proporcion_mujeres DESC
LIMIT 2;
