-- У какой доли фильмов/сериалов нет рейтинга? Возьмите только произведения, выпущенные позже 1950 года (не строго) и длящиеся дольше 60 минут (не строго). Ответ дать в целых процентах.
select 
    round(sum(case when "averageRating" is null then 1.0 else 0.0 end) / count(*) * 100)  as ratio
    from imdb.title_basics a
       left join imdb.title_ratings b
            on a.tconst = b.tconst
   where "titleType" in ('movie', 'tvSeries', 'tvMovie') and "startYear" >= 1950 and "runtimeMinutes" >= 60
  
   
        --with rating 0 = 6 594 293
        --total = 7 725 075
