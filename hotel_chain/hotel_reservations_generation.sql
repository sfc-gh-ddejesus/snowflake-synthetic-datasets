-- Hotel Chain - Reservations and Sales Data Generation Script
-- This script generates 10,000+ reservation records and associated data

USE DATABASE HOTEL_CHAIN;
USE SCHEMA SALES_REVENUE;

-- Create sequences for generating IDs
CREATE OR REPLACE SEQUENCE RESERVATION_SEQ START = 1 INCREMENT = 1;
CREATE OR REPLACE SEQUENCE ANCILLARY_SALE_SEQ START = 1 INCREMENT = 1;

-- 9. GENERATE DAILY ROOM RATES (365 days for all hotels)
-- This creates baseline pricing for revenue management
INSERT INTO DAILY_ROOM_RATES
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
                WHEN 'RT001' THEN 450 + UNIFORM(-50, 100, RANDOM())  -- Standard King
                WHEN 'RT002' THEN 480 + UNIFORM(-50, 100, RANDOM())  -- Standard Double
                WHEN 'RT003' THEN 550 + UNIFORM(-50, 120, RANDOM())  -- Deluxe King
                WHEN 'RT004' THEN 580 + UNIFORM(-50, 120, RANDOM())  -- Deluxe Double
                WHEN 'RT005' THEN 650 + UNIFORM(-50, 150, RANDOM())  -- Executive King
                WHEN 'RT006' THEN 850 + UNIFORM(-100, 200, RANDOM()) -- Junior Suite
                WHEN 'RT007' THEN 1200 + UNIFORM(-200, 300, RANDOM()) -- One Bedroom Suite
                WHEN 'RT008' THEN 2500 + UNIFORM(-500, 1000, RANDOM()) -- Presidential Suite
                ELSE 400
            END
        WHEN 'Premium' THEN 
            CASE rt.ROOM_TYPE_ID
                WHEN 'RT001' THEN 250 + UNIFORM(-30, 80, RANDOM())
                WHEN 'RT002' THEN 280 + UNIFORM(-30, 80, RANDOM())
                WHEN 'RT003' THEN 320 + UNIFORM(-40, 90, RANDOM())
                WHEN 'RT004' THEN 350 + UNIFORM(-40, 90, RANDOM())
                WHEN 'RT005' THEN 400 + UNIFORM(-50, 100, RANDOM())
                WHEN 'RT006' THEN 550 + UNIFORM(-75, 150, RANDOM())
                WHEN 'RT007' THEN 750 + UNIFORM(-100, 200, RANDOM())
                WHEN 'RT008' THEN 1500 + UNIFORM(-300, 500, RANDOM())
                ELSE 220
            END
        ELSE -- Select
            CASE rt.ROOM_TYPE_ID
                WHEN 'RT001' THEN 150 + UNIFORM(-20, 50, RANDOM())
                WHEN 'RT002' THEN 170 + UNIFORM(-20, 50, RANDOM())
                WHEN 'RT003' THEN 200 + UNIFORM(-25, 60, RANDOM())
                WHEN 'RT004' THEN 220 + UNIFORM(-25, 60, RANDOM())
                WHEN 'RT005' THEN 250 + UNIFORM(-30, 70, RANDOM())
                WHEN 'RT006' THEN 350 + UNIFORM(-50, 100, RANDOM())
                WHEN 'RT007' THEN 450 + UNIFORM(-75, 150, RANDOM())
                WHEN 'RT008' THEN 800 + UNIFORM(-150, 300, RANDOM())
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
    
FROM HOTELS h
CROSS JOIN ROOM_TYPES rt
CROSS JOIN (
    SELECT DATEADD(day, ROW_NUMBER() OVER (ORDER BY NULL) - 1, '2024-01-01') as date_value
    FROM TABLE(GENERATOR(ROWCOUNT => 365))
) d
LEFT JOIN HOTEL_ROOM_INVENTORY hri ON h.HOTEL_ID = hri.HOTEL_ID AND rt.ROOM_TYPE_ID = hri.ROOM_TYPE_ID
WHERE hri.ROOM_COUNT > 0;

-- Update rates for corporate discounts
INSERT INTO DAILY_ROOM_RATES
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
FROM DAILY_ROOM_RATES 
WHERE RATE_CODE = 'BAR'
AND UNIFORM(1, 10, RANDOM()) <= 7; -- 70% of hotels offer corporate rates

