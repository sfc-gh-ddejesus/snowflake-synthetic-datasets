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

-- Hotel Chain - Reservations and Sales Data Generation Script
-- This script generates 15,000+ reservation records and associated data
-- Optimized for Snowflake Data Cloud

USE DATABASE SYNTHETIC_DATA;
USE SCHEMA HOTEL_CHAIN;

-- Create sequences for generating IDs
CREATE OR REPLACE SEQUENCE RESERVATION_SEQ START = 1 INCREMENT = 1;
CREATE OR REPLACE SEQUENCE ANCILLARY_SALE_SEQ START = 1 INCREMENT = 1;

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

-- Update rates for corporate discounts
INSERT INTO HOTEL_CHAIN_DAILY_ROOM_RATES
SELECT 
    HOTEL_ID,
    ROOM_TYPE_ID,
    RATE_DATE,
    'CORP',
    'Corporate Rate',
    BASE_RATE * 0.85, -- 15% corporate discount
    BASE_RATE * 0.85,
    AVAILABLE_ROOMS,
    0,
    0,
    DEMAND_LEVEL,
    SEASONAL_FACTOR,
    EVENT_IMPACT,
    CURRENT_TIMESTAMP()
FROM HOTEL_CHAIN_DAILY_ROOM_RATES 
WHERE RATE_CODE = 'BAR'
AND ABS(RANDOM()) % 10 <= 6; -- 70% of hotels offer corporate rates

