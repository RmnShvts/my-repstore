-- Проставьте каждой покупке свой ранг, который покажет, какой по счету является данная покупка в рамках всех покупок клиента.
select *
    , row_number() over (order by purchase_id) as rng_purchase
    , row_number() over (partition by user_id order by purchase_id) as rng_user
from skycinema.client_sign_up
