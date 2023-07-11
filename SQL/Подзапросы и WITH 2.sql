-- Напишите запрос, который покажет распределение учителей по количеству проводимых в месяц уроков (опять же - не триальных, а только успешных или прогулянных самим студентом).

-- Используя подзапросы, выведите распределение учителей по количеству проведенных в месяц уроков в штуках, ориентируясь на запрос из задания 1.
select classes,
       count(id_teacher) as teacher_in_month
from 
(
select id_teacher,
       date_part('month', class_start_datetime) as class_month, 
       count(distinct id_class) as classes
from skyeng_db.classes 
where class_status in ('failed_by_student', 'success') -- статус пропущен или успех
      and date_trunc('year', class_start_datetime) = '2016-01-01' -- 2016 год
      and class_type != 'trial' -- тип урока - не пробный
group by 1, 2
) as classes_stats
group by classes
order by classes
