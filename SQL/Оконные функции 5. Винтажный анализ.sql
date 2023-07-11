-- Дополните код таким образом, чтобы у вас получились винтажные доходимости, т. е. для каждого партнера необходимо рассчитать, какой процент клиентов дошел до второй покупки, до третьей покупки и т. д.
select name_partner
  
        , sum(case when rng_bytime = 1 then 1 else 0 end) *100 / sum(case when rng_bytime = 1 then 1 else 0 end)::float as rn_1
        , sum(case when rng_bytime = 2 then 1 else 0 end) *100 / sum(case when rng_bytime = 1 then 1 else 0 end)::float as rn_2
        , sum(case when rng_bytime = 3 then 1 else 0 end) *100 / sum(case when rng_bytime = 1 then 1 else 0 end)::float as rn_3
        , sum(case when rng_bytime = 4 then 1 else 0 end) *100 / sum(case when rng_bytime = 1 then 1 else 0 end)::float as rn_4
        , sum(case when rng_bytime = 5 then 1 else 0 end) *100 / sum(case when rng_bytime = 1 then 1 else 0 end)::float as rn_5
        , sum(case when rng_bytime = 6 then 1 else 0 end) *100 / sum(case when rng_bytime = 1 then 1 else 0 end)::float as rn_6
        
        from
        
(
select *
    , row_number() over (partition by user_id order by date_purchase) as rng_bytime
from skycinema.client_sign_up a
    join skycinema.partner_dict b
        on a.partner = b.id_partner
) t


group by name_partner
