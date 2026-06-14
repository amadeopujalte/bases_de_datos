--12. Justifique que provincia disminuyo su población menos que el aumento del país según los últimos 3 censos

WITH total_pob_fvpro AS (
    SELECT 
        fiaxo,
        fvpro,
        SUM(fbfmp + fbnbp + fbmsp) AS total
    FROM q_detc
    GROUP BY fiaxo, fvpro
),

prov_crecimiento AS (
    SELECT
        actual.fvpro,
        anterior.total AS pob_prov_anterior,
        actual.total AS pob_prov_actual,
        (actual.total - anterior.total)/ anterior.total AS crecimiento_prov
    FROM total_pob_fvpro actual,
         total_pob_fvpro anterior
    WHERE actual.fvpro = anterior.fvpro
      AND actual.fiaxo = (
          SELECT MAX(fiaxo)
          FROM total_pob_fvpro
      )
      AND anterior.fiaxo = (
          SELECT MIN(fiaxo)
          FROM (
              SELECT DISTINCT fiaxo
              FROM total_pob_fvpro
              ORDER BY fiaxo DESC
              LIMIT 3
          )
      )
),

pais_crecimiento AS (
    SELECT
        (actual.total - anterior.total)/ anterior.total AS crecimiento_pais
    FROM (
        SELECT fiaxo, SUM(total) AS total
        FROM total_pob_fvpro
        GROUP BY fiaxo
    ) actual,
    (
        SELECT fiaxo, SUM(total) AS total
        FROM total_pob_fvpro
        GROUP BY fiaxo
    ) anterior
    WHERE actual.fiaxo = (
          SELECT MAX(fiaxo)
          FROM total_pob_fvpro
      )
      AND anterior.fiaxo = (
          SELECT MIN(fiaxo)
          FROM (
              SELECT DISTINCT fiaxo
              FROM total_pob_fvpro
              ORDER BY fiaxo DESC
              LIMIT 3
          )
      )
)

SELECT
    x.fvpro,
    x.pob_prov_anterior,
    x.pob_prov_actual,
    x.crecimiento_prov,
    y.crecimiento_pais
FROM prov_crecimiento x,
     pais_crecimiento y
WHERE x.crecimiento_prov < 0
  AND ABS(x.crecimiento_prov) < y.crecimiento_pais
ORDER BY x.crecimiento_prov DESC;
