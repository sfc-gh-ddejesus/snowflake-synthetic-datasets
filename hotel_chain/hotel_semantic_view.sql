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

-- Hotel Chain - Snowflake Semantic View (Refactored)
-- Created following Snowflake official example patterns
-- Based on: https://docs.snowflake.com/en/user-guide/views-semantic/example

USE DATABASE SYNTHETIC_DATA;
USE SCHEMA HOTEL_CHAIN;

-- Create the semantic view following Snowflake example patterns
CREATE OR REPLACE SEMANTIC VIEW hotel_revenue_analytics

  TABLES (
    hotels AS HOTEL_CHAIN_HOTELS PRIMARY KEY (hotel_id),
    customers AS HOTEL_CHAIN_CUSTOMERS PRIMARY KEY (customer_id),
    reservations AS HOTEL_CHAIN_RESERVATIONS PRIMARY KEY (reservation_id),
    room_types AS HOTEL_CHAIN_ROOM_TYPES PRIMARY KEY (room_type_id),
    ancillary_sales AS HOTEL_CHAIN_ANCILLARY_SALES PRIMARY KEY (sale_id),
    ancillary_services AS HOTEL_CHAIN_ANCILLARY_SERVICES PRIMARY KEY (service_id)
  )

  RELATIONSHIPS (
    reservations (hotel_id) REFERENCES hotels,
    reservations (customer_id) REFERENCES customers,
    reservations (room_type_id) REFERENCES room_types,
    ancillary_sales (reservation_id) REFERENCES reservations,
    ancillary_sales (service_id) REFERENCES ancillary_services,
    ancillary_sales (hotel_id) REFERENCES hotels,
    ancillary_sales (customer_id) REFERENCES customers
  )

  FACTS (
    -- Basic reservation facts (following example pattern)
    reservations.reservation_id AS reservation_id,
    reservations.nights AS nights,
    reservations.total_room_revenue AS total_room_revenue,
    reservations.total_amount AS total_amount,
    reservations.adults_count AS adults_count,
    reservations.children_count AS children_count,
    reservations.rooms_booked AS rooms_booked,
    
    -- Calculated facts (following example pattern)
    hotels.hotel_reservation_count AS COUNT(reservations.reservation_id),
    customers.customer_reservation_count AS COUNT(reservations.reservation_id),
    
    -- Ancillary sales facts
    ancillary_sales.sale_id AS sale_id,
    ancillary_sales.quantity AS quantity,
    ancillary_sales.total_amount AS ancillary_amount,
    ancillary_sales.unit_price AS unit_price
  )

  DIMENSIONS (
    -- Hotel dimensions (following example pattern)
    hotels.hotel_name AS hotel_name,
    hotels.brand AS brand,
    hotels.city AS city,
    hotels.country AS hotel_country,
    hotels.region AS region,
    
    -- Customer dimensions
    customers.loyalty_tier AS loyalty_tier,
    customers.country AS guest_country,
    customers.gender AS gender,
    
    -- Reservation dimensions
    reservations.check_in_date AS check_in_date,
    reservations.check_out_date AS check_out_date,
    reservations.booking_date AS booking_date,
    reservations.booking_channel AS booking_channel,
    reservations.reservation_status AS reservation_status,
    reservations.guest_type AS guest_type,
    
    -- Room type dimensions
    room_types.room_type_name AS room_type_name,
    room_types.room_category AS room_category,
    
    -- Service dimensions
    ancillary_services.service_name AS service_name,
    ancillary_services.service_category AS service_category,
    ancillary_sales.sale_date AS sale_date
  )

  METRICS (
    -- Hotel metrics (following example pattern)
    hotels.hotel_count AS COUNT(hotels.hotel_id),
    hotels.total_hotel_reservations AS SUM(hotels.hotel_reservation_count),
    hotels.average_reservations_per_hotel AS AVG(hotels.hotel_reservation_count),
    
    -- Customer metrics
    customers.customer_count AS COUNT(customers.customer_id),
    customers.total_customer_reservations AS SUM(customers.customer_reservation_count),
    customers.average_reservations_per_customer AS AVG(customers.customer_reservation_count),
    
    -- Reservation metrics
    reservations.total_reservations AS COUNT(reservations.reservation_id),
    reservations.total_room_nights AS SUM(reservations.nights),
    reservations.total_revenue_sum AS SUM(reservations.total_room_revenue),
    reservations.total_booking_revenue AS SUM(reservations.total_amount),
    reservations.average_daily_rate AS AVG(reservations.total_room_revenue / reservations.nights),
    reservations.average_length_of_stay AS AVG(reservations.nights),
    
    -- Ancillary metrics
    ancillary_sales.total_ancillary_revenue AS SUM(ancillary_sales.ancillary_amount),
    ancillary_sales.ancillary_transaction_count AS COUNT(ancillary_sales.sale_id),
    ancillary_sales.average_ancillary_spend AS AVG(ancillary_sales.ancillary_amount)
  )

  COMMENT = 'Hotel revenue analytics semantic view - restructured following Snowflake example patterns';

-- Grant appropriate permissions for Cortex Analyst usage
GRANT REFERENCES, SELECT ON SEMANTIC VIEW hotel_revenue_analytics TO ROLE ACCOUNTADMIN;

-- Grant privileges to DEMO_ROLE
GRANT SELECT ON SEMANTIC VIEW hotel_revenue_analytics TO ROLE DEMO_ROLE;
GRANT USAGE ON SEMANTIC VIEW hotel_revenue_analytics TO ROLE DEMO_ROLE;

-- Validation query
SELECT 'Semantic view created successfully following Snowflake example patterns' as status;

-- Show available dimensions and metrics
SHOW SEMANTIC DIMENSIONS FOR SEMANTIC VIEW hotel_revenue_analytics;
SHOW SEMANTIC METRICS FOR SEMANTIC VIEW hotel_revenue_analytics;