-- 10. GENERATE RESERVATIONS (15,000 reservations)
INSERT INTO RESERVATIONS
SELECT 
    'RES' || LPAD(RESERVATION_SEQ.NEXTVAL, 10, '0'),
    'HTL' || LPAD(RESERVATION_SEQ.CURRVAL, 8, '0'),
    hotels.HOTEL_ID,
    customers.CUSTOMER_ID,
    CASE WHEN UNIFORM(1, 10, RANDOM()) <= 3 THEN corp_accounts.ACCOUNT_ID ELSE NULL END,
    room_types.ROOM_TYPE_ID,
    check_in_date,
    DATEADD(day, nights, check_in_date),
    nights,
    CASE WHEN UNIFORM(1, 10, RANDOM()) <= 7 THEN 1 ELSE 2 END, -- adults
    CASE WHEN UNIFORM(1, 10, RANDOM()) <= 3 THEN UNIFORM(1, 2, RANDOM()) ELSE 0 END, -- children
    1, -- rooms_booked
    booking_date,
    booking_channels.channel,
    booking_sources.source,
    reservation_statuses.status,
    CASE WHEN reservation_statuses.status = 'Cancelled' 
         THEN DATEADD(day, UNIFORM(1, 30, RANDOM()), booking_date) 
         ELSE NULL END,
    CASE WHEN reservation_statuses.status = 'Cancelled' 
         THEN cancellation_reasons.reason 
         ELSE NULL END,
    rate_codes.rate_code,
    rate_plans.rate_plan,
    room_rate,
    room_rate * nights,
    (room_rate * nights) * 0.15, -- 15% taxes
    CASE WHEN UNIFORM(1, 10, RANDOM()) <= 4 THEN 35.00 ELSE 0 END, -- resort fees
    (room_rate * nights) * 1.15 + CASE WHEN UNIFORM(1, 10, RANDOM()) <= 4 THEN 35.00 ELSE 0 END,
    'USD',
    guest_types.guest_type,
    CASE WHEN UNIFORM(1, 20, RANDOM()) = 1 THEN special_requests.request ELSE NULL END,
    CASE WHEN reservation_statuses.status = 'Completed' 
         THEN ROUND((room_rate * nights) * 0.1) 
         ELSE 0 END, -- loyalty points
    DATEDIFF(day, booking_date, check_in_date),
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()

FROM (
    -- Generate base reservation data
    SELECT 
        UNIFORM(1, 25, RANDOM()) as hotel_idx,
        UNIFORM(1, 5000, RANDOM()) as customer_idx,
        UNIFORM(1, 10, RANDOM()) as corp_idx,
        UNIFORM(1, 8, RANDOM()) as room_type_idx,
        DATEADD(day, UNIFORM(-90, 365, RANDOM()), CURRENT_DATE()) as check_in_date,
        CASE WHEN UNIFORM(1, 10, RANDOM()) <= 6 THEN 1 
             WHEN UNIFORM(1, 10, RANDOM()) <= 8 THEN 2
             WHEN UNIFORM(1, 10, RANDOM()) <= 9 THEN 3
             ELSE UNIFORM(4, 7, RANDOM()) END as nights,
        DATEADD(day, -UNIFORM(1, 120, RANDOM()), DATEADD(day, UNIFORM(-90, 365, RANDOM()), CURRENT_DATE())) as booking_date
    FROM TABLE(GENERATOR(ROWCOUNT => 15000))
) base_data

-- Join with dimension tables
CROSS JOIN (SELECT 'Direct' as channel UNION SELECT 'OTA' UNION SELECT 'GDS' UNION SELECT 'Phone' UNION SELECT 'Walk-in') booking_channels
CROSS JOIN (SELECT 'Hyatt.com' as source UNION SELECT 'Expedia' UNION SELECT 'Booking.com' UNION SELECT 'Direct Call' UNION SELECT 'Walk-in') booking_sources  
CROSS JOIN (SELECT 'Confirmed' as status UNION SELECT 'Cancelled' UNION SELECT 'No-Show' UNION SELECT 'Completed') reservation_statuses
CROSS JOIN (SELECT 'Business' as guest_type UNION SELECT 'Leisure' UNION SELECT 'Group' UNION SELECT 'Corporate') guest_types
CROSS JOIN (SELECT 'BAR' as rate_code UNION SELECT 'CORP' UNION SELECT 'AAA' UNION SELECT 'GOVT') rate_codes
CROSS JOIN (SELECT 'Best Available Rate' as rate_plan UNION SELECT 'Corporate Rate' UNION SELECT 'AAA Discount' UNION SELECT 'Government Rate') rate_plans
CROSS JOIN (SELECT 'Change of plans' as reason UNION SELECT 'Found better rate' UNION SELECT 'Emergency' UNION SELECT 'Event cancelled') cancellation_reasons
CROSS JOIN (SELECT 'Late checkout please' as request UNION SELECT 'High floor preferred' UNION SELECT 'Quiet room' UNION SELECT 'Airport pickup needed') special_requests

