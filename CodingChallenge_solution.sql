--Version: PostgreSQL13

--1.	
	create table PERSON
		(id serial, first_name varchar(50),last_name varchar(50),birth_date date,
			gender varchar(10),salary numeric(8,2),primary key(id));

--2.	
	insert into PERSON
		(first_name,last_name,birth_date,gender,salary)
		values
		('John','Doe','01-01-2020','Male',10000.50),
		('Mary','Jane','29-02-2020','Female',5000.12);
	
--3.	Function to choose random values from the provided array list
	CREATE FUNCTION randomValueFromList(valueList IN TEXT[])
	RETURNS TEXT AS
	$$
		WITH base AS (
			SELECT val
			FROM UNNEST(valueList) val
		)
		SELECT val
		FROM base
		ORDER BY RANDOM()
		LIMIT 1
	$$
	LANGUAGE 'sql'
	VOLATILE;

--	Script to insert 1 million records
	insert into PERSON
	(id,first_name,last_name,gender,birth_date,salary)
		select 
		generate_series(3,1000000) as id,
		randomValueFromList(Array['Aiden','Anika','Ariya','Ashanti','Avery','Cameron','Ceri','Che','Danica','Darcy'
		'Dion','Eman','Eren','Esme','Frankie','Gurdeep','Haiden','Indi','Isa','Jaskaran',
		'Jaya','Jo','Jodie','Kacey','Kameron','Kayden','Keeley','Kenzie','Lucca','Macauley','Manraj','Nur','Oluwatobiloba','Reiss','Riley',
		'Rima','Ronnie','Ryley','Sam','Sana','Shola','Sierra','Tamika','Taran','Teagan','Tia',
		'Tiegan','Virginia','Zhane','Zion']) as first_name,
		 randomValueFromList(Array['Ahmad','Andersen','Arias','Barlow','Beck','Bloggs','Bowes','Buck','Burris','Cano','Chaney','Coombes','Correa',
		'Coulson','Craig','Frye','Hackett','Hale','Huber','Hyde','Irving','Joyce','Kelley','Kim','Larson','Lynn','Markham','Mejia','Miranda','Neal',
		'Newton','Novak','Ochoa','Pate','Paterson','Pennington','Rubio','Santana','Schaefer','Schofield',
		'Shaffer','Sweeney','Talley','Trevino','Tucker','Velazquez'	,'Vu','Wagner','Walton','Woodward']) as last_name,
		randomValueFromList(Array['Male','Female'])as gender,
		now()+random()*(timestamp without time zone '1970-01-01'-
								timestamp without time zone '2070-12-31') as birth_date,
		random()*100000-random()*100 as salary;
	
	commit;

--4.(a) 
	select * from person where first_name='John' and last_name='Doe';
--	(b) 
	select * from person where gender='Female' and salary>5000.50
		and birth_date between to_timestamp(946684800)::date and to_timestamp(1609372800)::date;
--	(c) 
	select count(*),round(salary,-3) as salary,gender from person group by gender, round(salary,-3);

--5,6. Please refer to CodingChallenge_solution.docx 
