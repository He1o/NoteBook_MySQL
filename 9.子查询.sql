/*
    子查询
        含义： 
            出现在其他语句中的select语句，称为子查询和内查询
            内部嵌套其他select语句的查询，称为主查询或外查询
        分类：
            按子查询出现的位置：
                select 后面
                    只支持标量子查询
                from 后面
                    支持表子查询
                where或havign 后面 🌟
                    标量子查询
                    列子查询
                    行子查询（使用较少）
                exists 后面（相关子查询）
                    表子查询
            按结果集的行列数：
                标量子查询（结果集中只有一行一列）
                列子查询（结果集只有一列多行）
                行子查询（结果集有一行多列）
                表子查询（结果集多行多列）
*/

-- 一、where或having后面
/*
    特点：
        1、子查询放在小括号内
        2、子查询一般放在条件的右侧
        3、标量子查询，一般搭配着单行操作符使用
            > < <= >= = <>
        4、列子查询，一般搭配多行操作符使用
            in  any/some  all
            - in / not in 在不在
            - ANY/SOME   
                ANY 大于任意一个，可用min代替
                SOME 
            - ALL 大于所有的，可用max代替
        5、子查询结果优先于主查询
*/
-- 1、标量子查询（单行子查询）
-- 案例1:谁的工资比Abel高
SELECT salary, last_name
FROM employees
WHERE salary > (
    SELECT salary
    FROM employees
    WHERE last_name = 'Abel'
);

-- 案例2:返回job_id与141号员工相同，salary比143号员工多的员工姓名、job_id、工资
SELECT last_name, job_id, salary
FROM employees
WHERE job_id = (
    SELECT job_id
    FROM employees
    WHERE employee_id = '141'
) AND salary > (
    SELECT salary
    FROM employees
    WHERE employee_id = '143'    
);

-- 案例3:返回公司工资最少的员工的名字、job、salary
SELECT last_name, job_id, salary
FROM employees
WHERE salary = (
    SELECT MIN(salary)
    FROM employees
);

-- 案例4:查询最低工资大于50号部门最低工资的部门id和其最低工资
SELECT MIN(salary), department_id
FROM employees
GROUP BY department_id
HAVING MIN(salary) > (
    SELECT MIN(salary)
    FROM employees
    WHERE department_id = 50
);

-- 2、列子查询（多行子查询）
-- 案例1:返回location_id是1400或1700的部门中的所有员工姓名
SELECT last_name
FROM employees
WHERE department_id in (
    SELECT DISTINCT department_id
    FROM departments
    WHERE location_id IN(1400, 1700)
);

-- 案例2:返回其他部门中比job_id为‘IT_PROG’部门任一工资低的员工的员工工号、姓名、jid以及salary
SELECT employee_id, last_name, salary
FROM employees
WHERE 

-- 3、行子查询（多列多行）


