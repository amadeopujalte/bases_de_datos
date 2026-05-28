/*3. Generar lista: Año censo, Región, Total población, 
Cantidad provincias, Índice población.*/

SELECT
  x.fiaxo,
  y.fvrgn,
  SUM(x.fbfmp + x.fbnbp + x.fbmsp) AS total_pb,
  COUNT(DISTINCT x.fvpro) AS cant_prv,
  ROUND(SUM(x.fbfmp + x.fbnbp + x.fbmsp)::numeric /SUM(y.frsup)::numeric,2) AS ind_pob


FROM q_detc x
JOIN q_prov y
  ON x.fvpro = y.fvpro
GROUP BY x.fiaxo, y.fvrgn 
ORDER BY fiaxo;
