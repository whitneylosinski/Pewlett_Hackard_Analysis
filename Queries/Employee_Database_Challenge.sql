--Table of Retirees and their titles
SELECT e.emp_no,
    e.first_name,
    e.last_name,
    t.title,
    t.from_date,
    t.to_date
INTO retirement_titles
FROM employees as e
    INNER JOIN titles as t
        ON (e.emp_no = t.emp_no)
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

--Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
    rt.first_name,
    rt.last_name,
    rt.title
INTO unique_titles
FROM retirement_titles as rt
ORDER BY rt.emp_no, rt.to_date DESC;

--Find the number of unique titles
SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY ut.count DESC;

--Table of Mentorship Eligibility
SELECT DISTINCT ON (e.emp_no) e.emp_no, 
    e.first_name,
    e.last_name,
    e.birth_date,
    de.from_date,
    de.to_date,
    t.title
INTO mentorship_eligibility
FROM employees as e
	INNER JOIN dept_emp as de
    	ON (e.emp_no = de.emp_no)
	INNER JOIN titles as t
    	ON (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01')
    AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;


--Two additional tables for summary
--Table of Currently Employed Retirees and their departments
SELECT e.emp_no,
    e.first_name,
    e.last_name,
    de.dept_no,
    de.from_date,
    de.to_date
INTO current_retirement_departments
FROM employees as e
    INNER JOIN dept_emp as de
        ON (e.emp_no = de.emp_no)
WHERE (de.to_date = '9999-01-01')
	AND (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

--Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (crd.emp_no) crd.emp_no,
    crd.first_name,
    crd.last_name,
    crd.dept_no
INTO current_unique_departments
FROM current_retirement_departments as crd
ORDER BY crd.emp_no, crd.to_date DESC;

--Find the number current retirees of unique departments
SELECT COUNT(cud.emp_no), cud.dept_no
INTO current_retiring_titles
FROM current_unique_departments as cud
GROUP BY cud.dept_no
ORDER BY cud.count DESC;

--Table of Mentorship Eligibility
SELECT DISTINCT ON (e.emp_no) e.emp_no, 
    e.first_name,
    e.last_name,
    e.birth_date,
    de.from_date,
    de.to_date,
    de.dept_no
INTO mentorship_eligibility_departments
FROM employees as e
	INNER JOIN dept_emp as de
    	ON (e.emp_no = de.emp_no)
WHERE (de.to_date = '9999-01-01')
    AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

--Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (med.emp_no) med.emp_no,
    med.first_name,
    med.last_name,
    med.dept_no
INTO unique_membership_departments
FROM mentorship_eligibility_departments as med
ORDER BY med.emp_no, med.to_date DESC;

--Find the number current mentorship-eligible employees of unique departments
SELECT COUNT(umd.emp_no), umd.dept_no
INTO membership_count_departments
FROM unique_membership_departments as umd
GROUP BY umd.dept_no
ORDER BY umd.count DESC;