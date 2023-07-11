-- Выберите жанр Animation (может быть в комбинации с другими жанрами). Ограничьтесь только фильмами и сериалами, которые были выпущены позже 1990 года (не строго) и у которых рейтинг больше 8 (строго). Сколько суммарно они длятся (в часах)?


select  
        round(sum("runtimeMinutes")/60) as Animation_runtime_hrs
    from imdb.title_basics a
        join imdb.title_ratings b
            on a.tconst = b.tconst
    where genres ~ 'Animation' and "startYear" >= '1990' and "averageRating" > 8 and "titleType" in ('movie', 'tvMovie', 'tvSeries')
