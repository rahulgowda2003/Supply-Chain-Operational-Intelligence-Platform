/*
=============================================================
Create Database and Schemas
=============================================================
Purpose:
    Creates the SupplyChainAnalytics database
    and gold schema for reporting tables.
=============================================================
*/

USE master;
GO

--drop database if exists
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'SupplyChainAnalytics')
BEGIN
    ALTER DATABASE SupplyChainAnalytics
    SET SINGLE_USER
    WITH ROLLBACK IMMEDIATE;

    DROP DATABASE SupplyChainAnalytics;
END;
GO

--create database
CREATE DATABASE SupplyChainAnalytics;
GO

USE SupplyChainAnalytics;
GO

--create schema
CREATE SCHEMA gold;
GO

/*
=============================================================
Create Dimension Tables
=============================================================
*/


--dim_customers
CREATE TABLE gold.dim_customers (
customer_id                     NVARCHAR(50),
customer_fname                  NVARCHAR(100),
customer_lname                  NVARCHAR(100),
customer_email                  NVARCHAR(255),
customer_password               NVARCHAR(255),
customer_segment                NVARCHAR(100),
customer_city                   NVARCHAR(100),
customer_state                  NVARCHAR(100),
customer_country                NVARCHAR(100),
customer_street                 NVARCHAR(255),
customer_zipcode                NVARCHAR(50),
latitude                        FLOAT NULL,
longitude                       FLOAT NULL
);


--dim_products
CREATE TABLE gold.dim_products (
product_card_id                 INT,
product_category_id             INT,
category_id                     INT,
category_name                   NVARCHAR(255),
department_id                   INT,
department_name                 NVARCHAR(255),
product_image                   NVARCHAR(MAX),
product_name                    NVARCHAR(255),
product_price                   DECIMAL(12,2),
product_status                  NVARCHAR(100)
);


--dim_departments
CREATE TABLE gold.dim_departments (
department_id                   INT,
department_name                 NVARCHAR(255)
);


--dim_shipping
CREATE TABLE gold.dim_shipping (
shipping_mode                   NVARCHAR(100),
delivery_status                 NVARCHAR(100),
late_delivery_risk              INT,
days_for_shipping_real          INT,
days_for_shipment_scheduled     INT
);


/*************************************************************
Fact Table
*************************************************************/


--fact_orders
CREATE TABLE gold.fact_orders (
type                            NVARCHAR(255),
order_id                        NVARCHAR(255),
order_customer_id               NVARCHAR(255),
order_item_id                   NVARCHAR(255),
order_date                      NVARCHAR(255),
shipping_date                   NVARCHAR(255),
order_city                      NVARCHAR(255),
order_country                   NVARCHAR(255),
order_region                    NVARCHAR(255),
order_state                     NVARCHAR(255),
market                          NVARCHAR(255),
customer_id                     NVARCHAR(255),
product_card_id                 NVARCHAR(255),
sales                           NVARCHAR(255),
benefit_per_order               NVARCHAR(255),
order_item_discount             NVARCHAR(255),
order_item_discount_rate        NVARCHAR(255),
order_item_product_price        NVARCHAR(255),
order_item_profit_ratio         NVARCHAR(255),
order_profit_per_order          NVARCHAR(255),
order_item_quantity             NVARCHAR(255),
order_item_total                NVARCHAR(255),
order_status                    NVARCHAR(255),
shipping_mode                   NVARCHAR(255),
delivery_status                 NVARCHAR(255),
days_for_shipping_real          NVARCHAR(255),
days_for_shipment_scheduled     NVARCHAR(255),
late_delivery_risk              NVARCHAR(255)
);


--description_supplychain
CREATE TABLE gold.description_supplychain (
fields                          NVARCHAR(255),                            
description                     NVARCHAR(500)
);


--tokenized_access_logs
CREATE TABLE gold.tokenized_access_logs (
product         NVARCHAR(255),
category        NVARCHAR(255),
log_date        NVARCHAR(255),
log_month       NVARCHAR(50),
log_hour        NVARCHAR(50),
department      NVARCHAR(255),
ip_address      NVARCHAR(100),
url_path        NVARCHAR(MAX)
);


/*
=============================================================
Bulk Insert Data
=============================================================
*/


--dim_customers
TRUNCATE TABLE gold.dim_customers;
GO

BULK INSERT gold.dim_customers
FROM 'D:\Data Analysis\Projects\Supply Chain & Operational Intelligence Platform\Data\gold.dim_customers.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);


--dim_products
TRUNCATE TABLE gold.dim_products;
GO

BULK INSERT gold.dim_products
FROM 'D:\Data Analysis\Projects\Supply Chain & Operational Intelligence Platform\Data\gold.dim_products.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);


--dim_departments
TRUNCATE TABLE gold.dim_departments;
GO

BULK INSERT gold.dim_departments
FROM 'D:\Data Analysis\Projects\Supply Chain & Operational Intelligence Platform\Data\gold.dim_departments.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);


--dim_shipping
TRUNCATE TABLE gold.dim_shipping;
GO

BULK INSERT gold.dim_shipping
FROM 'D:\Data Analysis\Projects\Supply Chain & Operational Intelligence Platform\Data\gold.dim_shipping.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
GO


--fact_orders
TRUNCATE TABLE gold.fact_orders;
GO

BULK INSERT gold.fact_orders
FROM 'D:\Data Analysis\Projects\Supply Chain & Operational Intelligence Platform\Data\gold.fact_orders.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
GO

--description_supplychain
TRUNCATE TABLE gold.description_supplychain;
GO

BULK INSERT gold.description_supplychain
FROM 'D:\Data Analysis\Projects\Supply Chain & Operational Intelligence Platform\Data\DescriptionDataCoSupplyChain.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
GO

--tokenized access logs
TRUNCATE TABLE gold.tokenized_access_logs;
GO

BULK INSERT gold.tokenized_access_logs
FROM 'D:\Data Analysis\Projects\Supply Chain & Operational Intelligence Platform\Data\tokenized_access_logs.csv'
WITH (

    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    CODEPAGE = '65001'

);
GO