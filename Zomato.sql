drop table if exists goldusers_signup;
CREATE TABLE goldusers_signup(userid integer,gold_signup_date date)

INSERT INTO goldusers_signup(userid,gold_signup_date) values (1,'09-22-2017'),(3,'04-21-2017');

select * from goldusers_signup

drop table if exists users;
CREATE TABLE users(userid integer, signup_date date)

INSERT INTO users(userid,signup_date) values (1,'09-02-2014'),(2,'01-15-2015'),(3,'04-11-2014');

drop table if exists sales;
CREATE TABLE sales(userid integer,created_date date,product_id integer)

INSERT INTO sales(userid,created_date,product_id) values (1,'04-19-2017',2),
(3,'12-18-2019',1),
(2,'07-20-2020',3),
(1,'10-23-2019',2),
(1,'03-19-2018',3),
(3,'12-20-2016',2),
(1,'11-09-2016',1),
(1,'05-20-2016',3),
(2,'09-24-2017',1),
(1,'03-11-2017',2),
(1,'03-11-2016',1),
(3,'11-10-2016',1),
(3,'12-07-2017',2),
(3,'12-15-2016',2),
(2,'11-08-2017',2),
(2,'09-10-2018',3)

drop table if exists product;
create table product(product_id integer, product_name text, price integer)

INSERT into product(product_id,product_name,price) values (1,'p1',980),
(2,'p2',870),
(3,'p3',330)

select * from sales;
select * from product;
select * from goldusers_signup;
select * from users;

--1.What is the total amount each customer spent on Zomato?

select s.userid, sum(p.price) as total_amount
from sales s 
inner join product p on s.product_id = p.product_id
group by s.userid

--2.How many days has each customer visited the restaurant?

select userid, count(distinct created_date)as total_days from sales
group by userid

--3.what was the first product purchased by each customer?

select * 
from 
	(select * , rank() over(partition by userid order by created_date asc) as rnk from sales) a 
where rnk = 1

--4.What is the most purchased item on the menu and how many times was it purchased by all customers?

select product_id, count(product_id) as count_of_purchase
from sales
group by product_id
order by count(product_id) desc

select userid, count(product_id) as count_of_purchase 
from sales 
where product_id = 
					(
					select top 1 product_id
					from sales
					group by product_id
					order by count(product_id) desc
					)
group by userid

--5.Which item was the most popular for each customer?

select * 
from 
(
	select *, rank() over(partition by userid order by cnt desc) as rnk
	from
		(
		select userid, product_id, count(product_id) as cnt
		from sales
		group by userid,product_id
		) 
		a
) b
where rnk = 1

--6.Which item was purchased first by the customer after they became a gold member?

select * from 
(select c.*, RANK() over(partition by userid order by created_date asc) rnk from
(select s.userid, s.created_date, s.product_id, g.gold_signup_date
from sales s
inner join goldusers_signup g on s.userid = g.userid
and created_date >= gold_signup_date)c)d where rnk = 1

--7.Which item was purchased just before the customer became a gold member?

select * from 
(select c.*, RANK() over(partition by userid order by created_date desc) rnk from
(select s.userid, s.created_date, s.product_id, g.gold_signup_date
from sales s
inner join goldusers_signup g on s.userid = g.userid
and created_date <= gold_signup_date)c)d where rnk = 1


--8.What is the total items and amount spent for each member before they became a member?

select s.userid, count(s.product_id) as total_orders, sum(p.price) as total_amount
from sales s 
inner join goldusers_signup g on s.userid = g.userid
inner join product p on s.product_id = p.product_id
and created_date <= gold_signup_date
group by s.userid

--9.If each 5Rs spent on Product1 equates to 1 Zomato point similarly Product2 provides 5 Zomato points on spending of 10Rs 
-- and Product3 has 1 Zomato Point for 5Rs - how many points would each customer have?

select userid,sum(total_points)*2.5 total_money_earned from
(select e.*, amt/points total_points from
(select d.*, case when product_id = 1 then 5 when product_id=2 then 2
when product_id=3 then 5 else 0 end as points from
(select c.userid,c.product_id,sum(price) amt from
(select a.*,b.price from sales a inner join product b on 
a.product_id = b.product_id)c
group by userid,product_id)d)e)f group by userid

--10.In the first one year after a customer joins the gold program (including their
--joining date) they earn 5 Zomato Points for every 10rs on all the items - How many points do customers have at the end of the First year


select c.*, d.price*0.5 total_points_earned from
(select s.userid, s.created_date, s.product_id, g.gold_signup_date
from sales s
inner join goldusers_signup g on s.userid = g.userid
and created_date <= gold_signup_date and created_date <= DATEADD(YEAR,1,gold_signup_date))c
inner join product d on c.product_id = d.product_id 

--11.Rank all the transactions of each customer.

select *, RANK() OVER(partition by userid order by created_date asc) rn
from sales

--12.Business also requires further information about the ranking of products. they purposely does not need the ranking of non member purchases so they expects 'NA' ranking values for customers who are not yet part of the gold program.

select e.*, case when rnk=0 then 'NA' else rnk end as rnkk from 
(select c.*,cast((case when gold_signup_date is null then 0 else RANK() over(partition by userid order by created_date desc) end) as varchar) rnk from 
(select s.userid, s.created_date, s.product_id, g.gold_signup_date
from sales s
left join goldusers_signup g on s.userid = g.userid
and created_date >= gold_signup_date)c)e;