-- 10. GENERATE RESERVATIONS (15,000 reservations)
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
reservation_base AS (
  SELECT 
    g.seq_num,
    h.HOTEL_ID,
    c.CUSTOMER_ID,
    CASE WHEN MOD(g.seq_num, 5) = 0 THEN corp.ACCOUNT_ID ELSE NULL END as CORPORATE_ACCOUNT_ID,
    rt.ROOM_TYPE_ID,
    DATEADD(day, MOD(g.seq_num, 300) + 1, '2024-01-01') as check_in_date,
    MOD(g.seq_num, 5) + 1 as nights,
    DATEADD(day, -(MOD(g.seq_num, 90) + 1), DATEADD(day, MOD(g.seq_num, 300) + 1, '2024-01-01')) as booking_date
  FROM (
    SELECT 
      ROW_NUMBER() OVER (ORDER BY RANDOM()) as seq_num
    FROM TABLE(GENERATOR(ROWCOUNT => 15000))
  ) g
  JOIN hotels_array h ON h.hotel_rank = MOD(g.seq_num, 25) + 1
  JOIN customers_array c ON c.customer_rank = MOD(g.seq_num * 37, 5000) + 1  -- Use prime multiplier for better distribution
  JOIN room_types_array rt ON rt.room_rank = MOD(g.seq_num, 10) + 1
  LEFT JOIN corp_accounts_array corp ON corp.corp_rank = MOD(g.seq_num, 10) + 1
)
SELECT 
    'RES' || LPAD(rb.seq_num, 10, '0'),
    'HTL' || LPAD(rb.seq_num, 8, '0'),
    rb.HOTEL_ID,
    rb.CUSTOMER_ID,
    rb.CORPORATE_ACCOUNT_ID,
    rb.ROOM_TYPE_ID,
    rb.check_in_date,
    DATEADD(day, rb.nights, rb.check_in_date),
    rb.nights,
    CASE WHEN MOD(rb.seq_num, 10) <= 6 THEN 1 ELSE 2 END, -- adults (70% single, 30% double)
    CASE WHEN MOD(rb.seq_num, 10) <= 7 THEN 0 ELSE MOD(rb.seq_num, 2) + 1 END, -- children (80% no children)
    1, -- rooms_booked
    rb.booking_date,
    CASE MOD(rb.seq_num, 5)
        WHEN 0 THEN 'Direct'
        WHEN 1 THEN 'OTA' 
        WHEN 2 THEN 'GDS'
        WHEN 3 THEN 'Phone'
        ELSE 'Walk-in'
    END,
    CASE MOD(rb.seq_num, 5)
        WHEN 0 THEN 'Direct.com'
        WHEN 1 THEN 'Expedia'
        WHEN 2 THEN 'Booking.com'
        WHEN 3 THEN 'Direct Call'
        ELSE 'Walk-in'
    END,
    CASE MOD(rb.seq_num, 20)
        WHEN 0 THEN 'Cancelled'
        WHEN 1 THEN 'No-Show'  
        WHEN 19 THEN 'Confirmed'
        ELSE 'Completed'
    END,
    CASE WHEN MOD(rb.seq_num, 20) = 0 
         THEN DATEADD(day, MOD(rb.seq_num, 30) + 1, rb.booking_date) 
         ELSE NULL END,
    CASE WHEN MOD(rb.seq_num, 20) = 0 
         THEN CASE MOD(rb.seq_num, 4)
           WHEN 0 THEN 'Change of plans'
           WHEN 1 THEN 'Found better rate'
           WHEN 2 THEN 'Emergency'
           ELSE 'Event cancelled'
         END
         ELSE NULL END,
    CASE 
        WHEN rb.CORPORATE_ACCOUNT_ID IS NOT NULL THEN 'CORP'
        ELSE CASE MOD(rb.seq_num, 4)
            WHEN 0 THEN 'AAA'
            WHEN 1 THEN 'GOVT'
            ELSE 'BAR'
        END
    END,
    CASE 
        WHEN rb.CORPORATE_ACCOUNT_ID IS NOT NULL THEN 'Corporate Rate'
        ELSE CASE MOD(rb.seq_num, 4)
            WHEN 0 THEN 'AAA Discount'
            WHEN 1 THEN 'Government Rate'
            ELSE 'Best Available Rate'
        END
    END,
    COALESCE(drr.BASE_RATE, 200.00),
    COALESCE(drr.BASE_RATE, 200.00) * rb.nights,
    COALESCE(drr.BASE_RATE, 200.00) * rb.nights * 0.15, -- 15% taxes
    CASE WHEN MOD(rb.seq_num, 10) <= 3 THEN 35.00 ELSE 0 END, -- resort fees (40% of reservations)
    COALESCE(drr.BASE_RATE, 200.00) * rb.nights * 1.15 + CASE WHEN MOD(rb.seq_num, 10) <= 3 THEN 35.00 ELSE 0 END,
    'USD',
    CASE MOD(rb.seq_num, 4)
        WHEN 0 THEN 'Business'
        WHEN 1 THEN 'Leisure'
        WHEN 2 THEN 'Corporate'
        ELSE 'Group'  
    END,
    CASE WHEN MOD(rb.seq_num, 20) = 0 THEN 
        CASE MOD(rb.seq_num, 4)
            WHEN 0 THEN 'Late checkout please'
            WHEN 1 THEN 'High floor preferred'
            WHEN 2 THEN 'Quiet room'
            ELSE 'Airport pickup needed'
        END
    ELSE NULL END,
    CASE WHEN MOD(rb.seq_num, 20) NOT IN (0, 1) 
         THEN ROUND(COALESCE(drr.BASE_RATE, 200.00) * rb.nights * 0.1) 
         ELSE 0 END, -- loyalty points
    DATEDIFF(day, rb.booking_date, rb.check_in_date),
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM reservation_base rb
LEFT JOIN HOTEL_CHAIN_DAILY_ROOM_RATES drr ON rb.HOTEL_ID = drr.HOTEL_ID 
    AND rb.ROOM_TYPE_ID = drr.ROOM_TYPE_ID 
    AND rb.check_in_date = drr.RATE_DATE
    AND drr.RATE_CODE = 'BAR'
WHERE rb.booking_date <= rb.check_in_date
AND rb.check_in_date >= '2024-01-01' 
AND rb.check_in_date <= '2024-12-31';

