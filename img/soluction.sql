
-- SELECT

-- 1. Selezionare tutti gli studenti nati nel 1990 (160)
SELECT * FROM `students` WHERE YEAR(`date_of_birth`) = 1990;

-- 2. Selezionare tutti i corsi che valgono più di 10 crediti (479)
SELECT * FROM `courses` WHERE `cfu` > 10;

-- 3. Selezionare tutti gli studenti che hanno più di 30 anni(153)
SELECT * FROM `students` WHERE YEAR(`date_of_birth`) = 1994;

-- 4. Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea (286)
SELECT * FROM `courses` WHERE `period`= 'I semestre' AND `year` = '1';

-- 5. Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del 20/06/2020 (21)
SELECT * FROM `exams` WHERE `date` = '2020-06-20' AND `hour`> '14:00:00';

-- 6. Selezionare tutti i corsi di laurea magistrale (38)
SELECT * FROM `degrees` WHERE `level` = 'magistrale';

-- 7. Da quanti dipartimenti è composta l'università? (12)
SELECT COUNT(*) as 'tot_dipartimenti' FROM `departments`;

-- 8. Quanti sono gli insegnanti che non hanno un numero di telefono? (50)
SELECT * FROM `teachers` WHERE `phone` IS NULL;



-- GROUP BY

-- 1. Contare quanti iscritti ci sono stati ogni anno
SELECT COUNT(*), YEAR(`enrolment_date`) FROM `students` GROUP BY YEAR(`enrolment_date`);

-- 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio
SELECT COUNT(*) AS `numero_insegnati`, `office_address` FROM `teachers` GROUP BY `office_address`;

-- 3. Calcolare la media dei voti di ogni appello d'esame
SELECT ROUND(AVG(`vote`),0) AS 'media_voti', `exam_id` AS 'esame' FROM `exam_student` GROUP BY `exam_id`;

-- 4. Contare quanti corsi di laurea ci sono per ogni dipartimento
SELECT COUNT(*) AS 'n_corsi', `department_id` AS 'dipartimento' FROM `degrees` GROUP BY `department_id`;


-- JOIN


-- 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
SELECT S.`id`,S.`name`, S.`surname` FROM `students`AS S JOIN `degrees`AS D ON S.`degree_id`= D.`id` WHERE D.`name`= 'Corso di Laurea in Economia';

-- 2. Selezionare tutti i Corsi di Laurea del Dipartimento di Neuroscienze
SELECT D.`name` FROM `degrees` AS D JOIN `departments` AS DP ON D.`department_id`= DP.`id` WHERE DP.`name`= 'Dipartimento di Neuroscienze';

-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
SELECT C.`name`, T.`name`, T.`surname`, T.`id` 
FROM `courses`AS C 
JOIN `course_teacher`AS CT ON C.`id`= CT.`course_id` 
JOIN `teachers`AS T ON T.`id`= CT.`teacher_id` 
WHERE T.`name`= 'Fulvio' AND T.`surname`= 'Amato';

-- 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome
SELECT `S`.`name` AS 'nome', S.`surname` AS 'cognome', d.`name` , DP. `name` FROM `students` AS S JOIN `degrees`AS D ON `S`.`degree_id` = D.`id` JOIN `departments` AS DP ON `DP`.`id`= D.`department_id`;

-- 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
SELECT D.`name`AS 'corso_laurea', C.`name`AS 'nome_corso', T.`name`AS 'nome_insegnante' FROM `degrees` AS D JOIN `courses`AS C ON D.`id`= C.`degree_id` JOIN `course_teacher` AS CT ON C.`id`= CT.`course_id` JOIN `teachers` AS T ON T.`id`= CT.`teacher_id`;

-- 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)
SELECT DISTINCT T.`name`AS 'nome_insegnante', T.`surname` AS 'cognome_insegnate', DP.`name` FROM `degrees` AS D JOIN `courses`AS C ON D.`id`= C.`degree_id` JOIN `course_teacher` AS CT ON C.`id`= CT.`course_id` JOIN `teachers` AS T ON T.`id`= CT.`teacher_id` JOIN `departments` AS DP ON DP.`id` = D.`department_id` WHERE DP.`name`= 'Dipartimento di Matematica';

-- 7. BONUS: Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per superare ciascuno dei suoi esami
SELECT S.`name` AS 'nome_studente', S.`surname` AS 'cognome_studente', C.`name` AS 'nome_corso' FROM `students`AS S JOIN `exam_student`AS ES ON S.`id`= ES.`Student_id` JOIN `exams` AS E ON E.`id`= ES.`exam_id` JOIN `courses`AS C ON C.`id` = E.`course_id`;