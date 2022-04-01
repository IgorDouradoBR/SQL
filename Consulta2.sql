select p.sigla as Pais , COUNT(p.sigla) as Retornantes
from Fato_Bookings as f
inner join Dim_Pais as p
on f.ID_booking = p.ID_pais
where f.recorrente = 1
group by p.sigla
order by Retornantes desc
