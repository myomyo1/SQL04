--1번 평균 급여보다 적은 급여를 받는 직원은 몇명입니까?
select count(*)
from employees
where salary < ( select avg(salary)
                 from employees    );
                 
--2번 각 부셔별로 최고의 급여를 받는 사원의 사원번호, 성, 급여, 부서번호를 조쇠하세요. 결과는 급여의 내림차순으로 정렬
--(2-1)조건절에서 비교
select e.employee_id, e.last_name, e.salary, e.department_id
from employees e
where (department_id, salary) in ( select department_id, max(salary)
                                   from employees
                                   group by department_id )
order by salary desc;
--(2-2)테이블에서 비교
select a.employee_id, a.last_name, a.salary, a.department_id
from employees a , (select department_id, max(salary) ms
                    from employees
                    group by department_id) b
where a.department_id=b.department_id and a.salary=b.ms;

--3번 각 업무별로 연봉의 총 합을 구하고자 합니다. 연봉 총합이 가장 높은 업무부터 업무명과 연봉 총합을 조회하시오
select j.job_title, b.ss
from jobs j, (select job_id, sum(salary) ss
              from employees
              group by job_id) b
where j.job_id=b.job_id
order by ss desc;

--4번 자신의 부서 평균 급여보다 연봉이 많은 직원의 직원 번호, 성, 급여
select employee_id, last_name, salary
from employees a, (select department_id, avg(salary) avs
                   from employees
                   group by department_id) b
where a.department_id=b.department_id and a.salary>b.avs ;