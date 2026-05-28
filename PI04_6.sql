/*6. Generar nómina
Año Censo, Región, Factor de crecimiento.
Condición el factor de crecimiento de la región debe ser mayor al del país del año del censo.
 */
WITH factor_crecimiento_anio AS (
  SELECT 
    z.fiaxo,

    ROUND(
      100 - 100 * (
        (
          SELECT SUM(x.fbfmp + x.fbnbp + x.fbmsp)
          FROM q_detc x 
          WHERE x.fiaxo = (
            SELECT MAX(a.fiaxo) 
            FROM q_detc a 
            WHERE a.fiaxo < z.fiaxo
          )
        )
        /
        SUM(z.fbfmp + z.fbnbp + z.fbmsp)
      ),
      2
    ) AS factor_crecimiento_pais

  FROM q_detc z
  GROUP BY z.fiaxo
),

factor_crecimiento_rgn AS (
  SELECT 
    z.fiaxo,
    p.fvrgn AS region,

    ROUND(
      100 - 100 * (
        (
          SELECT SUM(x.fbfmp + x.fbnbp + x.fbmsp)
          FROM q_detc x
          JOIN q_prov px
            ON px.fvpro = x.fvpro
          WHERE x.fiaxo = (
            SELECT MAX(b.fiaxo)
            FROM q_detc b
            WHERE b.fiaxo < z.fiaxo
          )
          AND px.fvrgn = p.fvrgn
        )
        /
        SUM(z.fbfmp + z.fbnbp + z.fbmsp)
      ),
      2
    ) AS factor_crecimiento_region

  FROM q_detc z
  JOIN q_prov p
    ON p.fvpro = z.fvpro
  GROUP BY z.fiaxo, p.fvrgn
)

SELECT 
  r.fiaxo AS ano_censo,
  r.region,
  r.factor_crecimiento_region
FROM factor_crecimiento_rgn r
JOIN factor_crecimiento_anio a
  ON a.fiaxo = r.fiaxo
WHERE r.factor_crecimiento_region > a.factor_crecimiento_pais
ORDER BY r.fiaxo, r.region;
