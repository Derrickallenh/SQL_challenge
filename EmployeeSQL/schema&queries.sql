CREATE TABLE "Departments" (
    "dept_no" VARCHAR (10)  NOT NULL,
    "dept_name" VARCHAR (30) NOT NULL UNIQUE,
   PRIMARY KEY ("dept_no")
);


CREATE TABLE "Dept_emp" (
    "emp_no" INT   NOT NULL,
	"dept_no" VARCHAR (10)   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);


CREATE TABLE "Dept_manager" (
    "dept_no" VARCHAR (10)   NOT NULL,
    "emp_no" INT   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);


CREATE TABLE "Employees" (
    "emp_no" INT   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR (30)   NOT NULL,
    "last_name" VARCHAR (30)   NOT NULL,
    "gender" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    PRIMARY KEY ("emp_no")
 );


CREATE TABLE "Salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);


CREATE TABLE "Titles" (
    "emp_no" INT   NOT NULL,
    "title" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);


ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Dept_manager" ADD CONSTRAINT "fk_Dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_manager" ADD CONSTRAINT "fk_Dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Titles" ADD CONSTRAINT "fk_Titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

///Queries///

SELECT * FROM "Salaries";
SELECT * FROM "Employees";
SELECT * FROM "Dept_manager";
SELECT * FROM "Dept_emp";
SELECT * FROM "Departments";
SELECT * FROM "Titles";


--1. List the following details of each employee: employee number, 
--last name, first name, gender, and salary.

SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM "Salaries" AS s
INNER JOIN "Employees" AS e ON
e.emp_no = s.emp_no;

--2.List employees who were hired in 1986.
SELECT first_name, last_name, hire_date 
FROM "Employees" WHERE hire_date BETWEEN '1986-01-01' AND '1987-01-01';

--3.List the manager of each department with the following information: 
--department number, department name, the manager's employee number, 
--last name, first name, and start and end employment dates.


SELECT d.dept_no, d.dept_name, m.emp_no, e.last_name, e.first_name, m.from_date, m.to_date
FROM "Departments" AS d
INNER JOIN "Dept_manager" AS m ON
m.dept_no = d.dept_no
JOIN "Employees" AS e ON
e.emp_no = m.emp_no;


--4.List the department of each employee with the following information: 
--employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, dp.dept_name
FROM "Employees" AS e
INNER JOIN "Dept_emp" AS d ON
e.emp_no = d.emp_no
INNER JOIN "Departments" AS dp ON
dp.dept_no = d.dept_no;


--5. List all employees whose first name is "Hercules" 
--and last names begin with "B."

SELECT * FROM "Employees"
WHERE "first_name" LIKE 'Hercules'
AND "last_name" LIKE 'B%';

--6. List all employees in the Sales department, including their employee number, 
--last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, dp.dept_name
FROM "Employees" AS e
INNER JOIN "Dept_emp" AS d ON
e.emp_no = d.emp_no
INNER JOIN "Departments" AS dp ON
dp.dept_no = d.dept_no
WHERE dp.dept_name LIKE 'Sales';

--7. List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, dp.dept_name
FROM "Employees" AS e
INNER JOIN "Dept_emp" AS d ON
e.emp_no = d.emp_no
INNER JOIN "Departments" AS dp ON
dp.dept_no = d.dept_no
WHERE dp.dept_name LIKE 'Development'
OR dp.dept_name LIKE 'Sales';

--8. In descending order, list the frequency count of 
--employee last names, i.e., how many employees share each last name.

SELECT "last_name", 
COUNT(*) AS frequency
FROM "Employees"
GROUP BY last_name
ORDER BY frequency DESC;