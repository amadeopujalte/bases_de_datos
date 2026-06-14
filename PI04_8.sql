--8. Nómina de provincias que en los 2 últimos censos el crecimiento es mayor al del país.
WITH total_pob_fvpro AS (
    SELECT 
        fiaxo,
        fvpro,
        SUM(fbfmp + fbnbp + fbmsp) AS total
    FROM q_detc
    GROUP BY fiaxo, fvpro
), 

fvpro_crecimiento AS (
    SELECT 
        actual.fvpro,
        (actual.total - anterior.total)/ anterior.total AS crecimiento
    FROM total_pob_fvpro actual,
         total_pob_fvpro anterior
    WHERE actual.fvpro = anterior.fvpro
      AND actual.fiaxo = (
          SELECT MAX(fiaxo)
          FROM total_pob_fvpro
      )
      AND anterior.fiaxo = (
          SELECT MAX(fiaxo)
          FROM total_pob_fvpro
          WHERE fiaxo < (
              SELECT MAX(fiaxo)
              FROM total_pob_fvpro
          )
      )
), 

axo_crecimiento AS (
    SELECT 
        (actual.total - anterior.total)/ anterior.total AS crecimiento
    FROM (
        SELECT 
            fiaxo,
            SUM(total) AS total
        FROM total_pob_fvpro
        GROUP BY fiaxo
    ) actual,
    (
        SELECT 
            fiaxo,
            SUM(total) AS total
        FROM total_pob_fvpro
        GROUP BY fiaxo
    ) anterior
    WHERE actual.fiaxo = (
          SELECT MAX(fiaxo)
          FROM total_pob_fvpro
      )
      AND anterior.fiaxo = (
          SELECT MAX(fiaxo)
          FROM total_pob_fvpro
          WHERE fiaxo < (
              SELECT MAX(fiaxo)
              FROM total_pob_fvpro
          )
      )
)

SELECT 
    x.fvpro
FROM fvpro_crecimiento x,
     axo_crecimiento y
WHERE x.crecimiento > y.crecimiento;
