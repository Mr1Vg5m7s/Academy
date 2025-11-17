--Вивести номери корпусів, якщо сумарний фонд фінансування розташованих у них кафедр перевищує 100000.

SELECT D.Building, SUM(D.Financing)
FROM Departments D
GROUP BY D.Building
HAVING SUM (D.Financing) > 50000

--Вивести назви груп 5-го курсу кафедри «From Software», які мають понад 10 пар на перший тиждень.

SELECT G.Name, G.Year, D.Name, COUNT(L.Id)
FROM Departments D, Groups G, GroupsLectures GL, Lectures L
WHERE D.Id = G.DepartmentId AND G.Id = GL.GroupId AND GL.LectureId = L.Id AND G.Year = 1 AND D.Name = 'Кафедра Програмування'
GROUP BY G.Year, G.Year, D.Name
HAVING COUNT(L.Id) >= 2
--Вивести назви груп, які мають рейтинг (середній рейтинг усіх студентів групи) більший, ніж рейтинг групи «D221».

SELECT G.Name, AVG(CONVERT(real, S.Rating))
FROM Groups G, GroupsStudents GS, Students S
WHERE G.Id = GS.GroupId AND GS.StudentId = S.Id
GROUP BY G.Name
HAVING AVG(CONVERT(real, S.Rating)) > (SELECT AVG(CONVERT(real, S.Rating))
										FROM Groups G, GroupsStudents GS, Students S
										WHERE G.Id = GS.GroupId AND GS.StudentId = S.Id AND G.Name = 'ІП-12'
										GROUP BY G.Name)
--Вивести прізвища та імена викладачів, ставка яких вища за середню ставку про­фесорів.

SELECT T.Name, T.Surname, T.Salary
FROM Teachers T
WHERE T.Salary > (
				SELECT AVG(T.Salary)
				FROM Teachers T
	 			WHERE T.IsProfessor = 1)

--Вивести назви груп, які мають більше одного куратора.

SELECT G.Name, COUNT(C.Surname)
FROM Groups G, GroupsCurators GC, Curators C
WHERE G.Id = GC.GroupId AND GC.CuratorId = C.Id
GROUP BY G.Name
HAVING COUNT(C.Surname) > 1

--Вивести назви груп, які мають рейтинг (середній рейтинг усіх студентів групи) менший, ніж мінімальний рейтинг груп 5-го курсу.

SELECT G.Name, AVG(CONVERT(real, S.Rating))
FROM Groups G, GroupsStudents GS, Curators S
WHERE G.Id = GS.GroupId AND GS.StudentId = S.Id
GROUP BY G.Name
HAVING AVG(CONVERT(real, S.Rating)) < (SELECT MAX(S.Rating)
										FROM Students S, GroupsStudents GS, Groups G
										WHERE S.Id = GS.StudentId AND GS.GroupId = G.Id AND G.Year = 5)




--Вивести назви факультетів, сумарний фонд фінансування кафедр яких більший за сумарний фонд фінансування кафедр факультету «Сomputer Science».

SELECT F.Name, SUM(D.Financing)
FROM Faculties F, Departments D
WHERE F.Id = D.FacultyId
GROUP BY F.Name
HAVING SUM(D.Financing) > (SELECT SUM(D.Financing)
						FROM Faculties F, Departments D
						WHERE F.Id = D.FacultyId AND F.Name = 'Факультет Математики'
						GROUP BY F.Name
						)



--Вивести назви дисциплін та повні імена викладачів, які читають найбільшу кіль­кість лекцій з них.

SELECT T.Surname, COUNT(L.Id)
FROM Teachers T, Lectures L
WHERE T.Id = L.TeacherId
GROUP BY T.Surname
HAVING COUNT(L.Id) = (SELECT MAX(TT.CountLectures)
FROM (SELECT COUNT(L.Id) as 'CountLectures'
	  FROM Teachers T, Lectures L
	  WHERE T.Id = L.TeacherId
	  GROUP BY T.Surname) as TT)

--Вивести назву дисципліни, за якою читається найменше лекцій.

SELECT S.Name, COUNT(L.Id) 
FROM Subjects S, Teachers T, Lectures L
WHERE S.Id = L.SubjectId
GROUP BY S.Name
HAVING COUNT(L.Id) = (SELECT MIN(TT.Sub) 
						FROM (SELECT COUNT(L.Id) as 'Sub'
							FROM Subjects S, Lectures L
							WHERE S.Id = L.SubjectId 
						GROUP BY S.Name) as TT)



--Вивести кількість студентів та дисциплін, що читаються на кафедрі «Software Development».


SELECT St.Name, COUNT(St.Id)
FROM Subjects S, Lectures L, GroupsLectures GL, Groups G, GroupsStudents GS, Students St, Departments D
WHERE S.Id = L.SubjectId AND GL.LectureId = L.Id AND GL.GroupId = G.Id AND GS.GroupId = GS.Id AND DepartmentId = D.Id