-- Get actual hotel, customer, room type data
JOIN (SELECT HOTEL_ID, ROW_NUMBER() OVER (ORDER BY HOTEL_ID) as rn FROM HOTELS) hotels 
    ON hotels.rn = base_data.hotel_idx
JOIN (SELECT CUSTOMER_ID, ROW_NUMBER() OVER (ORDER BY CUSTOMER_ID) as rn FROM CUSTOMERS) customers 
    ON customers.rn = base_data.customer_idx
JOIN (SELECT ACCOUNT_ID, ROW_NUMBER() OVER (ORDER BY ACCOUNT_ID) as rn FROM CORPORATE_ACCOUNTS) corp_accounts 
    ON corp_accounts.rn = base_data.corp_idx
JOIN (SELECT ROOM_TYPE_ID, ROW_NUMBER() OVER (ORDER BY ROOM_TYPE_ID) as rn FROM ROOM_TYPES WHERE ROOM_TYPE_ID != 'RT009' AND ROOM_TYPE_ID != 'RT010') room_types 
    ON room_types.rn = base_data.room_type_idx

-- Get room rate from daily rates table
JOIN DAILY_ROOM_RATES drr ON drr.HOTEL_ID = hotels.HOTEL_ID 
    AND drr.ROOM_TYPE_ID = room_types.ROOM_TYPE_ID 
    AND drr.RATE_DATE = base_data.check_in_date
    AND drr.RATE_CODE = rate_codes.rate_code

-- Apply probability filters
WHERE UNIFORM(1, 30, RANDOM()) = 1 -- Reduce to manageable size
AND booking_channels.channel = (
    CASE (UNIFORM(1, 10, RANDOM()) % 5)
        WHEN 0 THEN 'Direct'
        WHEN 1 THEN 'OTA' 
        WHEN 2 THEN 'GDS'
        WHEN 3 THEN 'Phone'
        ELSE 'Walk-in'
    END
)
AND booking_sources.source = (
    CASE booking_channels.channel
        WHEN 'Direct' THEN 'Hyatt.com'
        WHEN 'OTA' THEN (CASE UNIFORM(1,3,RANDOM()) WHEN 1 THEN 'Expedia' ELSE 'Booking.com' END)
        WHEN 'Phone' THEN 'Direct Call'
        ELSE 'Walk-in'
    END
)
AND reservation_statuses.status = (
    CASE (UNIFORM(1, 20, RANDOM()))
        WHEN 1 THEN 'Cancelled'
        WHEN 2 THEN 'No-Show'  
        WHEN 19 THEN 'Confirmed'
        ELSE 'Completed'
    END
)
AND guest_types.guest_type = (
    CASE (UNIFORM(1, 10, RANDOM()) % 4)
        WHEN 0 THEN 'Business'
        WHEN 1 THEN 'Leisure'
        WHEN 2 THEN 'Corporate'
        ELSE 'Group'  
    END
)
AND rate_codes.rate_code = (
    CASE 
        WHEN corp_accounts.ACCOUNT_ID IS NOT NULL THEN 'CORP'
        ELSE (CASE (UNIFORM(1, 10, RANDOM()) % 4)
            WHEN 0 THEN 'AAA'
            WHEN 1 THEN 'GOVT'
            ELSE 'BAR'
        END)
    END
)
AND base_data.check_in_date >= '2024-01-01' 
AND base_data.check_in_date <= '2024-12-31'
AND base_data.booking_date <= base_data.check_in_date;

-- 11. GENERATE ANCILLARY SALES (related to reservations)
INSERT INTO ANCILLARY_SALES
SELECT 
    'SALE' || LPAD(ANCILLARY_SALE_SEQ.NEXTVAL, 12, '0'),
    r.RESERVATION_ID,
    r.HOTEL_ID,
    r.CUSTOMER_ID,
    s.SERVICE_ID,
    DATEADD(day, UNIFORM(0, r.NIGHTS-1, RANDOM()), r.CHECK_IN_DATE),
    CASE 
        WHEN s.SERVICE_ID IN ('SVC007', 'SVC008') THEN UNIFORM(1, 3, RANDOM()) -- F&B services
        WHEN s.SERVICE_ID IN ('SVC005', 'SVC006') THEN 1 -- Spa treatments
        ELSE 1
    END,
    s.BASE_PRICE * (1 + (UNIFORM(-20, 40, RANDOM()) / 100.0)), -- Price variation
    (s.BASE_PRICE * (1 + (UNIFORM(-20, 40, RANDOM()) / 100.0))) * 
    CASE 
        WHEN s.SERVICE_ID IN ('SVC007', 'SVC008') THEN UNIFORM(1, 3, RANDOM())
        WHEN s.SERVICE_ID IN ('SVC005', 'SVC006') THEN 1
        ELSE 1
    END,
    0, -- discount_amount
    (s.BASE_PRICE * (1 + (UNIFORM(-20, 40, RANDOM()) / 100.0))) * 
    CASE 
        WHEN s.SERVICE_ID IN ('SVC007', 'SVC008') THEN UNIFORM(1, 3, RANDOM())
        WHEN s.SERVICE_ID IN ('SVC005', 'SVC006') THEN 1
        ELSE 1
    END * 0.1, -- 10% tax
    CASE (UNIFORM(1, 5, RANDOM()))
        WHEN 1 THEN 'Cash'
        WHEN 2 THEN 'Credit Card'
        WHEN 3 THEN 'Room Charge'
        WHEN 4 THEN 'Comp'
        ELSE 'Gift Card'
    END,
    'Completed',
    CURRENT_TIMESTAMP()
