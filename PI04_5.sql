/*Generar nómina
Ano Censo, Delta población, Factor de crecimiento.
Factor de crecimiento = 100 – (cant.pers.censo anterior / cant.pers.censo actual ) * 100.
*/
SELECT 
  z.fiaxo,
  
  (
    SUM(z.fbfmp + z.fbnbp + z.fbmsp)
    - 
    (
      SELECT SUM(y.fbfmp + y.fbnbp + y.fbmsp)
      FROM q_detc y
      WHERE y.fiaxo = (
        SELECT MAX(b.fiaxo)
        FROM q_detc b
        WHERE b.fiaxo < z.fiaxo
      )
      GROUP BY y.fiaxo
    )
  ) AS delta_pob,

  (ROUND(
    100 - 100 * (
      (
        SELECT SUM(x.fbfmp + x.fbnbp + x.fbmsp) 
        FROM q_detc x 
        WHERE x.fiaxo = (
          SELECT MAX(a.fiaxo) 
          FROM q_detc a 
          WHERE a.fiaxo < z.fiaxo
        )
        GROUP BY x.fiaxo
      )
      /
      SUM(z.fbfmp + z.fbnbp + z.fbmsp)
    )
  ,2)) AS factor_crecimiento

FROM q_detc z
GROUP BY z.fiaxo
ORDER BY z.fiaxo;
