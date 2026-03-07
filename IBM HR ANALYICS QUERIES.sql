use hranalytics;

SELECT*FROM hr_analytics;

ALTER TABLE hr_analytics
CHANGE COLUMN ï»¿EmpID EmpID VARCHAR(100);

#1. Overview & Demographics

# What is the total number of employees in the company?

SELECT  COUNT(distinct EMPID) as total_employees FROM hr_analytics;

# how many male and female employees work at the company?

SELECT gender, count(distinct empid) as total_eachgender FROM hr_analytics
group by gender;

# What is the breakdown of employees by Age Group?

SELECT AgeGroup, count(distinct empid) as total_agegroup FROM hr_analytics
group by AgeGroup;

#What is the average age of employees in each Department?

SELECT Department, avg(Age) as avg_age FROM hr_analytics
group by Department
order by Department;


#2. Attrition Analysis (The "Why" behind people leaving)

#what is the overall Attrition Rate of the company? Which Department has the highest Attrition count?

SELECT round(sum(case when Attrition='Yes' then 1 else 0 end)/count(distinct empid) *100,2) as attrition_rate, department FROM hr_analytics
group by department
order by Attrition_rate desc;

#Is there a correlation between DistanceFromHome and Attrition?

select Attrition, round(avg(DistanceFromHome),2) as avg_dist from hr_analytics
group by Attrition
order by Attrition desc;

#How many employees who left (Attrition = 'Yes') had a JobSatisfaction score of 1?
select count(distinct empid) as attrition_yes from hr_analytics
where Attrition = 'yes' and JobSatisfaction = 1
group by JobSatisfaction;


#3. Financial & Compensation Insights
#What is the average MonthlyIncome for each JobRole?Who are the top 5 highest-paid employees

select count(distinct EmpID) as emp_id, avg(MonthlyIncome) as avg_income, jobrole from hr_analytics
group by jobrole
order by avg_income desc
limit 5;

#Which SalarySlab has the highest number of employees

select count(distinct empid)as employee_count, SalarySlab from hr_analytics
group by SalarySlab
order by SalarySlab asc;


#What is the average HourlyRate for employees who work OverTime

select avg(HourlyRate) as avg_hr_rate, OverTime from hr_analytics
group by OverTime 
order by avg_hr_rate;

#What is the average WorkLifeBalance score by Department?

select avg(WorkLifeBalance) as avg_Work_life, department from hr_analytics
group by department
order by avg_Work_life desc;

#How many employees have a PerformanceRating of 4 but haven't been promoted in over 5 years?
select count(distinct empid) as employee_count, PerformanceRating, YearsSinceLastPromotion  from hr_analytics
where PerformanceRating = 4 
and YearsSinceLastPromotion > 5
group by PerformanceRating, YearsSinceLastPromotion
order by PerformanceRating;


#Which EducationField produces the highest-earning employees on average?
select count(distinct empid) as employee_count, avg(monthlyincome) as avg_income, EducationField  from hr_analytics
group by EducationField 
order by avg_income desc;

# 5. Loyalty & Tenure
#What is the average number of YearsAtCompany for each JobLevel?
select JobLevel,  avg(YearsAtCompany) as avg_years, count(distinct empid) as employeecount from hr_analytics
group by JobLevel
order by avg_years;

#How many employees have been with their current manager for more than 5 years?
select YearsWithCurrManager , count(distinct empid) as employeecount, Department, JobLevel, JobRole from hr_analytics
where YearsWithCurrManager > 5
group by YearsWithCurrManager, Department, JobLevel, JobRole
order by YearsWithCurrManager, JobLevel desc;

#List all employees who have worked at more than 3 companies  before joining.
select* from hr_analytics;
select JobLevel, JobRole ,  NumCompaniesWorked, count(distinct empid) as employeecount, Department from hr_analytics
where NumCompaniesWorked > 3
group by JobLevel, JobRole , Department, NumCompaniesWorked
order by JobLevel; 
