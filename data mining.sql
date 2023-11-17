use retail_db;
## BASIC QUERIES
-- q1: What is the distribution of order values across all customers in the dataset?

select CustomerID, sum(Quantity * UnitPrice) as TotalOrderValue
from online_retail
group by CustomerID
order by  TotalOrderValue desc;

-- q2: How many unique products has each customer purchased?
select CustomerID , count(distinct StockCode) as uniqueproduct 
from online_retail
 group by CustomerID;




-- q3: Which customers have only made a single purchase from the company?
select CustomerID , Count(StockCode) as SinglePurchase from online_retail group by CustomerID having SinglePurchase=1;


-- q4:  Which products are most commonly purchased together by customers in the dataset?
select stockCode, count(distinct customerID ) from online_retail group by StockCode;

-- Advance Queries
-- q1:Customer Segmentation by Purchase Frequency

select CustomerID,
       case
          when count(distinct InvoiceDate) > 50000000 then 'High'
         when count(distinct InvoiceDate) > 25000000 then  'Medium'
          else 'Low'
       end as  PurchaseFrequency 
       from online_retail
group by CustomerID;

##q2:Calculate the average order value for each country to identify where your most valuable customers are located.

select Country, avg(Quantity * UnitPrice) as AvgOrderValue
from online_retail
group by Country;

##q3:  Identify customers who haven't made a purchase in a specific period (e.g., last 6 months) to assess churn.
 select CustomerID, count(distinct InvoiceNo) as TotalPurchases
from online_retail
where CustomerID is not null
group by CustomerID
having max(InvoiceDate) < date_sub(now(), interval 6 month);

## q4: Determine which products are often purchased together by calculating the correlation between product purchases
select t1.StockCode as  Product1, t2.StockCode as Product2, count(*) as Frequency
from online_retail t1
join online_retail t2 on t1.InvoiceNo = t2.InvoiceNo and t1.StockCode < t2.StockCode
group by Product1, Product2 
order by frequency desc
 limit 10;
 
 ##5:   Explore trends in customer behavior over time, such as monthly or quarterly sales patterns.
 
 select date_format(InvoiceDate, '%d-%m') as Month,
       count(distinct CustomerID) as UniqueCustomers,
       sum(Quantity * UnitPrice) as  TotalRevenue
from online_retail
group by month order by month;

select * from online_retail
where InvoiceNo is null or  StockCode is null or Description is null 
or Quantity is null 
or InvoiceDate is null
 or UnitPrice is null 
 or UnitPrice is null
or UnitPrice is null 
or CustomerID is null
 or Country is null;












