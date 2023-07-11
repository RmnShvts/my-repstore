--   Постройте распределение выплаченных клиентами денег (amt_payment) по месяцам поля date_purchase (SQL-запрос).
-- Дополните ваш запрос так, чтобы получилось три разных скользящих средних (по сумме денег по месяцам):
-- MA(3) — скользящее среднее, принимающее текущее значение и два предыдущих.
-- MA(7) — скользящее среднее, принимающее текущее значение и шесть предыдущих.
-- MA_2side(5) — двустороннее скользящее среднее, принимающее текущее значение, два предыдущих и два следующих.
  select s.*
    , avg(sum_month) over (order by month rows between 2 preceding and current row) as ma_3
    , avg(sum_month) over (order by month rows between 6 preceding and current row) as ma_7
    , avg(sum_month) over (order by month rows between 2 preceding and 2 following) as ma_5_2side
from
(
select month
    , sum(amt_payment) as sum_month
from

(select
     date_trunc('month', date_purchase) as month
    , amt_payment
   
from skycinema.client_sign_up
order by month asc) t
group by month
) s
