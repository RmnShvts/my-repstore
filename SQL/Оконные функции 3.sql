-- Рассмотрите только первые покупки для каждого клиента: постройте распределение количества первых покупок клиента по полям is_trial и name_partner (расшифровка из словаря с партнерами на схеме skycinema).
select is_trial,
        name_partner,
        count(is_trial) cnt_trial
from
(select *
    , row_number() over (partition by user_id order by date_purchase) as rng_bytime
from skycinema.client_sign_up a
    join skycinema.partner_dict b
        on a.partner = b.id_partner
      
       ) as t
 where rng_bytime = 1
 group by is_trial, name_partner
