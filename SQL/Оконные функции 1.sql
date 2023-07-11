-- Проставьте каждой покупке свой ранг, который покажет, какой по счету является данная покупка в рамках всей таблицы.

select *
    , row_number() over (order by purchase_id) as rng_all
from skycinema.client_sign_up
