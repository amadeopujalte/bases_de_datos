--15. Justifique que region representa al país.
WITH pob_region AS (
    SELECT 
        x.fiaxo,
        y.fvrgn,
        SUM(x.fbfmp + x.fbnbp + x.fbmsp) AS poblacion_total
    FROM q_detc x,
         q_prov y
    WHERE x.fvpro = y.fvpro
    GROUP BY x.fiaxo, y.fvrgn
)
SELECT 
    x.fiaxo,
    x.fvrgn,
    x.poblacion_total
FROM pob_region x
WHERE x.poblacion_total = (
    SELECT MAX(z.poblacion_total)
    FROM pob_region z
    WHERE z.fiaxo = x.fiaxo
)
ORDER BY x.fiaxo;
