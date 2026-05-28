/*4. Generar nomina
Año censo anterior, Año censo posterior, Delta población.
Delta población = Cant.pers.censo posterior – Cant.pers.censo anterior(actual).*/

SELECT 
  fiaxo,
 (SELECT MIN(c.fiaxo) FROM q_detc c WHERE c.fiaxo > x.fiaxo) AS anio_sig,
   
  (
    (SELECT SUM(y.fbfmp + y.fbnbp + y.fbmsp)
      FROM q_detc y
      WHERE y.fiaxo = (
        SELECT MIN(b.fiaxo)
        FROM q_detc b
        WHERE b.fiaxo > x.fiaxo
      )
      GROUP BY y.fiaxo
    )
    -
    SUM(x.fbfmp + x.fbnbp + x.fbmsp)
  ) AS delta_pob
FROM q_detc x
GROUP BY x.fiaxo
ORDER BY x.fiaxo;
