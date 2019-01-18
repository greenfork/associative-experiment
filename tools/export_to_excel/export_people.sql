SELECT 
p.id as "Номер респондента",
q.title as "Название теста",
q.language as "Язык теста",
age as "Возраст",
profession as "Профессия",
region as "Регион",
residence_place as "Место проживания",
birth_place as "Место рождения",
nationality1 as "Национальность-1",
nationality2 as "Национальность-2",
spoken_languages as "Количество владеемых языков",
native_language as "Родной язык",
communication_language as "Язык общения",
education_language as "Язык обучения",
date as "Дата тестирования"
FROM people p
JOIN quizzes q ON p.quiz_id = q.id
--LIMIT 1
;
