# Olist E-commerce Project

## 1. Project Overview

### Context

Founded in 2015, Olist is an e-commerce platform that connects small and medium-sized businesses to customers. The platform operates as a marketplace, where merchants can list their products and services and customers can browse and purchase them online. 

The Olist solution is a link between brands and the public, with the aim of simplifying the process with the marketplaces and the communication with the sales channels. A platform that guarantees the management of the entire process, from multiple sales channels, orders placed, items in stock, product portfolio, shipping, messages and comments in an integrated way.

### Goal

- **Sales dashboard:** to provide a detailed and timely overview of key sales metrics on a monthly basis, facilitating informed decision-making and tactical adjustments.
- **Customer dashboard:** to provide a comprehensive view of customer metrics and behavior on a monthly basis, enabling data-driven marketing strategies and campaign optimization.
- **Delivery dashboard:**  to provide a detailed and actionable view of delivery performance metrics on a monthly basis, enabling efficient management of logistics and operational processes.

## 2. Dataset Structure

The dataset has information of 100k orders from 2016 to 2018 made at multiple marketplaces in Brazil. Its features allows viewing an order from multiple dimensions: from order status, price, payment and freight performance to customer location, product attributes and finally reviews written by customers.

This dataset consisted of  9 tables can be found [here](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce). Data dictionary can be found [here](https://github.com/nguyenkimhang1206/Olist-E-commerce/blob/main/Data%20Dictionary%20of%20Olist%20E-commerce.xlsx).

![image](https://github.com/user-attachments/assets/4b2d5889-1007-46f0-bbad-312704476640)

## 3. Sales Dashboard Insights Summary

The dashboard can be found [here](https://app.powerbi.com/view?r=eyJrIjoiZDcwYzk5ZDEtMGNlNS00NGU0LTljZjYtMGY2MzNiYzJiMjBkIiwidCI6ImFmZTAyN2Y5LWIxYmMtNGY4ZS05MjdlLTI5YjNiNjFkOWRhNCIsImMiOjEwfQ%3D%3D). This dashboard enables users to filter by payment, product, state, and time, and focuses on trends and values in following key metrics: Total Orders, Gross Revenue, Average Order Value (AOV), Average Basket Size, and Order Cancellation Rate.

![image](https://github.com/user-attachments/assets/995788a3-6cf1-4135-bd79-e37405167227)


**Sales Performance**

- **Trend Analysis**: Evaluate how Total Orders and Gross Revenue have changed compared to previous month. This helps identify growth trends or declines in sales performance.
- **Day of Week**: Identify which days have the highest and lowest Total Orders and Gross Revenue. This can help optimize staffing, promotional efforts, and inventory levels for peak days.
- **Hour of Day**: Determine peak shopping hours. This can assist in scheduling promotions and improving website performance during high-traffic times.

**Customer Behavior**

- **Average Order Value (AOV)**: Analyze how AOV change over time. A rising AOV suggests that customers are spending more per transaction, while a declining AOV could indicate reduced spending or promotions affecting spending behavior. Consider strategies to boost AOV, such as bundling products, offering discounts on higher-value orders, or implementing loyalty programs.
- **Average Basket Size**: Assess changes in Average Basket Size to understand if customers are buying more items per order. This can indicate whether your cross-selling strategies are effective.
- **Payment Method**: Analyze the distribution of payment types. If a particular payment method dominates, consider enhancing support and promotions for less popular methods to improve their adoption.

**Order Fulfillment Efficiency**

- **Order Cancellation Rate**: Investigate why cancellations are high during specific times, product category or regions and address these issues. High cancellation rates may indicate issues with order fulfillment, customer satisfaction, or potential problems with the purchasing process.

## 4. Customer Dashboard Insights Summary

The dashboard can be found [here.](https://app.powerbi.com/view?r=eyJrIjoiZDcwYzk5ZDEtMGNlNS00NGU0LTljZjYtMGY2MzNiYzJiMjBkIiwidCI6ImFmZTAyN2Y5LWIxYmMtNGY4ZS05MjdlLTI5YjNiNjFkOWRhNCIsImMiOjEwfQ==) This dashboard enables users to filter by product, state, and time, and focuses on trends and values in following key metrics: Total Customers, New Customers, Repeat Customer Rate, Revenue per Customer, Average Purchase Frequency, Average Review Score

![image](https://github.com/user-attachments/assets/27723106-436b-449e-85a0-1f1e1c4dd2e8)

**Customer Segmentation**

- **New vs. Repeat Customers**: Analyze the proportion of new versus repeat customers. A higher proportion of repeat customers may indicate strong customer loyalty and successful retention strategies. Conversely, a higher proportion of new customers might suggest a need for improved retention strategies.

**Customer Behavior** 

- **Purchase Frequency by Repeat Customers**: Examine how often repeat customers make purchases. High frequency can indicate strong customer engagement, while low frequency might suggest opportunities for increasing purchase frequency through targeted campaigns, promotions or loyalty program.

**Revenue Insights**

- **Average Revenue per Customer**: Compare the average revenue per customer for new versus repeat customers. This helps identify which group generates more revenue and informs strategies to increase revenue from both groups.

**Customer Satisfaction**

- **Review Score Distribution**: Assess the overall distribution of review scores to gauge general customer satisfaction. Identify if most reviews are positive, negative, or neutral, and investigate common themes in reviews.

## 5. Delivery Dashboard Insights Summary

The dashboard can be found [here.](https://app.powerbi.com/view?r=eyJrIjoiZDcwYzk5ZDEtMGNlNS00NGU0LTljZjYtMGY2MzNiYzJiMjBkIiwidCI6ImFmZTAyN2Y5LWIxYmMtNGY4ZS05MjdlLTI5YjNiNjFkOWRhNCIsImMiOjEwfQ==) This dashboard enables users to filter by payment, product, state, and time, and focuses on trends and values in following key metrics: Total Orders, Order Fulfillment Rate, Average Delivery Time, On-Time Delivery Rate, Late Delivery Rate

![image](https://github.com/user-attachments/assets/6eaf6192-3ec0-4b28-ab3a-05738edbc19b)

**Delivery Performance**

- **Order Fulfillment Rate**: Evaluate the proportion of orders fulfilled within the specific time. A high fulfillment rate indicates efficient operations, while a low rate may signal issues.
- **On-time vs. Late Delivery Rate**: Determine the percentage of on-time deliveries versus late deliveries. This helps assess overall delivery performance and identify areas needing improvement.

**Delivery Time Analysis**

- **Delivery Time Distribution**: Analyze the distribution of delivery times to understand how long it typically takes to deliver orders. Identify any patterns that could indicate operational inefficiencies.
- **Delivery Time Variance Distribution**: Compare actual delivery times against estimated delivery times. High variance indicates discrepancies between expected and actual delivery times, potentially leading to customer dissatisfaction. Reduce the variance between estimated and actual delivery times by improving forecasting accuracy and operational efficiency.

**On-time vs. Late Delivery Analysis**

- **On-time vs. Late Delivery by Stage**: Examine average times for different stages (approval, processing, shipping) and their impact on on-time and late deliveries. This helps identify issues in the entire delivery process.
- **On-time vs. Late Delivery by Product Category**: Identify which product categories have higher on-time and late delivery rates. This can reveal if certain categories face more logistical challenges (e.g., packaging, handling) or delays.

**Regional Delivery Performance**

- **State Analysis**: Review delivery metrics by state to identify regional performance differences. This helps pinpoint areas with higher or lower delivery performance and adjust strategies accordingly. For regions with higher late delivery rates, enhance logistical support, improve local partnerships, or optimize delivery routes.

## 6. Appendix

### Technical Process

Dataset stats:

- 100k orders from made at multiple marketplaces in Brazil.
- Data ranges from 2016 to 2018

The technical process included:

- Cleaning, preparing and exploring the data in PostgreSQL
- Calculating metrics in DAX
- Building dashboards in PowerBI

### Sales Dashboard Key Metrics

The sales dashboard focuses on the following key metrics:

- **Total Orders**: The total number of individual purchase transactions completed within a specific period.
- **Gross Revenue**: The total amount of money generated from sales before any deductions like discounts, returns, cancellation or taxes.
- **Average Order Value (AOV)**: The average amount spent per transaction.
- **Average Basket Size**: The average number of items purchased per order.
- **Order Cancellation Rate**: The percentage of orders that are canceled compared to the total number of orders placed.

### Customer Dashboard Key Metrics

The customer dashboard focuses on the following key metrics:

- **Total Customers**: The total number of unique individuals who have made at least one purchase from your e-commerce store within a specified period.
- **New Customers**: The number of unique individuals who made their first purchase within a specific time frame.
- **Repeat Customer Rate**: The percentage of customers who make more than one purchase within a specified period.
- **Revenue per Customer**: The average revenue generated from each customer over a specified period. It reflects how much value each customer brings to your business.
- **Average Purchase Frequency**: The average number of purchases made by each customer within a specific period.
- **Average Review Score**: The average rating given by customers on their purchases,  on a scale from 1 to 5 stars.

### Delivery Dashboard Key Metrics

- **Total Orders**: The total number of orders placed by customers within a specified period.
- **Order Fulfillment Rate**: The percentage of orders that are successfully fulfilled and shipped according to the original order details within a given time frame.
- **Average Delivery Time**: The average amount of time taken from when an order is placed to when it is delivered to the customer.
- **On-Time Delivery Rate**: The percentage of orders that are delivered by the promised or expected delivery date.
- **Late Delivery Rate**: The percentage of orders that are delivered after the promised or expected delivery date. This metric highlights issues with delays in the delivery process and its impact on customer satisfaction