-- 11. GENERATE ANCILLARY SALES (related to reservations)
INSERT INTO HOTEL_CHAIN_ANCILLARY_SALES
WITH completed_reservations AS (
  SELECT RESERVATION_ID, HOTEL_ID, CUSTOMER_ID, CHECK_IN_DATE, NIGHTS
  FROM HOTEL_CHAIN_RESERVATIONS 
  WHERE RESERVATION_STATUS = 'Completed'
  AND CHECK_IN_DATE >= '2024-01-01'
),
service_sales AS (
  SELECT 
    cr.RESERVATION_ID,
    cr.HOTEL_ID,
    cr.CUSTOMER_ID,
    DATEADD(day, ABS(RANDOM()) % cr.NIGHTS, cr.CHECK_IN_DATE) as SALE_DATE,
    s.SERVICE_ID,
    s.BASE_PRICE,
    CASE 
        WHEN s.SERVICE_ID IN ('SVC007', 'SVC008') THEN ABS(RANDOM()) % 3 + 1 -- F&B services
        WHEN s.SERVICE_ID IN ('SVC005', 'SVC006') THEN 1 -- Spa treatments
        ELSE 1
    END as QUANTITY,
    ROW_NUMBER() OVER (ORDER BY ABS(RANDOM())) as rn
  FROM completed_reservations cr
  CROSS JOIN HOTEL_CHAIN_ANCILLARY_SERVICES s
  WHERE ABS(RANDOM()) % 5 <= 2 -- 60% chance of ancillary purchase
)
SELECT 
    'SALE' || LPAD(ss.rn, 12, '0'),
    ss.RESERVATION_ID,
    ss.HOTEL_ID,
    ss.CUSTOMER_ID,
    ss.SERVICE_ID,
    ss.SALE_DATE,
    ss.QUANTITY,
    ss.BASE_PRICE * (1 + (ABS(RANDOM()) % 41 - 20) / 100.0), -- Price variation ±20%
    (ss.BASE_PRICE * (1 + (ABS(RANDOM()) % 41 - 20) / 100.0)) * ss.QUANTITY,
    0, -- discount_amount
    (ss.BASE_PRICE * (1 + (ABS(RANDOM()) % 41 - 20) / 100.0)) * ss.QUANTITY * 0.1, -- 10% tax
    CASE (ABS(RANDOM()) % 5)
        WHEN 0 THEN 'Cash'
        WHEN 1 THEN 'Credit Card'
        WHEN 2 THEN 'Room Charge'
        WHEN 3 THEN 'Comp'
        ELSE 'Gift Card'
    END,
    'Completed',
    CURRENT_TIMESTAMP()
FROM service_sales ss;

-- 12. UPDATE DAILY ROOM RATES with actual sales data
MERGE INTO HOTEL_CHAIN_DAILY_ROOM_RATES drr
USING (
    SELECT 
        r.HOTEL_ID,
        r.ROOM_TYPE_ID, 
        r.CHECK_IN_DATE,
        'BAR' as rate_code,
        SUM(r.ROOMS_BOOKED) as rooms_sold,
        SUM(r.TOTAL_ROOM_REVENUE) as total_revenue
    FROM HOTEL_CHAIN_RESERVATIONS r
    WHERE r.RESERVATION_STATUS IN ('Completed', 'Confirmed')
    GROUP BY r.HOTEL_ID, r.ROOM_TYPE_ID, r.CHECK_IN_DATE
) actual_sales ON (
    drr.HOTEL_ID = actual_sales.HOTEL_ID
    AND drr.ROOM_TYPE_ID = actual_sales.ROOM_TYPE_ID  
    AND drr.RATE_DATE = actual_sales.CHECK_IN_DATE
    AND drr.RATE_CODE = actual_sales.rate_code
)
WHEN MATCHED THEN UPDATE SET 
    ROOMS_SOLD = actual_sales.rooms_sold,
    REVENUE_GENERATED = actual_sales.total_revenue;

-- 13. GENERATE REVENUE SUMMARY DATA
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

-- Final data quality checks and statistics
SELECT 'Reservations Created' as metric, COUNT(*) as count FROM HOTEL_CHAIN_RESERVATIONS;
SELECT 'Ancillary Sales Created' as metric, COUNT(*) as count FROM HOTEL_CHAIN_ANCILLARY_SALES;
SELECT 'Daily Rates Created' as metric, COUNT(*) as count FROM HOTEL_CHAIN_DAILY_ROOM_RATES;
SELECT 'Revenue Summary Created' as metric, COUNT(*) as count FROM HOTEL_CHAIN_REVENUE_SUMMARY;

-- Show sample data
SELECT 'Sample Reservations' as section, * FROM HOTEL_CHAIN_RESERVATIONS LIMIT 5;
SELECT 'Sample Revenue Summary' as section, * FROM HOTEL_CHAIN_REVENUE_SUMMARY WHERE TOTAL_REVENUE > 0 LIMIT 5;
