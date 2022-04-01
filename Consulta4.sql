select a.nome_hotel as Hotel, count(a.ID_tipo_acomodacao) as Reservas
from Fato_Bookings as f
inner join Dim_Acomodacao as a
on f.ID_booking=a.ID_tipo_acomodacao
group by a.nome_hotel