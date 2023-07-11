-- Возьмите таблицу skybank.late_collection_clients и напишите скрипт, который сделает витрину со следующими полями:

-- Внутренний идентификатор клиента — поле id_client.
-- Название города — поле name_city из таблицы skybank.region_dict.
-- Числовой признак, который принимает значение 1 для мужчин и 0 для женщин — новое поле nflag_gender на основании поля gender.
-- Возраст — поле age.
-- Числовая переменная, которая показывает, в первый ли раз клиент обратился к нам за кредитом, — поле first_time.
-- Числовой признак, который принимает значение 1 при наличии мобильного телефона и 0 при его отсутствии — новое поле nflag_cellphone на основании поля cellphone.
-- Числовая переменная, которая показывает, активен ли клиент, — поле is_active;
-- Номер клиентского сегмента — поле cl_segm.
-- Размер выданного кредита — поле amt_loan.
-- Дата выдачи кредита — поле date_loan. Необходимо привести к формату даты.
-- Тип выданного кредита — поле credit_type.
-- Суммарный объем кредитов, выданных в этом городе.
-- Доля данного кредита среди всех кредитов, выданных в этом городе.
-- Суммарный объем кредитов, выданных в рамках указанного типа кредита.
-- Доля данного кредита среди всех кредитов, выданных в рамках указанного типа кредита.
-- Суммарный объем кредитов, выданных в рамках указанного типа кредита и города.
-- Доля данного кредита среди всех кредитов, выданных в рамках указанного типа кредита и города.
-- Количество кредитов, выданных в этом городе.
-- Количество кредитов, выданных в рамках указанного типа кредита.
-- Количество кредитов, выданных в рамках указанного типа кредита и города.
select 
     id_client
    , name_city
    , case when gender = 'M' then 1 else 0 end as nflag_gender
    , age
    , first_time
    , case when cellphone is not null then 1 else 0 end as nflag_cellphone
    , is_active
    , cl_segm
    , amt_loan
    , date_loan::date
    , credit_type
    , sum(amt_loan) over (partition by name_city) credit_city
    , amt_loan / sum(amt_loan) over (partition by name_city)::float as share_city
    , sum(amt_loan) over (partition by credit_type) credit_city_type
    , amt_loan /  sum(amt_loan) over (partition by credit_type)::float as share_credit_type
    , sum(amt_loan) over (partition by name_city, credit_type) credit_and_type_city
    , amt_loan /  sum(amt_loan) over (partition by name_city, credit_type)::float as sh_cred_and_type
    , count(amt_loan) over (partition by name_city) cnt_city
    , count(amt_loan) over (partition by credit_type) cnt_credit_type
    , count(amt_loan) over (partition by credit_type, name_city) cnt_type_city
from skybank.late_collection_clients a
    left join skybank.region_dict b
    on a.id_city = b.id_city
