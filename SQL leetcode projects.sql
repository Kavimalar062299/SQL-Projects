# 1. find the ids of all products that are low in fat and recyclable
select product_id
from products
where low_fats='y' and recyclable='y';

# 2. list the names of all customers whose referee id is not 2 or is missing, sorted alphabetically
select name
from customer
where referee_id != 2 or referee_id is null
order by name;

# 3. retrieve countries with an area of at least 3,000,000 or a population of at least 25,000,000
select name, population, area
from world
where area >= 3000000 or population >= 25000000;

# 4. find all authors who have viewed their own content
select distinct author_id as id
from views
where author_id = viewer_id
order by id;

# 5. list tweet ids for tweets that have content longer than 15 characters
select tweet_id
from tweets
where char_length(content) > 15
order by tweet_id;

# 6. show each employee’s name along with their unique id from the employeeuni table, if available
select eu.unique_id, e.name
from employees e
left join employeeuni eu on e.id = eu.id
order by unique_id;

# 7. display product name, sales year, and price for all sales, sorted by product name
select p.product_name, s.year, s.price
from sales s
join product p on p.product_id = s.product_id
order by p.product_name;

# 8. count the number of visits per customer that did not result in a transaction
select v.customer_id, count(v.visit_id) as count_no_trans
from visits v
left join transactions t on v.visit_id = t.visit_id
where t.transaction_id is null
group by v.customer_id;

# 9. find weather records where the temperature increased compared to the previous day
select w1.id
from weather w1
join weather w2 on datediff(w1.recorddate, w2.recorddate) = 1
where w1.temperature > w2.temperature
order by w1.id;

# 10. calculate the average processing time for each machine based on start and end activities
select m1.machine_id, round(avg(m2.timestamp - m1.timestamp),3) as processing_time
from activity m1
left join activity m2
on m1.machine_id = m2.machine_id and m1.process_id = m2.process_id
and m1.activity_type = 'start' and m2.activity_type = 'end'
group by m1.machine_id;

# 11. list employees with bonuses less than 1000 or no bonus, sorted by name
select e.name, b.bonus
from employee e
left join bonus b on e.empid = b.empid
where b.bonus < 1000 or b.bonus is null
order by e.name;

# 12. for each student and subject, count the number of exams the student attended
select s.student_id, s.student_name, su.subject_name, count(e.student_id) as attended_exams
from students s
cross join subjects su
left join examinations e on s.student_id = e.student_id and su.subject_name = e.subject_name
group by s.student_id, s.student_name, su.subject_name
order by student_id, su.subject_name;

# 13. list the names of managers who manage at least 5 employees
select name
from employee e1
join employee e2 on e1.id = e2.managerid
group by e1.id, e2.name
having count(e1.id) >= 5;

# 14. calculate the confirmation rate for each user
select s.user_id,
ifnull(round(sum(case when c.action = 'confirmed' then 1 else 0 end)/count(c.action),2),0) as confirmation_rate
from signups s
left join confirmations c on s.user_id = c.user_id
group by s.user_id;

# 15. retrieve odd-numbered cinemas whose description is not 'boring', ordered by rating descending
select *
from cinema
where id % 2 = 1 and description != 'boring'
order by rating desc;

# 16. calculate the average price of each product weighted by units sold
select p.product_id, coalesce(round(sum(p.price*u.units)/sum(u.units),2),0) as average_price
from prices p
left join unitssold u on p.product_id = u.product_id and u.purchase_date between p.start_date and p.end_date
group by p.product_id;

# 17. count the number of distinct subjects each teacher teaches
select teacher_id, count(distinct subject_id) as cnt
from teacher
group by teacher_id
order by teacher_id;

# 18. compute the average experience of employees for each project
select p.project_id, round(avg(e.experience_years),2) as average_years
from project p
left join employee e on p.employee_id = e.employee_id
group by p.project_id;

# 19. for each query, calculate its quality score and the percentage of poor ratings
select query_name,
round(avg(rating*1.0/position),2) as quality,
round(sum(case when rating < 3 then 1 else 0 end)*100/count(*),2) as poor_query_percentage
from queries
group by query_name;

# 20. show monthly transaction counts, approved counts, total amounts, and approved amounts per country
select date_format(trans_date,'%Y-%m') as month,
country,
count(*) as trans_count,
count(case when state='approved' then 1 end) as approved_count,
sum(amount) as trans_total_amount,
sum(case when state='approved' then amount else 0 end) as approved_total_amount
from transactions
group by date_format(trans_date,'%Y-%m'), country
order by trans_date;

# 21. count daily active users over a one-month period
select activity_date as day, count(distinct user_id) as active_users
from activity
where activity_date between '2019-06-28' and '2019-07-27'
group by activity_date
order by activity_date;

# 22. for each product, get the first year it was sold along with quantity and price
select product_id, year as first_year, quantity, price
from sales
where (product_id, year) in (
    select product_id, min(year)
    from sales
    group by product_id
);

# 23. list classes with at least 5 students enrolled
select class
from courses
group by class
having count(student) >= 5;

# 24. count the number of followers for each user
select user_id, count(follower_id) as followers_count
from followers
group by user_id
order by user_id asc;

# 25. find customers who have purchased every product
select customer_id
from customer
group by customer_id
having count(distinct product_key) = (select count(*) from product);

# 26. for each employee who is a manager, count the number of reports and their average age
select e1.employee_id, e1.name, count(e2.employee_id) as reports_count, round(avg(e2.age)) as average_age
from employees e1
join employees e2 on e1.employee_id = e2.reports_to
group by e1.employee_id, e1.name
order by e1.employee_id;