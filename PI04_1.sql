 /*1. Generar lista:
Año censo, Total población censada, Cantidad provincias censada.*/

SELECT 
  fiaxo, 
  SUM(fbfmp + fbnbp + fbmsp) AS total,
  COUNT(0) AS cant_prv
FROM q_detc
GROUP BY fiaxo
ORDER BY fiaxo;
