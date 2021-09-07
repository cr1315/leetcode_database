drop function if exists getNthHighestSalary;
SET GLOBAL log_bin_trust_function_creators = 1;
CREATE function getNthHighestSalary(N INT) returns INT
Begin
	DECLARE M INT;
	SET M=N-1;
	return (select distinct Salary from Employee order by Salary DESC limit 1 offset M);
END;

