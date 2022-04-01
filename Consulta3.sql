select m.tipo_marketing as Tipo, count(m.tipo_marketing) as Total
from  Fato_Bookings as f
inner Join Dim_Pais as p
on f.ID_booking = p.ID_pais
inner join Dim_market_segment as m
on f.ID_booking = m.ID_marketing
where p.sigla = 'GBR'
group by p.sigla, m.tipo_marketing
order by Total desc