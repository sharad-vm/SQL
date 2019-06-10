-- https://en.wikibooks.org/wiki/SQL_Exercises/Scientists
-- 6.1 List all the scientists' names, their projects' names, 
    -- and the hours worked by that scientist on each project, 
    -- in alphabetical order of project name, then scientist name.
select s.Name as Scientists, p.Name as Projects, p.Hours as HoursWorked
from Scientists s inner join
AssignedTo a on s.SSN = a.Scientist inner join
Projects p on p.Code = a.Project
order by p.Name, s.Name
    
-- 6.2 Select the project names which are not assigned yet
select p.Name as Projects
from Projects p left join
AssignedTo a on p.Code = a.Project
where a.Project is null
