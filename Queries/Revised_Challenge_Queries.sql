--Table of Currently Employed Retirees and their titles
SELECT e.emp_no,
    e.first_name,
    e.last_name,
    t.title,
    t.from_date,
    t.to_date
INTO current_retirement_titles
FROM employees as e
    INNER JOIN titles as t
        ON (e.emp_no = t.emp_no)
WHERE (t.to_date = '9999-01-01')
	AND (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (crt.emp_no) crt.emp_no,
    crt.first_name,
    crt.last_name,
    crt.title
INTO current_unique_titles
FROM current_retirement_titles as crt
ORDER BY crt.emp_no, crt.to_date DESC;

--Find the number current retirees of unique titles
SELECT COUNT(cut.emp_no), cut.title
INTO current_retiring_titles
FROM current_unique_titles as cut
GROUP BY cut.title
ORDER BY cut.count DESC;
