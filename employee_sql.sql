
CREATE TABLE employees (
	emp_no INT PRIMARY KEY,
	birth_date DATE NOT NULL,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	gender VARCHAR(30) NOT NULL,
	hire_date DATE NOT NULL
	);
		

CREATE TABLE departments (
	dept_no VARCHAR(30) PRIMARY KEY,
	dept_name VARCHAR(30) NOT NULL
	);
		

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR(30) NOT NULL,
	from_date DATE,
	to_date DATE,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);
	
	

CREATE TABLE dept_manager (
	dept_no VARCHAR(30) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE,
	to_date DATE,
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
	);
	
	

CREATE TABLE salaries (
	emp_no INT NOT NULL,
	salary MONEY,
	from_date DATE,
	to_date DATE,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
	);
	

CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR(30),
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
	);
-- the following are details of each employee: employee number, last name, first name, gender, and salary.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary 
FROM employees
INNER JOIN salaries ON employees.emp_no = salaries.emp_no
ORDER BY emp_no;

-- List of employees who were hired in 1986
SELECT *
FROM employees
WHERE EXTRACT (year FROM (hire_date)) = 1986;

--List of the manager of each department with the following information: 
--department number, department name, the manager's employee number, 
--last name, first name, and start and end employment dates

SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no,employees.first_name, employees.last_name, dept_manager.from_date, dept_manager.to_date
FROM departments
JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
JOIN employees ON dept_manager.emp_no = employees.emp_no;

--List of the department of each employee with the following information: 
--employee number, last name, first name, and department name.

SELECT dept_emp.emp_no,employees.last_name,employees.first_name,departments.dept_name
FROM departments 
JOIN dept_emp ON departments.dept_no = dept_emp.dept_no
JOIN employees ON dept_emp.emp_no = employees.emp_no;

--List of all employees whose first name is "Hercules" and last names begin with "B."

SELECT employees.first_name, employees.last_name
FROM employees 
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--List of all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT dept_emp.emp_no,employees.last_name,employees.first_name,departments.dept_name
FROM departments 
JOIN dept_emp ON departments.dept_no = dept_emp.dept_no
JOIN employees ON dept_emp.emp_no = employees.emp_no
WHERE dept_name = 'Sales';

--List of  all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT dept_emp.emp_no,employees.last_name,employees.first_name,departments.dept_name
FROM departments 
JOIN dept_emp ON departments.dept_no = dept_emp.dept_no
JOIN employees ON dept_emp.emp_no = employees.emp_no
WHERE dept_name = 'Sales' OR departments.dept_name = 'Development';

--In descending order, A list of the frequency count of employee last names

SELECT employees.last_name, COUNT(employees.emp_no)
FROM employees
GROUP BY employees.last_name
ORDER BY COUNT(employees.emp_no) DESC;

