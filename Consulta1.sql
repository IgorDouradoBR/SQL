select t.mes,count(t.mes) as reservas
from Fato_Bookings as f
inner join Dim_Tempo as t
on f.ID_tempo = t.ID_tempo
group by t.mes
order by reservas desc