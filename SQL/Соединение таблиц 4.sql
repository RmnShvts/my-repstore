-- Определите среднее количество голосов, на основании которых рассчитывается рейтинг у тайтлов. Интересуют те тайтлы, которые отсутствуют в таблице title_basics и средний рейтинг по которым больше 7 (не строго).
select avg("numVotes")
 from imdb.title_basics a 
       right join imdb.title_ratings b
            on a.tconst = b.tconst
where "averageRating" >= 7 and a.tconst is null
--- left 613646
--- right 614258
