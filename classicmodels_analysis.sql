/* Analyse des ventes*/

/*CA de l'entreprise*/
SELECT
    SUM(quantityOrdered * priceEach) AS total_revenue
FROM
    classicmodels.orderdetails;

/* Meilleures ventes par catégorie de produits*/
SELECT
    productLine,
    SUM(quantityOrdered * priceEach) AS total_sales,
    COUNT(DISTINCT orderNumber) AS total_orders
FROM
    classicmodels.orders
JOIN
    classicmodels.orderdetails USING (orderNumber)
JOIN
    classicmodels.products USING (productCode)
GROUP BY
    productLine
ORDER BY
    total_sales DESC;

/* Répartition géographique des ventes*/
SELECT
    country,
    SUM(quantityOrdered * priceEach) AS total_sales
FROM
    classicmodels.customers
JOIN
    classicmodels.orders USING (customerNumber)
JOIN
    classicmodels.orderdetails USING (orderNumber)
GROUP BY
    country
ORDER BY
    total_sales DESC;

/* Nos points forts géographiques*/
SELECT
    country,
    SUM(quantityOrdered * priceEach) AS total_sales
FROM
    classicmodels.customers
JOIN
    classicmodels.orders USING (customerNumber)
JOIN
    classicmodels.orderdetails USING (orderNumber)
GROUP BY
    country
ORDER BY
    total_sales DESC
LIMIT 5;

/*  Nos points faibles géographiques*/
SELECT
    country,
    SUM(quantityOrdered * priceEach) AS total_sales
FROM
    classicmodels.customers
JOIN
    classicmodels.orders USING (customerNumber)
JOIN
    classicmodels.orderdetails USING (orderNumber)
GROUP BY
    country
ORDER BY
    total_sales ASC
LIMIT 5;

/*  Evolution des ventes dans nos points forts géographiques*/
SELECT
    country,
    YEAR(orderDate) AS year,
    SUM(quantityOrdered * priceEach) AS total_sales
FROM
    classicmodels.customers
JOIN
    classicmodels.orders USING (customerNumber)
JOIN
    classicmodels.orderdetails USING (orderNumber)
WHERE
    country IN ('USA', 'Spain', 'France', 'Australia', 'New Zealand')
GROUP BY
    country, year
ORDER BY
    country, year ASC;

/*  Evolution des ventes dans nos points faibles géographiques*/
SELECT
    country,
    YEAR(orderDate) AS year,
    SUM(quantityOrdered * priceEach) AS total_sales
FROM
    classicmodels.customers
JOIN
    classicmodels.orders USING (customerNumber)
JOIN
    classicmodels.orderdetails USING (orderNumber)
WHERE
    country IN ('Hong Kong', 'Ireland', 'Philippines', 'Belgium', 'Switzerland')
GROUP BY
    country, year
ORDER BY
    country, year ASC;

/* Tendance des ventes par trimestre*/
SELECT
    YEAR(orderDate) AS year,
    QUARTER(orderDate) AS quarter,
    SUM(quantityOrdered * priceEach) AS total_sales
FROM
    classicmodels.orders
JOIN
    classicmodels.orderdetails USING (orderNumber)
GROUP BY
    year, quarter
ORDER BY
    year, quarter ASC;

/* Ventes avec le moins de CA */
SELECT
    productLine,
    SUM(quantityOrdered * priceEach) AS total_sales
FROM
    classicmodels.orders
JOIN
    classicmodels.orderdetails USING (orderNumber)
JOIN
    classicmodels.products USING (productCode)
GROUP BY
    productLine
ORDER BY
    total_sales ASC
LIMIT 3;




/*  Analyse des clients*/

/* Les clients les plus rentables*/
SELECT
    customerName,
    country,
    SUM(amount) AS total_revenue
FROM
    classicmodels.payments
JOIN
    classicmodels.customers USING (customerNumber)
GROUP BY
    customerNumber
ORDER BY
    total_revenue DESC
LIMIT 10;

/* Meilleurs clients par panier moyen */
SELECT
    customerName,
    country,
    AVG(quantityOrdered * priceEach) AS avg_order_value
FROM
    classicmodels.customers
JOIN
    classicmodels.orders USING (customerNumber)
JOIN
    classicmodels.orderdetails USING (orderNumber)
GROUP BY
    customerName, country
ORDER BY
    avg_order_value DESC
LIMIT 10;

/*  Meilleurs clients par nombre de commandes*/
SELECT
    customerName,
    COUNT(orderNumber) AS total_orders
FROM
    classicmodels.customers
JOIN
    classicmodels.orders USING (customerNumber)
GROUP BY
    customerName
ORDER BY
    total_orders DESC
LIMIT 10;

/*  Marché potentiel : panier moyen par client, moins de client pour plus de revenu*/
SELECT
    country,
    COUNT(DISTINCT customerNumber) AS total_clients,
    SUM(amount) AS total_revenue,
    SUM(amount) / COUNT(DISTINCT customerNumber) AS avg_sales_per_client
FROM
    classicmodels.customers
JOIN
    classicmodels.payments USING (customerNumber)
GROUP BY
    country
ORDER BY
    avg_sales_per_client DESC, total_revenue DESC;




/* Analyse des produits*/

/*  Produits les plus rentables (marge bénéficiaire unitaire)*/
SELECT
    productLine,
    productCode,
    productname,
    (MSRP - buyPrice) AS profit_margin
