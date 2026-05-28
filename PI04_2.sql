/*2. Generar lista
Año censo, Índice masculinos, Índice femenino.*/

SELECT 
  fiaxo,
  ROUND(100 * (SUM(fbmsp) / SUM(fbfmp + fbnbp + fbmsp)),2) AS ind_m,
  ROUND(100 * (SUM(fbfmp) / SUM(fbfmp + fbnbp + fbmsp)),2) AS ind_F
FROM q_detc
GROUP BY fiaxo
ORDER BY fiaxo;
