-- Скачайте результаты (по всем покупкам с проставленными рангами) в Excel. Постройте гистограмму («стакнутый барчарт» с распределением количества покупок по полям is_trial и name_partner) и добавьте к графику срез, на котором можно выбрать, на каких по счету покупках в рамках клиента построена гистограмма (только на первых; только на вторых; на всех, кроме первых, и т. д.).
select     count(is_trial)
        ,  name_partner
        ,  rng_bytime
        ,  is_trial
    from
        
(
select *
    , row_number() over (partition by user_id order by date_purchase) as rng_bytime
from skycinema.client_sign_up a
    join skycinema.partner_dict b
        on a.partner = b.id_partner
) t
group by is_trial, name_partner, rng_bytime
