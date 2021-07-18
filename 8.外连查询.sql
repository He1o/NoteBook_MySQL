-- 二、sql99语法
/*
    语法：
        select 查询列表
        from 表1 别名 连接类型
        join 表2 别名
        on 连接条件
        【where 筛选条件】
        【group by 分组】
        【having 筛选条件】
        【order by 排序列表】

    分类：
        内连接： inner
        外连接
            左外 left 【outer】
            右外 right 【outer】
            全外 full 【outer】
        交叉连接  cross
*/

-- 一、内连接
-- 1、等值连接
/*
    特点：
    1、可以添加排序、分组、筛选
    2、inner可以省略
    3、筛选条件放在where后面，连接条件放在on后面，提高分离性，便于阅读
    4、inner join连接和92语法中的内连接一样
*/
-- 案例1：查询员工名、部门名
SELECT last_name, department_name
FROM employees e INNER 
JOIN departments d
ON e.`department_id` = d.`department_id`;

-- 案例2：查询名字中包含e的员工名和工种名【添加筛选】
SELECT last_name, job_title
FROM employees e INNER 
JOIN jobs j
ON e.`job_id` = j.`job_id`
WHERE  e.`last_name` LIKE '%e%';

-- 案例3：查询部门个数>3的城市名和部门个数【添加分组】
SELECT city, count(*)
FROM departments d INNER 
JOIN locations l
ON d.`location_id` = l.`location_id`
GROUP BY d.`location_id`
HAVING COUNT(*) > 3;

-- 案例4：查询哪个部门的部门员工个数>3的部门名和员工个数，并按个数降序【添加排序】
SELECT department_name, count(*)
FROM departments d INNER 
JOIN employees e
ON d.`department_id` = e.`department_id`
GROUP BY department_name
HAVING count(*) > 3
ORDER BY COUNT(*) DESC;

-- 案例5：查询员工名、部门名、工种名，并按部门名降序
SELECT last_name, department_name, job_title
FROM departments d INNER 
JOIN employees e
JOIN jobs j
ON d.department_id = e.department_id
AND e.job_id = j.job_id
ORDER BY department_name;

SELECT last_name, department_name, job_title
FROM departments d  
INNER JOIN employees e ON d.department_id = e.department_id
INNER JOIN jobs j ON e.job_id = j.job_id
ORDER BY department_name DESC;

-- 2、非等值连接
-- 案例1：查询员工的工资级别
SELECT salary, g.grade_level
FROM  employees e
JOIN job_grades g
ON e.`salary` BETWEEN g.`lowest_sal` AND g.`highest_sal`;

-- 案例2：查询每个工资级别的个数大于2的，并且按工资级别降序
SELECT COUNT(*), grade_level
FROM employees e
JOIN job_grades g
ON e.`salary` BETWEEN g.`lowest_sal` AND g.`highest_sal`
GROUP BY grade_level
HAVING COUNT(*) > 2
ORDER BY grade_level DESC;

-- 3、自连接
-- 案例1：查询员工的名字、上级的名字
SELECT e.last_name l1, m.last_name l2  
FROM employees e
JOIN employees m
ON e.manager_id = m.employee_id;


-- 二、外连接
/*
    
*/