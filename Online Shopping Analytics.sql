select * from geo;
select * from people;
select * from products;
select * from sales;

-- Q1-Print details of sales where amounts are > 2,000 and boxes are < 100

select * from sales where amount > 2000 and boxes < 100;

-- Q2-How many sales did each of the salespersons have in January 2022?

select spid, sum(s.amount) as "Total January 2022 Sales" from sales where saledate between'2022-01-01 00:00:00' and
'2022-01-31 00:00:00' group by spid order by sum(amount) desc;

select distinct s.spid, p.salesperson, sum(s.amount) as "Total January 2022 Sales" from sales s inner join people p
on s.spid = p.spid where saledate >'2021-12-31 00:00:00' and saledate < '2022-02-01 00:00:00' 
group by p.salesperson;

-- Q3-Which product sells more boxes?

select s.pid, pr.product, sum(s.boxes) as 'Number of Boxes Sold' from sales s inner join products pr 
on s.pid = pr.pid group by s.pid order by sum(s.boxes) desc;

-- Q4-Which product sold more boxes in the first 7 days of February 2022?

select s.pid, p.product, sum(s.boxes) as 'Number of Boxes Sold' from sales s inner join products p 
on s.pid = p.pid where s.saledate between '2022-02-01' and '2022-02-07' group by s.pid order by sum(s.boxes) desc;

-- Q5-Which sales had under 100 customers & 100 boxes? Did any of them occur on Wednesday?

select s.spid, s.pid, p.salesperson, pr.product, s.customers, s.boxes from sales s 
inner join people p on s.spid = p.spid inner join products pr on s.pid = pr.pid 
where s.customers < 100 and s.boxes < 100 and dayofweek(s.saledate) = 04 order by s.customers desc, s.boxes;

