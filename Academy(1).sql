--база в задании
-- 1. Кафедри у зворотному порядку полів
SELECT Name, Financing, Id
FROM Departments;

--2. Назви груп та їх рейтинги з новими назвами полів 
SELECT G.Name AS [Group Name], G.Rating AS [Group Rating]
FROM Groups G;

-- 3. Прізвище, % ставки до надбавки і % ставки до загальної зарплати 
 SELECT 
    T.Surname,
    (T.Salary / T.Premium) * 100 AS SalaryToPremiumPercent,
    (T.Salary / (T.Salary + T.Premium)) * 100 AS SalaryToTotalPercent
FROM Teachers T;

--4
SELECT 'The dean of faculty ' + F.Name + ' is ' + F.Dean + '.' AS Info
FROM Faculties F;

--5
SELECT T.Surname
FROM Teachers T
WHERE T.IsProfessor = 1
  AND T.Salary > 1050;

--6
SELECT D.Name
FROM Departments D
WHERE D.Financing < 11000
   OR D.Financing > 25000;

--7
SELECT F.Name
FROM Faculties F
WHERE F.Name <> 'Computer Science';

--8
SELECT T.Surname, T.Position
FROM Teachers T
WHERE T.IsProfessor = 0;

--9
SELECT T.Surname, T.Position, T.Salary, T.Premium
FROM Teachers T
WHERE T.IsAssistant = 1
  AND T.Premium BETWEEN 160 AND 550;

--10
SELECT T.Surname, T.Salary
FROM Teachers T
WHERE T.IsAssistant = 1;

--11
SELECT T.Surname, T.Position
FROM Teachers T
WHERE T.EmploymentDate < '2000-01-01';

--12
SELECT D.Name AS [Name of Department]
FROM Departments D
WHERE D.Name < 'Software Development';

--13
SELECT T.Surname
FROM Teachers T
WHERE T.IsAssistant = 1
  AND (T.Salary + T.Premium) <= 1200;

--14
SELECT G.Name
FROM Groups G
WHERE G.Year = 5
  AND G.Rating BETWEEN 2 AND 4;


SELECT T.Surname, T.Salary, T.Premium
FROM Teachers T
WHERE T.IsAssistant = 1
  AND (T.Salary < 550 OR T.Premium < 200);
