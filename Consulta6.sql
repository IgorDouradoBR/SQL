select count(f.ID_booking)as Reservas, SUM (f.adultos + f.criancas + f.bebes) as Total
from Fato_Bookings as f
inner join Dim_Tempo as t
on f.ID_booking = t.ID_tempo
inner join Dim_Acomodacao as a
on f.ID_booking = a.ID_tipo_acomodacao
where t.mes = 'August' AND a.nome_hotel ='Resort Hotel'