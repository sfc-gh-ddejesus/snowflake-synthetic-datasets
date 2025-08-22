/*
 * Copyright 2024
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

-- Hotel Chain - Synthetic Data Generation Script
-- This script generates realistic test data for the hotel sales and revenue management system
-- Run this after executing the DDL script
-- Snowflake Compatible Version

USE DATABASE SYNTHETIC_DATA;
USE SCHEMA HOTEL_CHAIN;

-- 1. INSERT HOTELS DATA
-- Major hotel properties across different regions and market segments
INSERT INTO HOTEL_CHAIN_HOTELS VALUES
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
INSERT INTO HOTEL_CHAIN_ROOM_TYPES VALUES
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
INSERT INTO HOTEL_CHAIN_ANCILLARY_SERVICES VALUES
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

-- Generate 5000 customers using cross join approach for Snowflake compatibility
INSERT INTO HOTEL_CHAIN_CUSTOMERS 
SELECT 
    'CUST' || LPAD(ROW_NUMBER() OVER (ORDER BY NULL), 6, '0'),
    first_names.name,
    last_names.name,
    'customer' || ROW_NUMBER() OVER (ORDER BY NULL) || '@email.com',
    '+1' || LPAD(ABS(RANDOM()) % 800 + 200, 3, '0') || LPAD(ABS(RANDOM()) % 900 + 100, 3, '0') || LPAD(ABS(RANDOM()) % 9000 + 1000, 4, '0'),
    loyalty_tiers.tier,
    ABS(RANDOM()) % 150000,
    DATEADD(day, -(ABS(RANDOM()) % 3620 + 30), CURRENT_DATE()),
    DATEADD(day, -(ABS(RANDOM()) % 18250 + 7300), CURRENT_DATE()),
    genders.gender,
    countries.country,
    'English',
    CASE WHEN ABS(RANDOM()) % 10 <= 6 THEN TRUE ELSE FALSE END,
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM 
    (SELECT 'James' as name UNION SELECT 'Mary' UNION SELECT 'John' UNION SELECT 'Patricia' UNION SELECT 'Robert' 
     UNION SELECT 'Jennifer' UNION SELECT 'Michael' UNION SELECT 'Linda' UNION SELECT 'William' UNION SELECT 'Elizabeth'
     UNION SELECT 'David' UNION SELECT 'Barbara' UNION SELECT 'Richard' UNION SELECT 'Susan' UNION SELECT 'Joseph'
     UNION SELECT 'Jessica' UNION SELECT 'Thomas' UNION SELECT 'Sarah' UNION SELECT 'Christopher' UNION SELECT 'Karen'
     UNION SELECT 'Charles' UNION SELECT 'Nancy' UNION SELECT 'Daniel' UNION SELECT 'Lisa' UNION SELECT 'Matthew') first_names
CROSS JOIN
    (SELECT 'Smith' as name UNION SELECT 'Johnson' UNION SELECT 'Williams' UNION SELECT 'Brown' UNION SELECT 'Jones'
     UNION SELECT 'Garcia' UNION SELECT 'Miller' UNION SELECT 'Davis' UNION SELECT 'Rodriguez' UNION SELECT 'Martinez'
     UNION SELECT 'Hernandez' UNION SELECT 'Lopez' UNION SELECT 'Gonzalez' UNION SELECT 'Wilson' UNION SELECT 'Anderson'
     UNION SELECT 'Thomas' UNION SELECT 'Taylor' UNION SELECT 'Moore' UNION SELECT 'Jackson' UNION SELECT 'Martin'
     UNION SELECT 'Lee' UNION SELECT 'Perez' UNION SELECT 'Thompson' UNION SELECT 'White' UNION SELECT 'Harris') last_names
CROSS JOIN
    (SELECT 'Bronze' as tier UNION SELECT 'Silver' UNION SELECT 'Gold' UNION SELECT 'Platinum') loyalty_tiers
CROSS JOIN
    (SELECT 'M' as gender UNION SELECT 'F' UNION SELECT 'Other') genders
CROSS JOIN
    (SELECT 'USA' as country UNION SELECT 'Canada' UNION SELECT 'UK' UNION SELECT 'Germany' UNION SELECT 'France'
     UNION SELECT 'Japan' UNION SELECT 'Australia' UNION SELECT 'China' UNION SELECT 'Brazil' UNION SELECT 'Mexico') countries
LIMIT 5000;

-- 5. GENERATE CORPORATE ACCOUNTS
INSERT INTO HOTEL_CHAIN_CORPORATE_ACCOUNTS VALUES
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
INSERT INTO HOTEL_CHAIN_ROOM_INVENTORY 
SELECT 
    h.HOTEL_ID,
    rt.ROOM_TYPE_ID,
    CASE 
        WHEN rt.ROOM_TYPE_ID = 'RT001' THEN ROUND(h.TOTAL_ROOMS * 0.30) -- Standard King 30%
        WHEN rt.ROOM_TYPE_ID = 'RT002' THEN ROUND(h.TOTAL_ROOMS * 0.22) -- Standard Double 22%
        WHEN rt.ROOM_TYPE_ID = 'RT003' THEN ROUND(h.TOTAL_ROOMS * 0.15) -- Deluxe King 15%
        WHEN rt.ROOM_TYPE_ID = 'RT004' THEN ROUND(h.TOTAL_ROOMS * 0.10) -- Deluxe Double 10%
        WHEN rt.ROOM_TYPE_ID = 'RT005' THEN ROUND(h.TOTAL_ROOMS * 0.08) -- Executive King 8%
        WHEN rt.ROOM_TYPE_ID = 'RT006' THEN ROUND(h.TOTAL_ROOMS * 0.04) -- Junior Suite 4%
        WHEN rt.ROOM_TYPE_ID = 'RT007' THEN ROUND(h.TOTAL_ROOMS * 0.02) -- One Bedroom Suite 2%
        WHEN rt.ROOM_TYPE_ID = 'RT008' THEN 1 -- Presidential Suite 1 per hotel
        WHEN rt.ROOM_TYPE_ID = 'RT009' THEN ROUND(h.TOTAL_ROOMS * 0.06) -- Club King 6%
        WHEN rt.ROOM_TYPE_ID = 'RT010' THEN CASE WHEN h.PROPERTY_TYPE = 'Resort' THEN ROUND(h.TOTAL_ROOMS * 0.02) ELSE 0 END -- Resort Villa 2% (only for resorts)
        ELSE 0
    END,
    CURRENT_TIMESTAMP()
FROM HOTEL_CHAIN_HOTELS h
CROSS JOIN HOTEL_CHAIN_ROOM_TYPES rt
WHERE rt.ROOM_TYPE_ID IN ('RT001', 'RT002', 'RT003', 'RT004', 'RT005', 'RT006', 'RT007', 'RT008', 'RT009', 'RT010');

-- 7. GENERATE EVENTS CALENDAR
INSERT INTO HOTEL_CHAIN_EVENTS_CALENDAR VALUES
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
INSERT INTO HOTEL_CHAIN_COMPETITIVE_SET 
SELECT 
    'COMP' || LPAD(ROW_NUMBER() OVER (ORDER BY h.HOTEL_ID), 3, '0'),
    h.HOTEL_ID,
    competitor_names.name,
    competitor_brands.brand,
    4.0 + (ABS(RANDOM()) % 11) * 0.05, -- Rating between 4.0 and 4.5
    0.1 + (ABS(RANDOM()) % 50) * 0.1,  -- Distance between 0.1 and 5.0 miles
    h.TOTAL_ROOMS + (ABS(RANDOM()) % 301) - 150, -- Similar room count +/- 150
    CASE WHEN ROW_NUMBER() OVER (PARTITION BY h.HOTEL_ID ORDER BY h.HOTEL_ID) = 1 THEN TRUE ELSE FALSE END,
    CURRENT_TIMESTAMP()
FROM HOTEL_CHAIN_HOTELS h
CROSS JOIN (
    SELECT 'Four Seasons' as name UNION SELECT 'Ritz-Carlton' UNION SELECT 'St. Regis' 
    UNION SELECT 'W Hotels' UNION SELECT 'JW Marriott' UNION SELECT 'Conrad Hotels'
    UNION SELECT 'Waldorf Astoria' UNION SELECT 'InterContinental'
) competitor_names
CROSS JOIN (
    SELECT 'Marriott' as brand UNION SELECT 'Hilton' UNION SELECT 'IHG' UNION SELECT 'Accor'
) competitor_brands
QUALIFY ROW_NUMBER() OVER (PARTITION BY h.HOTEL_ID ORDER BY ABS(RANDOM())) <= 3;

-- 9. GENERATE DAILY ROOM RATES (365 days for all hotels)
-- This creates baseline pricing for revenue management
INSERT INTO HOTEL_CHAIN_DAILY_ROOM_RATES
SELECT 
    h.HOTEL_ID,
    rt.ROOM_TYPE_ID,
    d.date_value,
    'BAR', -- Best Available Rate
    'Standard Rate',
    -- Base rate varies by hotel market segment and room type
    CASE h.MARKET_SEGMENT
        WHEN 'Luxury' THEN 
            CASE rt.ROOM_TYPE_ID
                WHEN 'RT001' THEN 450 + (ABS(RANDOM()) % 150) - 50  -- Standard King
                WHEN 'RT002' THEN 480 + (ABS(RANDOM()) % 150) - 50  -- Standard Double
                WHEN 'RT003' THEN 550 + (ABS(RANDOM()) % 170) - 50  -- Deluxe King
                WHEN 'RT004' THEN 580 + (ABS(RANDOM()) % 170) - 50  -- Deluxe Double
                WHEN 'RT005' THEN 650 + (ABS(RANDOM()) % 200) - 50  -- Executive King
                WHEN 'RT006' THEN 850 + (ABS(RANDOM()) % 300) - 100 -- Junior Suite
                WHEN 'RT007' THEN 1200 + (ABS(RANDOM()) % 500) - 200 -- One Bedroom Suite
                WHEN 'RT008' THEN 2500 + (ABS(RANDOM()) % 1500) - 500 -- Presidential Suite
                WHEN 'RT009' THEN 700 + (ABS(RANDOM()) % 200) - 50  -- Club King
                WHEN 'RT010' THEN 1500 + (ABS(RANDOM()) % 800) - 300 -- Resort Villa
                ELSE 400
            END
        WHEN 'Premium' THEN 
            CASE rt.ROOM_TYPE_ID
                WHEN 'RT001' THEN 250 + (ABS(RANDOM()) % 110) - 30
                WHEN 'RT002' THEN 280 + (ABS(RANDOM()) % 110) - 30
                WHEN 'RT003' THEN 320 + (ABS(RANDOM()) % 130) - 40
                WHEN 'RT004' THEN 350 + (ABS(RANDOM()) % 130) - 40
                WHEN 'RT005' THEN 400 + (ABS(RANDOM()) % 150) - 50
                WHEN 'RT006' THEN 550 + (ABS(RANDOM()) % 225) - 75
                WHEN 'RT007' THEN 750 + (ABS(RANDOM()) % 300) - 100
                WHEN 'RT008' THEN 1500 + (ABS(RANDOM()) % 800) - 300
                WHEN 'RT009' THEN 450 + (ABS(RANDOM()) % 150) - 50
                WHEN 'RT010' THEN 950 + (ABS(RANDOM()) % 400) - 150
                ELSE 220
            END
        ELSE -- Select
            CASE rt.ROOM_TYPE_ID
                WHEN 'RT001' THEN 150 + (ABS(RANDOM()) % 70) - 20
                WHEN 'RT002' THEN 170 + (ABS(RANDOM()) % 70) - 20
                WHEN 'RT003' THEN 200 + (ABS(RANDOM()) % 85) - 25
                WHEN 'RT004' THEN 220 + (ABS(RANDOM()) % 85) - 25
                WHEN 'RT005' THEN 250 + (ABS(RANDOM()) % 100) - 30
                WHEN 'RT006' THEN 350 + (ABS(RANDOM()) % 150) - 50
                WHEN 'RT007' THEN 450 + (ABS(RANDOM()) % 225) - 75
                WHEN 'RT008' THEN 800 + (ABS(RANDOM()) % 450) - 150
                WHEN 'RT009' THEN 280 + (ABS(RANDOM()) % 100) - 30
                WHEN 'RT010' THEN 550 + (ABS(RANDOM()) % 250) - 100
                ELSE 130
            END
    END * 
    -- Seasonal factor
    CASE 
        WHEN MONTH(d.date_value) IN (12, 1, 2) THEN 1.2 -- Winter holiday season
        WHEN MONTH(d.date_value) IN (6, 7, 8) THEN 1.15 -- Summer season
        WHEN MONTH(d.date_value) IN (3, 4, 5) THEN 1.1 -- Spring
        ELSE 1.0 -- Fall baseline
    END *
    -- Weekend factor
    CASE WHEN DAYOFWEEK(d.date_value) IN (1, 7) THEN 1.25 ELSE 1.0 END,
    
    NULL, -- discounted_rate (will be populated for some records)
    
    -- Available rooms from inventory
    COALESCE(hri.ROOM_COUNT, 0),
    0, -- rooms_sold (will be updated)
    0, -- revenue_generated (will be updated)
    
    -- Demand level based on day of week and season
    CASE 
        WHEN DAYOFWEEK(d.date_value) IN (1, 7) AND MONTH(d.date_value) IN (12, 1, 6, 7, 8) THEN 'Peak'
        WHEN DAYOFWEEK(d.date_value) IN (1, 7) THEN 'High'
        WHEN MONTH(d.date_value) IN (12, 1, 6, 7, 8) THEN 'High'
        WHEN DAYOFWEEK(d.date_value) IN (2, 3, 4, 5) THEN 'Medium'
        ELSE 'Low'
    END,
    
    -- Seasonal factor (repeated for storage)
    CASE 
        WHEN MONTH(d.date_value) IN (12, 1, 2) THEN 1.2
        WHEN MONTH(d.date_value) IN (6, 7, 8) THEN 1.15
        WHEN MONTH(d.date_value) IN (3, 4, 5) THEN 1.1
        ELSE 1.0
    END,
    
    FALSE, -- event_impact (will be updated for specific dates)
    CURRENT_TIMESTAMP()
    
FROM HOTEL_CHAIN_HOTELS h
CROSS JOIN HOTEL_CHAIN_ROOM_TYPES rt
CROSS JOIN (
    SELECT DATEADD(day, seq4() - 1, '2024-01-01') as date_value
    FROM TABLE(GENERATOR(ROWCOUNT => 365))
) d
LEFT JOIN HOTEL_CHAIN_ROOM_INVENTORY hri ON h.HOTEL_ID = hri.HOTEL_ID AND rt.ROOM_TYPE_ID = hri.ROOM_TYPE_ID
WHERE hri.ROOM_COUNT > 0;

-- 10. GENERATE RESERVATIONS (5,000 reservations for basic data)
-- Proper variety approach using deterministic selection
INSERT INTO HOTEL_CHAIN_RESERVATIONS
WITH hotels_array AS (
  SELECT HOTEL_ID, ROW_NUMBER() OVER (ORDER BY HOTEL_ID) as hotel_rank
  FROM HOTEL_CHAIN_HOTELS
),
customers_array AS (
  SELECT CUSTOMER_ID, ROW_NUMBER() OVER (ORDER BY CUSTOMER_ID) as customer_rank
  FROM HOTEL_CHAIN_CUSTOMERS
),
room_types_array AS (
  SELECT ROOM_TYPE_ID, ROW_NUMBER() OVER (ORDER BY ROOM_TYPE_ID) as room_rank
  FROM HOTEL_CHAIN_ROOM_TYPES
),
corp_accounts_array AS (
  SELECT ACCOUNT_ID, ROW_NUMBER() OVER (ORDER BY ACCOUNT_ID) as corp_rank
  FROM HOTEL_CHAIN_CORPORATE_ACCOUNTS
),
reservation_data AS (
  SELECT 
    g.seq_num,
    h.HOTEL_ID,
    c.CUSTOMER_ID,
    CASE WHEN MOD(g.seq_num, 5) = 0 THEN corp.ACCOUNT_ID ELSE NULL END as corporate_account_id,
    rt.ROOM_TYPE_ID,
    DATEADD(day, MOD(g.seq_num, 300) + 1, '2024-01-01') as check_in_date,
    MOD(g.seq_num, 5) + 1 as nights,
    g.random_val
  FROM (
    SELECT 
      ROW_NUMBER() OVER (ORDER BY RANDOM()) as seq_num,
      RANDOM() as random_val
    FROM TABLE(GENERATOR(ROWCOUNT => 5000))
  ) g
  JOIN hotels_array h ON h.hotel_rank = MOD(g.seq_num, 25) + 1
  JOIN customers_array c ON c.customer_rank = MOD(g.seq_num * 37, 5000) + 1  -- Use prime multiplier for better distribution
  JOIN room_types_array rt ON rt.room_rank = MOD(g.seq_num, 10) + 1
  LEFT JOIN corp_accounts_array corp ON corp.corp_rank = MOD(g.seq_num, 10) + 1
)
SELECT 
    'RES' || LPAD(rd.seq_num, 10, '0'),
    'HTL' || LPAD(rd.seq_num, 8, '0'),
    rd.hotel_id,
    rd.customer_id,
    rd.corporate_account_id,
    rd.room_type_id,
    rd.check_in_date,
    DATEADD(day, rd.nights, rd.check_in_date),
    rd.nights,
    CASE WHEN MOD(rd.seq_num, 10) <= 6 THEN 1 ELSE 2 END, -- adults (70% single, 30% double)
    CASE WHEN MOD(rd.seq_num, 10) <= 7 THEN 0 ELSE MOD(rd.seq_num, 2) + 1 END, -- children (80% no children)
    1, -- rooms_booked
    DATEADD(day, -(MOD(rd.seq_num, 90) + 1), rd.check_in_date), -- booking_date (1-90 days before)
    CASE MOD(rd.seq_num, 5)
        WHEN 0 THEN 'Direct'
        WHEN 1 THEN 'OTA' 
        WHEN 2 THEN 'GDS'
        WHEN 3 THEN 'Phone'
        ELSE 'Walk-in'
    END,
    CASE MOD(rd.seq_num, 5)
        WHEN 0 THEN 'Direct.com'
        WHEN 1 THEN 'Expedia'
        WHEN 2 THEN 'Booking.com'
        WHEN 3 THEN 'Direct Call'
        ELSE 'Walk-in'
    END,
    CASE MOD(rd.seq_num, 20)
        WHEN 0 THEN 'Cancelled'
        WHEN 1 THEN 'No-Show'  
        WHEN 19 THEN 'Confirmed'
        ELSE 'Completed'
    END,
    CASE WHEN MOD(rd.seq_num, 20) = 0 
         THEN DATEADD(day, MOD(rd.seq_num, 30) + 1, DATEADD(day, -(MOD(rd.seq_num, 90) + 1), rd.check_in_date)) 
         ELSE NULL END,
    CASE WHEN MOD(rd.seq_num, 20) = 0 
         THEN CASE MOD(rd.seq_num, 4)
           WHEN 0 THEN 'Change of plans'
           WHEN 1 THEN 'Found better rate'
           WHEN 2 THEN 'Emergency'
           ELSE 'Event cancelled'
         END
         ELSE NULL END,
    CASE 
        WHEN rd.corporate_account_id IS NOT NULL THEN 'CORP'
        ELSE CASE MOD(rd.seq_num, 4)
            WHEN 0 THEN 'AAA'
            WHEN 1 THEN 'GOVT'
            ELSE 'BAR'
        END
    END,
    CASE 
        WHEN rd.corporate_account_id IS NOT NULL THEN 'Corporate Rate'
        ELSE CASE MOD(rd.seq_num, 4)
            WHEN 0 THEN 'AAA Discount'
            WHEN 1 THEN 'Government Rate'
            ELSE 'Best Available Rate'
        END
    END,
    COALESCE(drr.BASE_RATE, 200.00),
    COALESCE(drr.BASE_RATE, 200.00) * rd.nights,
    COALESCE(drr.BASE_RATE, 200.00) * rd.nights * 0.15, -- 15% taxes
    CASE WHEN MOD(rd.seq_num, 10) <= 3 THEN 35.00 ELSE 0 END, -- resort fees (40% of reservations)
    COALESCE(drr.BASE_RATE, 200.00) * rd.nights * 1.15 + CASE WHEN MOD(rd.seq_num, 10) <= 3 THEN 35.00 ELSE 0 END,
    'USD',
    CASE MOD(rd.seq_num, 4)
        WHEN 0 THEN 'Business'
        WHEN 1 THEN 'Leisure'
        WHEN 2 THEN 'Corporate'
        ELSE 'Group'  
    END,
    CASE WHEN MOD(rd.seq_num, 20) = 0 THEN 
        CASE MOD(rd.seq_num, 4)
            WHEN 0 THEN 'Late checkout please'
            WHEN 1 THEN 'High floor preferred'
            WHEN 2 THEN 'Quiet room'
            ELSE 'Airport pickup needed'
        END
    ELSE NULL END,
    CASE WHEN MOD(rd.seq_num, 20) NOT IN (0, 1) 
         THEN ROUND(COALESCE(drr.BASE_RATE, 200.00) * rd.nights * 0.1) 
         ELSE 0 END, -- loyalty points
    DATEDIFF(day, DATEADD(day, -(MOD(rd.seq_num, 90) + 1), rd.check_in_date), rd.check_in_date),
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM reservation_data rd
LEFT JOIN HOTEL_CHAIN_DAILY_ROOM_RATES drr ON rd.hotel_id = drr.HOTEL_ID 
    AND rd.room_type_id = drr.ROOM_TYPE_ID 
    AND rd.check_in_date = drr.RATE_DATE
    AND drr.RATE_CODE = 'BAR';

-- 11. GENERATE ANCILLARY SALES (related to reservations)
CREATE OR REPLACE SEQUENCE ANCILLARY_SALE_SEQ START = 1 INCREMENT = 1;

INSERT INTO HOTEL_CHAIN_ANCILLARY_SALES
WITH completed_reservations AS (
  SELECT 
    RESERVATION_ID, 
    HOTEL_ID, 
    CUSTOMER_ID, 
    CHECK_IN_DATE, 
    NIGHTS,
    ROW_NUMBER() OVER (ORDER BY RESERVATION_ID) as res_rank
  FROM HOTEL_CHAIN_RESERVATIONS 
  WHERE RESERVATION_STATUS = 'Completed'
  AND CHECK_IN_DATE >= '2024-01-01'
),
services_array AS (
  SELECT SERVICE_ID, BASE_PRICE, ROW_NUMBER() OVER (ORDER BY SERVICE_ID) as service_rank
  FROM HOTEL_CHAIN_ANCILLARY_SERVICES
),
service_sales AS (
  SELECT 
    cr.RESERVATION_ID,
    cr.HOTEL_ID,
    cr.CUSTOMER_ID,
    DATEADD(day, MOD(cr.res_rank, cr.NIGHTS), cr.CHECK_IN_DATE) as SALE_DATE,
    s.SERVICE_ID,
    s.BASE_PRICE,
    CASE 
        WHEN s.SERVICE_ID IN ('SVC007', 'SVC008') THEN MOD(cr.res_rank, 3) + 1 -- F&B services 1-3 quantity
        WHEN s.SERVICE_ID IN ('SVC005', 'SVC006') THEN 1 -- Spa treatments always 1
        ELSE 1
    END as QUANTITY,
    cr.res_rank * 100 + s.service_rank as rn
  FROM completed_reservations cr
  CROSS JOIN services_array s
  WHERE MOD(cr.res_rank + s.service_rank, 5) <= 2 -- 60% chance, deterministic pattern
)
SELECT 
    'SALE' || LPAD(ss.rn, 12, '0'),
    ss.RESERVATION_ID,
    ss.HOTEL_ID,
    ss.CUSTOMER_ID,
    ss.SERVICE_ID,
    ss.SALE_DATE,
    ss.QUANTITY,
    ss.BASE_PRICE * (1 + (MOD(ss.rn, 41) - 20) / 100.0), -- Price variation ±20%
    (ss.BASE_PRICE * (1 + (MOD(ss.rn, 41) - 20) / 100.0)) * ss.QUANTITY,
    0, -- discount_amount
    (ss.BASE_PRICE * (1 + (MOD(ss.rn, 41) - 20) / 100.0)) * ss.QUANTITY * 0.1, -- 10% tax
    CASE MOD(ss.rn, 5)
        WHEN 0 THEN 'Cash'
        WHEN 1 THEN 'Credit Card'
        WHEN 2 THEN 'Room Charge'
        WHEN 3 THEN 'Comp'
        ELSE 'Gift Card'
    END,
    'Completed',
    CURRENT_TIMESTAMP()
FROM service_sales ss;

-- 12. GENERATE REVENUE SUMMARY DATA
INSERT INTO HOTEL_CHAIN_REVENUE_SUMMARY
SELECT 
    h.HOTEL_ID,
    d.date_value,
    COALESCE(hri.total_rooms, 0) as total_rooms_available,
    COALESCE(rs.rooms_sold, 0) as rooms_sold,
    CASE WHEN COALESCE(hri.total_rooms, 0) > 0 
         THEN ROUND((COALESCE(rs.rooms_sold, 0) * 100.0 / hri.total_rooms), 2)
         ELSE 0 END as occupancy_rate,
    CASE WHEN COALESCE(rs.rooms_sold, 0) > 0 
         THEN ROUND(COALESCE(rs.room_revenue, 0) / rs.rooms_sold, 2)
         ELSE 0 END as adr,
    CASE WHEN COALESCE(hri.total_rooms, 0) > 0 
         THEN ROUND(COALESCE(rs.room_revenue, 0) / hri.total_rooms, 2)
         ELSE 0 END as revpar,
    COALESCE(rs.room_revenue, 0) as room_revenue,
    COALESCE(anc.ancillary_revenue, 0) as ancillary_revenue,
    COALESCE(rs.room_revenue, 0) + COALESCE(anc.ancillary_revenue, 0) as total_revenue,
    COALESCE(rs.walk_in_rooms, 0) as walk_in_rooms,
    COALESCE(rs.group_rooms, 0) as group_rooms,
    COALESCE(rs.corporate_rooms, 0) as corporate_rooms,
    COALESCE(rs.leisure_rooms, 0) as leisure_rooms,
    CURRENT_TIMESTAMP()
FROM HOTEL_CHAIN_HOTELS h
CROSS JOIN (
    SELECT DATEADD(day, seq4() - 1, '2024-01-01') as date_value
    FROM TABLE(GENERATOR(ROWCOUNT => 365))
) d
LEFT JOIN (
    SELECT HOTEL_ID, SUM(ROOM_COUNT) as total_rooms
    FROM HOTEL_CHAIN_ROOM_INVENTORY 
    GROUP BY HOTEL_ID
) hri ON h.HOTEL_ID = hri.HOTEL_ID
LEFT JOIN (
    SELECT 
        r.HOTEL_ID,
        r.CHECK_IN_DATE,
        SUM(r.ROOMS_BOOKED) as rooms_sold,
        SUM(r.TOTAL_ROOM_REVENUE) as room_revenue,
        SUM(CASE WHEN r.BOOKING_CHANNEL = 'Walk-in' THEN r.ROOMS_BOOKED ELSE 0 END) as walk_in_rooms,
        SUM(CASE WHEN r.GUEST_TYPE = 'Group' THEN r.ROOMS_BOOKED ELSE 0 END) as group_rooms,
        SUM(CASE WHEN r.GUEST_TYPE = 'Corporate' THEN r.ROOMS_BOOKED ELSE 0 END) as corporate_rooms,
        SUM(CASE WHEN r.GUEST_TYPE = 'Leisure' THEN r.ROOMS_BOOKED ELSE 0 END) as leisure_rooms
    FROM HOTEL_CHAIN_RESERVATIONS r
    WHERE r.RESERVATION_STATUS IN ('Completed', 'Confirmed')
    GROUP BY r.HOTEL_ID, r.CHECK_IN_DATE
) rs ON h.HOTEL_ID = rs.HOTEL_ID AND d.date_value = rs.CHECK_IN_DATE
LEFT JOIN (
    SELECT 
        a.HOTEL_ID,
        a.SALE_DATE,
        SUM(a.TOTAL_AMOUNT) as ancillary_revenue
    FROM HOTEL_CHAIN_ANCILLARY_SALES a
    WHERE a.TRANSACTION_STATUS = 'Completed'
    GROUP BY a.HOTEL_ID, a.SALE_DATE
) anc ON h.HOTEL_ID = anc.HOTEL_ID AND d.date_value = anc.SALE_DATE;