FROM RESERVATIONS r
JOIN ANCILLARY_SERVICES s ON UNIFORM(1, 15, RANDOM()) = s.SERVICE_ID[4:]::INT -- Random service selection
WHERE r.RESERVATION_STATUS = 'Completed'
AND UNIFORM(1, 5, RANDOM()) <= 3 -- 60% of completed reservations have ancillary sales
AND r.CHECK_IN_DATE >= '2024-01-01';

-- 12. UPDATE DAILY ROOM RATES with actual sales data
UPDATE DAILY_ROOM_RATES 
SET 
    ROOMS_SOLD = COALESCE(actual_sales.rooms_sold, 0),
    REVENUE_GENERATED = COALESCE(actual_sales.total_revenue, 0)
FROM (
    SELECT 
        r.HOTEL_ID,
        r.ROOM_TYPE_ID, 
        r.CHECK_IN_DATE,
        'BAR' as rate_code,
        SUM(r.ROOMS_BOOKED) as rooms_sold,
        SUM(r.TOTAL_ROOM_REVENUE) as total_revenue
    FROM RESERVATIONS r
    WHERE r.RESERVATION_STATUS IN ('Completed', 'Confirmed')
    GROUP BY r.HOTEL_ID, r.ROOM_TYPE_ID, r.CHECK_IN_DATE
) actual_sales
WHERE DAILY_ROOM_RATES.HOTEL_ID = actual_sales.HOTEL_ID
AND DAILY_ROOM_RATES.ROOM_TYPE_ID = actual_sales.ROOM_TYPE_ID  
AND DAILY_ROOM_RATES.RATE_DATE = actual_sales.CHECK_IN_DATE
AND DAILY_ROOM_RATES.RATE_CODE = actual_sales.rate_code;

-- 13. GENERATE REVENUE SUMMARY DATA
INSERT INTO REVENUE_SUMMARY
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
FROM HOTELS h
CROSS JOIN (
    SELECT DATEADD(day, ROW_NUMBER() OVER (ORDER BY NULL) - 1, '2024-01-01') as date_value
    FROM TABLE(GENERATOR(ROWCOUNT => 365))
) d
LEFT JOIN (
    SELECT HOTEL_ID, SUM(ROOM_COUNT) as total_rooms
    FROM HOTEL_ROOM_INVENTORY 
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
    FROM RESERVATIONS r
    WHERE r.RESERVATION_STATUS IN ('Completed', 'Confirmed')
    GROUP BY r.HOTEL_ID, r.CHECK_IN_DATE
) rs ON h.HOTEL_ID = rs.HOTEL_ID AND d.date_value = rs.CHECK_IN_DATE
LEFT JOIN (
    SELECT 
        a.HOTEL_ID,
        a.SALE_DATE,
        SUM(a.TOTAL_AMOUNT) as ancillary_revenue
    FROM ANCILLARY_SALES a
    WHERE a.TRANSACTION_STATUS = 'Completed'
    GROUP BY a.HOTEL_ID, a.SALE_DATE
) anc ON h.HOTEL_ID = anc.HOTEL_ID AND d.date_value = anc.SALE_DATE;

-- Final data quality checks and statistics
SELECT 'Reservations Created' as metric, COUNT(*) as count FROM RESERVATIONS;
SELECT 'Ancillary Sales Created' as metric, COUNT(*) as count FROM ANCILLARY_SALES;
SELECT 'Daily Rates Created' as metric, COUNT(*) as count FROM DAILY_ROOM_RATES;
SELECT 'Revenue Summary Created' as metric, COUNT(*) as count FROM REVENUE_SUMMARY;

-- Show sample data
SELECT 'Sample Reservations' as section, * FROM RESERVATIONS LIMIT 5;
SELECT 'Sample Revenue Summary' as section, * FROM REVENUE_SUMMARY WHERE TOTAL_REVENUE > 0 LIMIT 5;
