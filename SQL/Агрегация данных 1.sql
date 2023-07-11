-- Сделайте группировку по месяцу добавления на платформу. Для каждого месяца найдите:

-- долю певцов с количеством песен в топ-чартах больше 7 (строго);
-- долю певцов, которые были добавлены в плейлист более чем 100 раз (строго).
-- Ограничьтесь только теми месяцами, в которые было добавлено больше 7 певцов (строго).

-- Отранжируйте результат по возрастанию времени.

select month_added
        , sum(case when cnt_song_top_chart > 7 then 1.0 else 0.0 end)::float / count(*) as ratio_top_chart
        , sum(case when cnt_playlist > 100 then 1.0 else 0.0 end)::float / count(*) as ratio_top_playlist
        from skymusic.singer_list
where month_info = '2021-03-01'
group by month_added
having count(*) > 7
order by month_added asc
