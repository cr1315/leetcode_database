use LC0175;

select
	p.firstname As FirstName,
	p.lastname As LastName,
	a.city as City,
	a.state as State
from
	Person as p
	left outer join Address as a
	on p.personid = a.personid