select a.tipo_acomodacao as TipoAcomodacao, count(a.tipo_acomodacao) as Total
from Fato_Bookings as f
inner join Dim_Pais as p
on f.ID_booking = p.ID_pais
inner join Dim_Acomodacao as a
on f.ID_booking = a.ID_tipo_acomodacao
where p.sigla='GBR'
group by a.tipo_acomodacao
order by Total desc
