SELECT 
r.reaction as "Реакция",
r.translation as "Перевод реакции",
r.translation_comment as "Комментарий к переводу реакции",
s.stimulus as "Стимул",
s.translation as "Перевод стимула",
p.id as "Номер человека",
q.title as "Название теста"
FROM reactions r
JOIN stimuli s ON s.id = r.stimulus_id
JOIN people p ON p.id = r.person_id
JOIN quizzes q ON q.id = r.quiz_id
--LIMIT 1
;
