--10. Evolución de la densidad poblacional a lo largo de los censos por región.

WITH pob_region AS (
    SELECT 
        x.fiaxo,
        y.fvrgn,
        SUM(x.fbfmp + x.fbnbp + x.fbmsp) AS poblacion_total
    FROM q_detc x,
         q_prov y
    WHERE x.fvpro = y.fvpro
    GROUP BY x.fiaxo, y.fvrgn
),
sup_region AS (
    SELECT 
        fvrgn,
        SUM(frsup) AS superficie_total
    FROM q_prov
    GROUP BY fvrgn
)
SELECT 
    x.fiaxo,
    x.fvrgn,
    x.poblacion_total,
    y.superficie_total,
    x.poblacion_total/ y.superficie_total AS densidad_poblacional
FROM pob_region x,
     sup_region y
WHERE x.fvrgn = y.fvrgn
ORDER BY x.fiaxo, x.fvrgn;
