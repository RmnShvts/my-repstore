-- Найдите преподавателя, который провел максимальное количество уроков в 2016 году. 

-- Интересуют только уроки, которые были списаны с баланса, то есть успешно пройдены (`success`) или прогуляны (`failed_by_student`) студентом. Не включайте в выборку триальные уроки.
with teach_class as
(select id_teacher,
       count(distinct id_class) as classes
from skyeng_db.classes 
where class_status in ('failed_by_student', 'success') -- статус пропущен или успех
      and date_trunc('year', class_start_datetime) = '2016-01-01' -- 2016 год
      and class_type != 'trial' -- тип урока - не пробный
group by 1) 
select teachers.id_teacher, city, age, max(classes) as chislo_urokov
from skyeng_db.teachers
inner join teach_class on teach_class.id_teacher = teachers.id_teacher
where classes = (select max(classes) from teach_class)
group by teachers.id_teacher, city, age
order by 4 desc
