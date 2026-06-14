--9. Evolución de la densidad poblacional a lo largo de los censos.
SELECT 
    x.fiaxo,
    SUM(x.fbfmp + x.fbnbp + x.fbmsp) AS poblacion_total,
    SUM(x.fbfmp + x.fbnbp + x.fbmsp)/ SUM(y.frsup) AS densidad_poblacional
FROM q_detc x,
     q_prov y
WHERE x.fvpro = y.fvpro
GROUP BY x.fiaxo
ORDER BY x.fiaxo;
