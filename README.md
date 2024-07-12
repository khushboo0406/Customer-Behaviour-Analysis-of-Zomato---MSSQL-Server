# Customer-Behaviour-Analysis-of-Zomato MSSQL-Server

This project and the data used are a sample data of Zomato and it is replicating the same business model followed by Zomato. It focuses on examining patterns, trends, and factors influencing customer spending in order to gain insights into their preferences, purchasing habits, and potential areas for improvement in menu offerings or marketing strategies in a dining establishment.

### Background

This data consists of the data from the beginning of 2021, it consist of 3 products: P1, P2 and P3. Business is in need of your assistance to help the restaurant stay afloat - the restaurant has captured some very basic data from their few months of operation but have no idea how to use their data to help them run the business.

### Problem Statement

Business wants to use the data to answer a few simple questions about the customers, especially about their visiting patterns, how much money they’ve spent and also which products are their favorite. Having this deeper connection with his customers will help them deliver a better and more personalized experience for loyal customers.

The plans on using these insights to help them decide whether they should expand the existing customer loyalty program - additionally they also needs help to generate some basic datasets so his team can easily inspect the data without needing to use SQL.

Business has provided you with a sample of his overall customer data due to privacy issues - but looks like these examples are enough for you to write fully functioning SQL queries to help him answer all the questions!

### Skills Applied

Window Functions
CTEs
Aggregations
JOINs
Converting Column datatype - CAST()

### Questions Explored

- What is the total amount each customer spent on Zomato?
- How many days has each customer visited the restaurant?
- What was the first product purchased by each customer?
- What is the most purchased item on the menu and how many times was it purchased by all customers?
- Which item was the most popular for each customer?
- Which item was purchased first by the customer after they became a gold member?
- Which item was purchased just before the customer became a gold member?
- What is the total items and amount spent for each member before they became a member?
- If each 5Rs spent on Product1 equates to 1 Zomato point similarly Product2 provides 5 Zomato points on spending of 10Rs and Product3 has 1 Zomato Point for 5Rs - how many    points would each customer have?
- In the first one year after a customer joins the gold program (including their joining date) they earn 5 Zomato Points for every 10rs on all the items - How many points 
  customers have at the end of the First year
- Rank all the transactions of each customer.
- Business also requires further information about the ranking of products. they purposely does not need the ranking of non member purchases so they expects 'NA' ranking 
  values for customers who are not yet part of the gold program.

### Insights

- Customer 1 is the most frequent visitor with 7 visits.
- Product1 is the first product purchased by all the customers.
- Zomato’s most popular item is Product2, followed by Product1 and Product3.
- Customer 1 loves Product2, Customer 2 loves only Product3 whereas Customer 3 seems to enjoy Product2.
- The last item ordered by Customers 1 and 3 before they became members is Product2. 

