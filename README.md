# Pewlett_Hackard_Analysis

## Overview of the analysis: 

The HR Analyst at Pewlett Hackard requested help with analyzing data to prepare for the upcoming retirement wave of baby boomer employees.  The company is trying to plan ahead to determine who will be retiring in the next few years and how many positions will need to be filled.  The analyst requested that six different Excel data sets be analyzed using SQL to determine the number of employees eligible for retirement for each position title and the number of employees eligible to participate in a mentorship program.

## Resources

 - Data: departments.csv, dept_emp.csv, dept_manager.csv, employees.csv, salaries.csv, titles.csv
 - Software: PostgreSQL 12.4, pgAdmin 4, QuickDBD

## Results: Provide a bulleted list with four major points from the two analysis deliverables. Use images as support where needed.
```sql
--Table of Retirees and their titles
SELECT e.emp_no,
    e.first_name,
    e.last_name,
    t.title,
    t.from_date,
    t.to_date
INTO retirement_titles
FROM employees as e
    LEFT JOIN titles as t
        ON (e.emp_no = t.emp_no)
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;
```

```sql
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
    rt.first_name,
    rt.last_name,
    rt.title
INTO unique_titles
FROM retirement_titles as rt
ORDER BY rt.emp_no, rt.to_date DESC;
```

```sql
--Find the number of unique titles
SELECT COUNT(ut.emp_title), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY ut.count DESC;
```

```sql
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
	LEFT JOIN dept_emp as de
    	ON (e.emp_no = de.emp_no)
	LEFT JOIN titles as t
    	ON (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01')
    AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;
```


## Summary: Provide high-level responses to the following questions, then provide two additional queries or tables that may provide more insight into the upcoming "silver tsunami."
 - How many roles will need to be filled as the "silver tsunami" begins to make an impact?
 - Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?
