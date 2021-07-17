# 按表达式或函数分组

# 案例：按员工姓名的长度分组，查询每一组的员工个数，筛选员工个数>5的有哪些

select count(*) , length(last_name)
from empoyees
group by length(last_name)
having count(*) > 5;

# 按多个字段分组

# 案例：查询每个部门每个工种的员工平均工资

select avg(salary), department_id, job_id
from employees
group by department_id, job_id;


# 添加排序

# 查询每个部门每个工种员工的平均工资，并且按平均工资的高低排序

select avg(salary), department_id, job_id
from employees
group by department_id, job_id
order by avg(salary);

# 查询各个管理者手下员工的最低工资，其中最低工资不能低于6000，没有管理者的员工不计算在内
select min(salary), manager_id
from employees
where manager_id is not null
group by manager_id
having min(salary) >= 6000;


