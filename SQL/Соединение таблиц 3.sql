-- Постройте распределение фильмов/сериалов с пометкой «для взрослых» (поле isAdult = true) по рейтингу. Создайте интервалы для бинирования (интервалирования) рейтинга с шагом 1.5 и посмотрите количество позиций в каждом бине рейтинга. Не включайте позиции без рейтинга. Берите только позиции, снятые позже 1975 года (не строго). Отранжируйте результат по возрастанию бинов рейтинга.
select
         
         case when "averageRating" between 0 and 2.5 then '1 first_group'
            when "averageRating" < 4 then '2 second_group'
            when "averageRating" < 5.5 then '3 third_group'
            when "averageRating" < 7 then '4 fourth_group'
            when "averageRating" < 8.5 then '5 fifth_group'
            when "averageRating" <= 10 then '6 six_group'
        end as ratings
        , count(*) as cnt
    from imdb.title_basics a 
       left join imdb.title_ratings b
            on a.tconst = b.tconst
    where "isAdult" = true and "averageRating" is not null and "startYear" >= 1975
    group by ratings
    order by ratings asc
