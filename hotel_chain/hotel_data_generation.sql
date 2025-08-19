-- Hotel Chain - Synthetic Data Generation Script
-- This script generates realistic test data for the hotel sales and revenue management system
-- Run this after executing the DDL script

USE DATABASE HOTEL_CHAIN;
USE SCHEMA SALES_REVENUE;

-- 1. INSERT HOTELS DATA
-- Major hotel properties across different regions and market segments
INSERT INTO HOTELS VALUES
-- Americas - Luxury/Premium
('HTL001', 'Grand Hotel New York', 'Grand', 'New York', 'NY', 'USA', 'Americas', 'Luxury', 1298, '1980-09-30', '2019-03-15', 'Urban', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
('HTL002', 'Park Hotel Chicago', 'Park', 'Chicago', 'IL', 'USA', 'Americas', 'Luxury', 198, '2000-08-15', '2020-01-10', 'Urban', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
('HTL003', 'Regency Hotel Miami', 'Regency', 'Miami', 'FL', 'USA', 'Americas', 'Premium', 612, '1982-11-20', '2018-06-20', 'Urban', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
('HTL004', 'Grand Hotel San Francisco', 'Grand', 'San Francisco', 'CA', 'USA', 'Americas', 'Luxury', 659, '1972-04-12', '2017-09-30', 'Urban', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
('HTL005', 'Regency Resort Maui', 'Regency', 'Lahaina', 'HI', 'USA', 'Americas', 'Premium', 806, '1980-10-01', '2021-05-15', 'Resort', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
('HTL006', 'Centric Hotel Times Square', 'Centric', 'New York', 'NY', 'USA', 'Americas', 'Select', 487, '2018-06-21', NULL, 'Urban', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
('HTL007', 'Extended Stay Dallas', 'Extended Stay', 'Dallas', 'TX', 'USA', 'Americas', 'Select', 150, '2019-03-10', NULL, 'Urban', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
('HTL008', 'Grand Hotel Washington', 'Grand', 'Washington', 'DC', 'USA', 'Americas', 'Luxury', 888, '1987-02-14', '2020-11-05', 'Urban', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
('HTL009', 'Regency Hotel Vancouver', 'Regency', 'Vancouver', 'BC', 'Canada', 'Americas', 'Premium', 644, '1973-05-25', '2019-08-12', 'Urban', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
('HTL010', 'Grand Hotel Rio de Janeiro', 'Grand', 'Rio de Janeiro', 'RJ', 'Brazil', 'Americas', 'Luxury', 436, '2016-07-12', NULL, 'Urban', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),

-- ASPAC - Asia Pacific
('HTL011', 'Park Hotel Tokyo', 'Park', 'Tokyo', 'Tokyo', 'Japan', 'ASPAC', 'Luxury', 177, '1994-10-14', '2020-02-28', 'Urban', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
('HTL012', 'Grand Hotel Hong Kong', 'Grand', 'Hong Kong', 'Hong Kong', 'Hong Kong', 'ASPAC', 'Luxury', 542, '1989-08-01', '2018-12-10', 'Urban', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
('HTL013', 'Regency Hotel Sydney', 'Regency', 'Sydney', 'NSW', 'Australia', 'ASPAC', 'Premium', 892, '1990-03-15', '2019-07-22', 'Urban', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
('HTL014', 'Park Hotel Shanghai', 'Park', 'Shanghai', 'Shanghai', 'China', 'ASPAC', 'Luxury', 174, '2009-09-18', '2021-04-08', 'Urban', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
('HTL015', 'Regency Resort Bali', 'Regency', 'Sanur', 'Bali', 'Indonesia', 'ASPAC', 'Premium', 363, '1973-12-15', '2020-09-14', 'Resort', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
('HTL016', 'Grand Hotel Singapore', 'Grand', 'Singapore', 'Singapore', 'Singapore', 'ASPAC', 'Luxury', 677, '1982-04-30', '2018-11-20', 'Urban', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
('HTL017', 'Regency Hotel Bangkok', 'Regency', 'Bangkok', 'Bangkok', 'Thailand', 'ASPAC', 'Premium', 671, '1967-12-12', '2017-05-30', 'Urban', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
('HTL018', 'Park Hotel Seoul', 'Park', 'Seoul', 'Seoul', 'South Korea', 'ASPAC', 'Luxury', 185, '2005-02-28', '2021-01-15', 'Urban', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),

-- EAME - Europe, Africa, Middle East
('HTL019', 'Park Hotel Paris-Vendôme', 'Park', 'Paris', 'Île-de-France', 'France', 'EAME', 'Luxury', 153, '2002-09-20', '2020-03-10', 'Urban', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
('HTL020', 'Grand Hotel Berlin', 'Grand', 'Berlin', 'Berlin', 'Germany', 'EAME', 'Luxury', 342, '1998-10-08', '2019-06-25', 'Urban', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
('HTL021', 'Regency Hotel London', 'Regency', 'London', 'England', 'United Kingdom', 'EAME', 'Premium', 411, '1993-11-12', '2018-09-18', 'Urban', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
('HTL022', 'Park Hotel Dubai', 'Park', 'Dubai', 'Dubai', 'UAE', 'EAME', 'Luxury', 223, '2008-05-15', '2021-02-20', 'Urban', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
('HTL023', 'Regency Hotel Casablanca', 'Regency', 'Casablanca', 'Casablanca', 'Morocco', 'EAME', 'Premium', 255, '2014-04-18', NULL, 'Urban', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
('HTL024', 'Grand Hotel Athens', 'Grand', 'Athens', 'Attica', 'Greece', 'EAME', 'Luxury', 309, '2018-12-01', NULL, 'Urban', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
('HTL025', 'Regency Hotel Kiev', 'Regency', 'Kiev', 'Kiev', 'Ukraine', 'EAME', 'Premium', 234, '2017-08-20', NULL, 'Urban', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP());

-- 2. INSERT ROOM TYPES
INSERT INTO ROOM_TYPES VALUES
('RT001', 'Standard King', 'Standard', 2, 2, 350, 'Basic', CURRENT_TIMESTAMP()),
('RT002', 'Standard Double', 'Standard', 2, 4, 380, 'Basic', CURRENT_TIMESTAMP()),
('RT003', 'Deluxe King', 'Premium', 2, 2, 420, 'Enhanced', CURRENT_TIMESTAMP()),
('RT004', 'Deluxe Double', 'Premium', 2, 4, 450, 'Enhanced', CURRENT_TIMESTAMP()),
('RT005', 'Executive King', 'Premium', 2, 2, 480, 'Enhanced', CURRENT_TIMESTAMP()),
('RT006', 'Junior Suite', 'Suite', 2, 3, 650, 'Luxury', CURRENT_TIMESTAMP()),
('RT007', 'One Bedroom Suite', 'Suite', 2, 4, 850, 'Luxury', CURRENT_TIMESTAMP()),
('RT008', 'Presidential Suite', 'Suite', 4, 6, 1500, 'Luxury', CURRENT_TIMESTAMP()),
('RT009', 'Club King', 'Premium', 2, 2, 400, 'Enhanced', CURRENT_TIMESTAMP()),
('RT010', 'Resort Villa', 'Suite', 4, 8, 1200, 'Luxury', CURRENT_TIMESTAMP());

-- 3. INSERT ANCILLARY SERVICES
INSERT INTO ANCILLARY_SERVICES VALUES
('SVC001', 'Valet Parking', 'Transportation', 'Parking', 45.00, TRUE, FALSE, CURRENT_TIMESTAMP()),
('SVC002', 'Self Parking', 'Transportation', 'Parking', 25.00, TRUE, FALSE, CURRENT_TIMESTAMP()),
('SVC003', 'Airport Transfer', 'Transportation', 'Transfer', 85.00, TRUE, TRUE, CURRENT_TIMESTAMP()),
('SVC004', 'Premium WiFi', 'Business', 'Internet', 15.00, TRUE, FALSE, CURRENT_TIMESTAMP()),
('SVC005', 'Spa Treatment - Massage', 'Spa', 'Wellness', 180.00, TRUE, TRUE, CURRENT_TIMESTAMP()),
('SVC006', 'Spa Treatment - Facial', 'Spa', 'Wellness', 150.00, TRUE, TRUE, CURRENT_TIMESTAMP()),
('SVC007', 'Room Service', 'F&B', 'Dining', 35.00, TRUE, FALSE, CURRENT_TIMESTAMP()),
('SVC008', 'Minibar', 'F&B', 'Beverage', 25.00, TRUE, FALSE, CURRENT_TIMESTAMP()),
('SVC009', 'Laundry Service', 'Business', 'Laundry', 28.00, TRUE, FALSE, CURRENT_TIMESTAMP()),
('SVC010', 'Business Center', 'Business', 'Office', 20.00, TRUE, FALSE, CURRENT_TIMESTAMP()),
('SVC011', 'Fitness Center Access', 'Recreation', 'Fitness', 0.00, FALSE, FALSE, CURRENT_TIMESTAMP()),
('SVC012', 'Pool Cabana Rental', 'Recreation', 'Pool', 125.00, TRUE, TRUE, CURRENT_TIMESTAMP()),
('SVC013', 'Late Checkout', 'Business', 'Service', 50.00, TRUE, FALSE, CURRENT_TIMESTAMP()),
('SVC014', 'Pet Fee', 'Business', 'Service', 75.00, TRUE, FALSE, CURRENT_TIMESTAMP()),
('SVC015', 'Resort Fee', 'Business', 'Service', 35.00, TRUE, FALSE, CURRENT_TIMESTAMP());

-- 4. GENERATE CUSTOMERS DATA
-- Create a sequence for customer IDs
CREATE OR REPLACE SEQUENCE CUSTOMER_SEQ START = 1 INCREMENT = 1;

-- Generate 5000 customers
INSERT INTO CUSTOMERS 
SELECT 
    'CUST' || LPAD(CUSTOMER_SEQ.NEXTVAL, 6, '0'),
    CASE (UNIFORM(1, 50, RANDOM()) % 25)
        WHEN 1 THEN 'James' WHEN 2 THEN 'Mary' WHEN 3 THEN 'John' WHEN 4 THEN 'Patricia'
        WHEN 5 THEN 'Robert' WHEN 6 THEN 'Jennifer' WHEN 7 THEN 'Michael' WHEN 8 THEN 'Linda'
        WHEN 9 THEN 'William' WHEN 10 THEN 'Elizabeth' WHEN 11 THEN 'David' WHEN 12 THEN 'Barbara'
        WHEN 13 THEN 'Richard' WHEN 14 THEN 'Susan' WHEN 15 THEN 'Joseph' WHEN 16 THEN 'Jessica'
        WHEN 17 THEN 'Thomas' WHEN 18 THEN 'Sarah' WHEN 19 THEN 'Christopher' WHEN 20 THEN 'Karen'
        WHEN 21 THEN 'Charles' WHEN 22 THEN 'Nancy' WHEN 23 THEN 'Daniel' WHEN 24 THEN 'Lisa'
        ELSE 'Matthew'
    END,
    CASE (UNIFORM(1, 50, RANDOM()) % 25)
        WHEN 1 THEN 'Smith' WHEN 2 THEN 'Johnson' WHEN 3 THEN 'Williams' WHEN 4 THEN 'Brown'
        WHEN 5 THEN 'Jones' WHEN 6 THEN 'Garcia' WHEN 7 THEN 'Miller' WHEN 8 THEN 'Davis'
        WHEN 9 THEN 'Rodriguez' WHEN 10 THEN 'Martinez' WHEN 11 THEN 'Hernandez' WHEN 12 THEN 'Lopez'
        WHEN 13 THEN 'Gonzalez' WHEN 14 THEN 'Wilson' WHEN 15 THEN 'Anderson' WHEN 16 THEN 'Thomas'
        WHEN 17 THEN 'Taylor' WHEN 18 THEN 'Moore' WHEN 19 THEN 'Jackson' WHEN 20 THEN 'Martin'
        WHEN 21 THEN 'Lee' WHEN 22 THEN 'Perez' WHEN 23 THEN 'Thompson' WHEN 24 THEN 'White'
        ELSE 'Harris'
    END,
    'customer' || CUSTOMER_SEQ.CURRVAL || '@email.com',
    '+1' || (UNIFORM(200, 999, RANDOM())) || (UNIFORM(100, 999, RANDOM())) || (UNIFORM(1000, 9999, RANDOM())),
    CASE (UNIFORM(1, 100, RANDOM()) % 4)
        WHEN 0 THEN 'Bronze'
        WHEN 1 THEN 'Silver' 
        WHEN 2 THEN 'Gold'
        ELSE 'Platinum'
    END,
    UNIFORM(0, 150000, RANDOM()),
    DATEADD(day, -UNIFORM(30, 3650, RANDOM()), CURRENT_DATE()),
    DATEADD(day, -UNIFORM(7300, 25550, RANDOM()), CURRENT_DATE()),
    CASE (UNIFORM(1, 10, RANDOM()) % 3) WHEN 0 THEN 'M' WHEN 1 THEN 'F' ELSE 'Other' END,
    CASE (UNIFORM(1, 20, RANDOM()) % 10)
        WHEN 0 THEN 'USA' WHEN 1 THEN 'Canada' WHEN 2 THEN 'UK' WHEN 3 THEN 'Germany'
        WHEN 4 THEN 'France' WHEN 5 THEN 'Japan' WHEN 6 THEN 'Australia' WHEN 7 THEN 'China'
        WHEN 8 THEN 'Brazil' ELSE 'Mexico'
    END,
    'English',
    CASE WHEN UNIFORM(1, 10, RANDOM()) <= 7 THEN TRUE ELSE FALSE END,
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM TABLE(GENERATOR(ROWCOUNT => 5000));

-- 5. GENERATE CORPORATE ACCOUNTS
INSERT INTO CORPORATE_ACCOUNTS VALUES
('CORP001', 'Microsoft Corporation', 'Technology', 'Sarah Johnson', 'Corporate Rate', 15.00, 5000, '2023-01-01', '2024-12-31', 'Active', CURRENT_TIMESTAMP()),
('CORP002', 'Goldman Sachs Group', 'Financial Services', 'Michael Chen', 'Corporate Rate', 20.00, 8000, '2023-01-01', '2024-12-31', 'Active', CURRENT_TIMESTAMP()),
('CORP003', 'Deloitte Consulting', 'Professional Services', 'Emily Rodriguez', 'Group Block', 18.00, 12000, '2023-01-01', '2024-12-31', 'Active', CURRENT_TIMESTAMP()),
('CORP004', 'JPMorgan Chase', 'Financial Services', 'David Wilson', 'Corporate Rate', 22.00, 6500, '2023-01-01', '2024-12-31', 'Active', CURRENT_TIMESTAMP()),
('CORP005', 'Amazon Web Services', 'Technology', 'Lisa Thompson', 'Corporate Rate', 25.00, 15000, '2023-01-01', '2024-12-31', 'Active', CURRENT_TIMESTAMP()),
('CORP006', 'McKinsey & Company', 'Professional Services', 'Robert Kim', 'Group Block', 20.00, 9000, '2023-01-01', '2024-12-31', 'Active', CURRENT_TIMESTAMP()),
('CORP007', 'Accenture', 'Professional Services', 'Jennifer Davis', 'Corporate Rate', 16.00, 7500, '2023-01-01', '2024-12-31', 'Active', CURRENT_TIMESTAMP()),
('CORP008', 'IBM Corporation', 'Technology', 'Mark Anderson', 'Corporate Rate', 18.00, 4500, '2023-01-01', '2024-12-31', 'Active', CURRENT_TIMESTAMP()),
('CORP009', 'ExxonMobil', 'Energy', 'Amanda Martinez', 'Corporate Rate', 12.00, 3000, '2023-01-01', '2024-12-31', 'Active', CURRENT_TIMESTAMP()),
('CORP010', 'Boston Consulting Group', 'Professional Services', 'Kevin Lee', 'Group Block', 25.00, 8500, '2023-01-01', '2024-12-31', 'Active', CURRENT_TIMESTAMP());

-- 6. GENERATE HOTEL ROOM INVENTORY
-- For each hotel, assign room counts by room type
INSERT INTO HOTEL_ROOM_INVENTORY 
SELECT 
    h.HOTEL_ID,
    rt.ROOM_TYPE_ID,
    CASE 
        WHEN rt.ROOM_TYPE_ID = 'RT001' THEN ROUND(h.TOTAL_ROOMS * 0.35) -- Standard King 35%
        WHEN rt.ROOM_TYPE_ID = 'RT002' THEN ROUND(h.TOTAL_ROOMS * 0.25) -- Standard Double 25%
        WHEN rt.ROOM_TYPE_ID = 'RT003' THEN ROUND(h.TOTAL_ROOMS * 0.15) -- Deluxe King 15%
        WHEN rt.ROOM_TYPE_ID = 'RT004' THEN ROUND(h.TOTAL_ROOMS * 0.10) -- Deluxe Double 10%
        WHEN rt.ROOM_TYPE_ID = 'RT005' THEN ROUND(h.TOTAL_ROOMS * 0.08) -- Executive King 8%
        WHEN rt.ROOM_TYPE_ID = 'RT006' THEN ROUND(h.TOTAL_ROOMS * 0.04) -- Junior Suite 4%
        WHEN rt.ROOM_TYPE_ID = 'RT007' THEN ROUND(h.TOTAL_ROOMS * 0.02) -- One Bedroom Suite 2%
        WHEN rt.ROOM_TYPE_ID = 'RT008' THEN 1 -- Presidential Suite 1 per hotel
        ELSE 0
    END,
    CURRENT_TIMESTAMP()
FROM HOTELS h
CROSS JOIN ROOM_TYPES rt
WHERE rt.ROOM_TYPE_ID IN ('RT001', 'RT002', 'RT003', 'RT004', 'RT005', 'RT006', 'RT007', 'RT008');

-- 7. GENERATE EVENTS CALENDAR
INSERT INTO EVENTS_CALENDAR VALUES
('EVT001', 'Consumer Electronics Show', 'Convention', 'Las Vegas', '2024-01-09', '2024-01-12', 180000, 'Extreme', CURRENT_TIMESTAMP()),
('EVT002', 'Mobile World Congress', 'Convention', 'Barcelona', '2024-02-26', '2024-02-29', 100000, 'High', CURRENT_TIMESTAMP()),
('EVT003', 'South by Southwest', 'Festival', 'Austin', '2024-03-08', '2024-03-17', 400000, 'Extreme', CURRENT_TIMESTAMP()),
('EVT004', 'Cannes Film Festival', 'Festival', 'Cannes', '2024-05-14', '2024-05-25', 45000, 'High', CURRENT_TIMESTAMP()),
('EVT005', 'Olympic Games', 'Sports', 'Paris', '2024-07-26', '2024-08-11', 15000000, 'Extreme', CURRENT_TIMESTAMP()),
('EVT006', 'Frankfurt Book Fair', 'Convention', 'Frankfurt', '2024-10-16', '2024-10-20', 280000, 'High', CURRENT_TIMESTAMP()),
('EVT007', 'Art Basel', 'Festival', 'Miami', '2024-12-06', '2024-12-08', 80000, 'High', CURRENT_TIMESTAMP()),
('EVT008', 'World Economic Forum', 'Convention', 'Davos', '2024-01-15', '2024-01-19', 3000, 'Medium', CURRENT_TIMESTAMP()),
('EVT009', 'F1 Monaco Grand Prix', 'Sports', 'Monaco', '2024-05-23', '2024-05-26', 200000, 'Extreme', CURRENT_TIMESTAMP()),
('EVT010', 'Tokyo Auto Show', 'Convention', 'Tokyo', '2024-10-25', '2024-11-04', 811000, 'High', CURRENT_TIMESTAMP());

-- 8. GENERATE COMPETITIVE SET DATA
INSERT INTO COMPETITIVE_SET 
SELECT 
    'COMP' || LPAD(ROW_NUMBER() OVER (ORDER BY h.HOTEL_ID), 3, '0'),
    h.HOTEL_ID,
    CASE (ROW_NUMBER() OVER (ORDER BY h.HOTEL_ID) % 8)
        WHEN 1 THEN 'Four Seasons'
        WHEN 2 THEN 'Ritz-Carlton'
        WHEN 3 THEN 'St. Regis'
        WHEN 4 THEN 'W Hotels'
        WHEN 5 THEN 'JW Marriott'
        WHEN 6 THEN 'Conrad Hotels'
        WHEN 7 THEN 'Waldorf Astoria'
        ELSE 'InterContinental'
    END,
    CASE (ROW_NUMBER() OVER (ORDER BY h.HOTEL_ID) % 4)
        WHEN 1 THEN 'Marriott'
        WHEN 2 THEN 'Hilton'
        WHEN 3 THEN 'IHG'
        ELSE 'Accor'
    END,
    4.5 + (UNIFORM(0, 10, RANDOM()) * 0.05),
    0.1 + (UNIFORM(1, 50, RANDOM()) * 0.1),
    h.TOTAL_ROOMS + UNIFORM(-100, 200, RANDOM()),
    CASE WHEN ROW_NUMBER() OVER (PARTITION BY h.HOTEL_ID ORDER BY h.HOTEL_ID) = 1 THEN TRUE ELSE FALSE END,
    CURRENT_TIMESTAMP()
FROM HOTELS h
CROSS JOIN (SELECT 1 as n UNION SELECT 2 UNION SELECT 3) nums;