FROM
    classicmodels.products
ORDER BY
    profit_margin DESC;

/*  Produits les moins rentables*/
SELECT
    productLine,
    productname,
    (MSRP - buyPrice) AS profit_margin
FROM
    classicmodels.products
ORDER BY
    profit_margin ASC
LIMIT 5;

/*  Top 10 des produits en CA*/
SELECT
    productLine,
    productName,
    SUM(od.quantityOrdered * od.priceEach) AS total_sales
FROM
    classicmodels.products
JOIN
    classicmodels.orderdetails od USING (productCode)
GROUP BY
    productLine, productCode, productName
ORDER BY
    total_sales DESC
LIMIT 10;

/*  Top 10 produits les plus vendus en quantité*/
SELECT
    productName,
    productline,
    SUM(quantityOrdered) AS total_quantity_sold
FROM
    classicmodels.products
JOIN
    classicmodels.orderdetails USING (productCode)
GROUP BY
    productCode, productName
ORDER BY
    total_quantity_sold DESC
LIMIT 10;

/*  Produits les plus rentables (cette fois par marge bénéficiaire TOTALE)*/
SELECT
    productline,
    productName,
    (MSRP - buyPrice) * SUM(quantityOrdered) AS total_profit
FROM
    classicmodels.products
JOIN
    classicmodels.orderdetails USING (productCode)
GROUP BY
    productCode
ORDER BY
    total_profit DESC
LIMIT 5;

/* Produits les moins rentables*/
SELECT
    productline,
    productName,
    (MSRP - buyPrice) * SUM(quantityOrdered) AS total_profit
FROM
    classicmodels.products
JOIN
    classicmodels.orderdetails USING (productCode)
GROUP BY
    productCode
ORDER BY
    total_profit ASC
LIMIT 5;

/*  Catégories de produits avec la meilleure performance en stock*/
SELECT
    productLine,
    SUM(quantityOrdered) / SUM(quantityInStock) AS sales_to_stock_ratio
FROM
    classicmodels.products
JOIN
    classicmodels.orderdetails USING (productCode)
GROUP BY
    productLine
ORDER BY
    sales_to_stock_ratio DESC;

/*  Produits en rupture de stock potentielle*/
SELECT
    productline,
    productName,
    quantityInStock,
    SUM(quantityOrdered) AS recent_orders
FROM
    classicmodels.products
LEFT JOIN
    classicmodels.orderdetails USING (productCode)
GROUP BY productCode
HAVING quantityInStock < SUM(quantityOrdered)
ORDER BY quantityInStock ASC;

/* Surproduction/ produits sous-performants*/
SELECT
    productName,
    quantityInStock,
    SUM(quantityOrdered) AS total_sold,
    (quantityInStock - SUM(quantityOrdered)) AS stock_left
FROM
    classicmodels.products
JOIN
    classicmodels.orderdetails USING (productCode)
GROUP BY
    productName, productLine, quantityInStock
ORDER BY
    stock_left DESC;

/* Top 5 des produits les plus achetés notre top 3 clients*/

WITH ProductRanking AS (
    SELECT 
        customerName,
        productCode,
        productName,
        SUM(od.quantityOrdered) AS total_quantity_ordered,
        RANK() OVER (PARTITION BY c.customerName ORDER BY SUM(od.quantityOrdered) DESC) AS ranking
    FROM 
        classicmodels.customers c
    JOIN 
        classicmodels.orders o USING (customerNumber)
    JOIN 
        classicmodels.orderdetails od USING (orderNumber)
    JOIN 
        classicmodels.products p USING (productCode)
    WHERE 
        customerName IN ('Euro+ Shopping Channel', 'Mini Gifts Distributors Ltd.', 'Australian Collectors, Co.')
    GROUP BY 
        customerName, productCode, productName
)
SELECT 
    customerName,
    productCode,
    productName,
    total_quantity_ordered
FROM 
    ProductRanking
WHERE 
    ranking <= 5
ORDER BY 
    customerName, ranking;


/*  Analyse des employés*/

/* Meilleurs employés par nombre de commandes*/
SELECT
    employeeNumber,
    CONCAT(firstName, ' ', lastName) AS employee_name,
    COUNT(o.orderNumber) AS total_orders
FROM
    classicmodels.employees
JOIN
    classicmodels.customers c ON employeeNumber = salesRepEmployeeNumber
JOIN
    classicmodels.orders o ON c.customerNumber = o.customerNumber
GROUP BY
    employeeNumber, employee_name
ORDER BY
    total_orders DESC;

/* CA par employé*/
SELECT
    employeeNumber,
    CONCAT(firstName, ' ', lastName) AS employee_name,
    SUM(amount) AS total_sales
FROM
    classicmodels.employees
JOIN
    classicmodels.customers c ON employeeNumber = salesRepEmployeeNumber
JOIN
    classicmodels.payments p ON c.customerNumber = p.customerNumber
GROUP BY
    employeeNumber, employee_name
ORDER BY
    total_sales DESC;

/* Nombre de clients gérés par employés*/
SELECT
    employeeNumber,
    CONCAT(firstName, ' ', lastName) AS employee_name,
    COUNT(customerNumber) AS total_clients
FROM
    classicmodels.employees
JOIN
    classicmodels.customers ON employeeNumber = salesRepEmployeeNumber
GROUP BY
    employeeNumber, employee_name
ORDER BY
    total_clients DESC;
	
