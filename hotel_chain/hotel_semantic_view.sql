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

-- Hotel Chain - Snowflake Semantic View
-- Creates a semantic layer for hotel sales and revenue management analytics
-- Optimized for Snowflake Cortex Analyst and business intelligence

USE DATABASE SYNTHETIC_DATA;
USE SCHEMA HOTEL_CHAIN;

-- Create the main semantic view for hotel revenue analysis
CREATE OR REPLACE SEMANTIC VIEW hotel_revenue_analytics

  TABLES (
    hotels AS HOTEL_CHAIN_HOTELS
      PRIMARY KEY (hotel_id)
      WITH SYNONYMS ('properties', 'locations', 'establishments')
      COMMENT = 'Master table of all hotel properties across regions',
      
    customers AS HOTEL_CHAIN_CUSTOMERS
      PRIMARY KEY (customer_id)
      WITH SYNONYMS ('guests', 'travelers', 'clients')
      COMMENT = 'Customer master data with loyalty program information',
      
    reservations AS HOTEL_CHAIN_RESERVATIONS
      PRIMARY KEY (reservation_id)
      WITH SYNONYMS ('bookings', 'stays', 'reservations')
      COMMENT = 'All hotel reservations and booking details',
      
    room_types AS HOTEL_CHAIN_ROOM_TYPES
      PRIMARY KEY (room_type_id)
      WITH SYNONYMS ('room categories', 'accommodation types')
      COMMENT = 'Different room categories and their specifications',
      
    corporate_accounts AS HOTEL_CHAIN_CORPORATE_ACCOUNTS
      PRIMARY KEY (account_id)
      WITH SYNONYMS ('corporate clients', 'business accounts', 'enterprise customers')
      COMMENT = 'Corporate and group booking accounts',
      
    ancillary_sales AS HOTEL_CHAIN_ANCILLARY_SALES
      PRIMARY KEY (sale_id)
      WITH SYNONYMS ('additional services', 'extra services', 'add-ons')
      COMMENT = 'Sales of additional hotel services and amenities',
      
    ancillary_services AS HOTEL_CHAIN_ANCILLARY_SERVICES
      PRIMARY KEY (service_id)
      WITH SYNONYMS ('services', 'amenities', 'extras')
      COMMENT = 'Available ancillary services and their pricing',
      
    revenue_summary AS HOTEL_CHAIN_REVENUE_SUMMARY
      PRIMARY KEY (hotel_id, business_date)
      WITH SYNONYMS ('daily performance', 'hotel metrics', 'kpi summary')
      COMMENT = 'Daily revenue and performance metrics by hotel'
  )

  RELATIONSHIPS (
    reservations_to_hotels AS
      reservations (hotel_id) REFERENCES hotels,
    reservations_to_customers AS
      reservations (customer_id) REFERENCES customers,
    reservations_to_room_types AS
      reservations (room_type_id) REFERENCES room_types,
    reservations_to_corporate AS
      reservations (corporate_account_id) REFERENCES corporate_accounts,
    ancillary_to_reservations AS
      ancillary_sales (reservation_id) REFERENCES reservations,
    ancillary_to_services AS
      ancillary_sales (service_id) REFERENCES ancillary_services,
    ancillary_to_hotels AS
      ancillary_sales (hotel_id) REFERENCES hotels,
    ancillary_to_customers AS
      ancillary_sales (customer_id) REFERENCES customers,
    revenue_to_hotels AS
      revenue_summary (hotel_id) REFERENCES hotels
  )

  FACTS (
    -- Reservation Facts
    reservations.nights AS nights,
    reservations.total_room_revenue AS reservation_room_revenue,
    reservations.total_amount AS booking_value,
    reservations.taxes AS taxes,
    reservations.fees AS fees,
    reservations.adults_count AS adults,
    reservations.children_count AS children,
    reservations.rooms_booked AS rooms_reserved,
    reservations.loyalty_points_earned AS reservation_loyalty_points,
    reservations.advance_booking_days AS booking_lead_time,
    
    -- Ancillary Sales Facts  
    ancillary_sales.quantity AS sale_quantity,
    ancillary_sales.total_amount AS sale_amount,
    ancillary_sales.unit_price AS sale_unit_price,
    ancillary_sales.tax_amount AS sale_tax,
    ancillary_sales.discount_amount AS sale_discount_amount,
    
    -- Revenue Summary Facts
    revenue_summary.total_rooms_available AS total_rooms_available,
    revenue_summary.rooms_sold AS rooms_sold,
    revenue_summary.occupancy_percentage AS occupancy_rate,
    revenue_summary.average_daily_rate AS adr,
    revenue_summary.revenue_per_room AS revpar,
    revenue_summary.room_revenue AS summary_room_revenue,
    revenue_summary.ancillary_revenue AS summary_ancillary_revenue,
    revenue_summary.total_revenue AS total_revenue,
    revenue_summary.walk_in_rooms AS walk_in_rooms,
    revenue_summary.group_rooms AS group_rooms,
    revenue_summary.corporate_rooms AS corporate_rooms,
    revenue_summary.leisure_rooms AS leisure_rooms
  )

  DIMENSIONS (
    -- Hotel Dimensions
    hotels.hotel_name AS hotel_name
      WITH SYNONYMS = ('property name', 'hotel')
      COMMENT = 'Name of the hotel property',
    hotels.brand AS brand
      WITH SYNONYMS = ('hotel brand', 'chain')
      COMMENT = 'Hotel brand (Grand, Park, Regency, etc.)',
    hotels.city AS city
      WITH SYNONYMS = ('location', 'destination')
      COMMENT = 'City where the hotel is located',
    hotels.state_province AS state_province
      WITH SYNONYMS = ('state', 'province', 'region')
      COMMENT = 'State or province of the hotel',
    hotels.country AS country
      WITH SYNONYMS = ('nation')
      COMMENT = 'Country where the hotel is located',
    hotels.region AS region
      WITH SYNONYMS = ('geographic region', 'area')
      COMMENT = 'Geographic region (Americas, ASPAC, EAME)',
    hotels.market_segment AS market_segment
      WITH SYNONYMS = ('segment', 'tier')
      COMMENT = 'Hotel market segment (Luxury, Premium, Select)',
    hotels.property_type AS property_type
      WITH SYNONYMS = ('hotel type')
      COMMENT = 'Type of property (Urban, Resort, Airport, Convention)',
    hotels.total_rooms AS total_rooms
      COMMENT = 'Total number of rooms in the hotel',
    hotels.opening_date AS opening_date
      COMMENT = 'Date when the hotel opened',
      
    -- Customer Dimensions
    customers.loyalty_tier AS loyalty_tier
      WITH SYNONYMS = ('loyalty status', 'member tier', 'elite status')
      COMMENT = 'Customer loyalty program tier (Bronze, Silver, Gold, Platinum)',
    customers.country AS customer_country
      WITH SYNONYMS = ('guest country', 'nationality')
      COMMENT = 'Country of the customer',
    customers.gender AS gender
      COMMENT = 'Customer gender',
    customers.loyalty_points AS customer_loyalty_balance
      WITH SYNONYMS = ('points balance', 'rewards points')
      COMMENT = 'Current loyalty points balance',
      
    -- Reservation Dimensions
    reservations.check_in_date AS check_in_date
      WITH SYNONYMS = ('arrival date', 'start date')
      COMMENT = 'Date when the guest checks in',
    reservations.check_out_date AS check_out_date
      WITH SYNONYMS = ('departure date', 'end date')
      COMMENT = 'Date when the guest checks out',
    reservations.booking_date AS booking_date
      WITH SYNONYMS = ('reservation date', 'purchase date')
      COMMENT = 'Date when the reservation was made',
    reservations.booking_channel AS booking_channel
      WITH SYNONYMS = ('channel', 'source channel')
      COMMENT = 'Channel used to make the booking (Direct, OTA, GDS, Phone, Walk-in)',
    reservations.booking_source AS booking_source
      WITH SYNONYMS = ('source', 'platform')
      COMMENT = 'Specific booking source (Direct.com, Expedia, Booking.com, etc.)',
    reservations.reservation_status AS reservation_status
      WITH SYNONYMS = ('booking status', 'status')
      COMMENT = 'Status of the reservation (Confirmed, Cancelled, No-Show, Completed)',
    reservations.guest_type AS guest_type
      WITH SYNONYMS = ('traveler type', 'customer segment')
      COMMENT = 'Type of guest (Business, Leisure, Group, Corporate)',
    reservations.rate_code AS rate_code
      WITH SYNONYMS = ('rate plan', 'pricing code')
      COMMENT = 'Rate code used for pricing (BAR, CORP, AAA, GOVT)',
    reservations.currency_code AS currency_code
      COMMENT = 'Currency used for the transaction',
      
    -- Time Dimensions (simplified - using base date columns only)
    -- Note: Time hierarchy functions like YEAR(), MONTH() should be handled by BI tools
      
    -- Room Type Dimensions
    room_types.room_type_name AS room_type_name
      WITH SYNONYMS = ('room type', 'accommodation type')
      COMMENT = 'Name of the room type',
    room_types.room_category AS room_category
      WITH SYNONYMS = ('category', 'room class')
      COMMENT = 'Category of room (Standard, Premium, Suite, Executive)',
    room_types.amenities_tier AS amenities_tier
      WITH SYNONYMS = ('amenity level', 'service level')
      COMMENT = 'Level of amenities (Basic, Enhanced, Luxury)',
    room_types.base_occupancy AS base_occupancy
      COMMENT = 'Standard occupancy for the room type',
    room_types.max_occupancy AS max_occupancy
      COMMENT = 'Maximum occupancy for the room type',
      
    -- Corporate Account Dimensions
    corporate_accounts.company_name AS company_name
      WITH SYNONYMS = ('corporation', 'business name')
      COMMENT = 'Name of the corporate account',
    corporate_accounts.industry AS industry
      WITH SYNONYMS = ('business sector', 'vertical')
      COMMENT = 'Industry of the corporate account',
    corporate_accounts.contract_type AS contract_type
      WITH SYNONYMS = ('agreement type')
      COMMENT = 'Type of corporate contract',
    corporate_accounts.account_status AS account_status
      COMMENT = 'Status of the corporate account',
      
    -- Service Dimensions
    ancillary_services.service_name AS service_name
      WITH SYNONYMS = ('service', 'amenity name')
      COMMENT = 'Name of the ancillary service',
    ancillary_services.service_category AS service_category
      WITH SYNONYMS = ('category', 'service type')
      COMMENT = 'Category of service (F&B, Spa, Business, Recreation, Transportation)',
    ancillary_sales.sale_date AS sale_date
      WITH SYNONYMS = ('purchase date', 'transaction date', 'service date')
      COMMENT = 'Date when the service was purchased',
    ancillary_sales.payment_method AS payment_method
      WITH SYNONYMS = ('payment type')
      COMMENT = 'Method of payment for the service',
      
    -- Revenue Summary Dimensions
    revenue_summary.business_date AS business_date
      WITH SYNONYMS = ('date', 'performance date')
      COMMENT = 'Business date for the revenue summary'
    -- Note: Date hierarchy functions removed - should be handled by BI tools
  )

  METRICS (
    -- Reservation Metrics
    reservations.total_reservations AS COUNT(reservations.reservation_id)
      WITH SYNONYMS = ('booking count', 'number of reservations')
      COMMENT = 'Total number of reservations',
    reservations.completed_reservations AS COUNT(CASE WHEN reservations.reservation_status = 'Completed' THEN reservations.reservation_id END)
      WITH SYNONYMS = ('completed stays', 'successful bookings')
      COMMENT = 'Number of completed reservations',
    reservations.cancelled_reservations AS COUNT(CASE WHEN reservations.reservation_status = 'Cancelled' THEN reservations.reservation_id END)
      WITH SYNONYMS = ('cancellations')
      COMMENT = 'Number of cancelled reservations',
    reservations.no_show_reservations AS COUNT(CASE WHEN reservations.reservation_status = 'No-Show' THEN reservations.reservation_id END)
      WITH SYNONYMS = ('no shows')
      COMMENT = 'Number of no-show reservations',
    reservations.total_room_nights AS SUM(reservations.nights)
      WITH SYNONYMS = ('room nights', 'total nights')
      COMMENT = 'Total number of room nights',
    reservations.aggregated_room_revenue AS SUM(reservations.total_room_revenue)
      WITH SYNONYMS = ('room revenue', 'accommodation revenue', 'total room revenue')
      COMMENT = 'Total revenue from room sales',
    reservations.total_booking_revenue AS SUM(reservations.total_amount)
      WITH SYNONYMS = ('total revenue', 'booking revenue')
      COMMENT = 'Total booking revenue including taxes and fees',
    reservations.reservation_adr AS AVG(reservations.total_room_revenue / reservations.nights)
      WITH SYNONYMS = ('ADR', 'average rate', 'reservation ADR')
      COMMENT = 'Average daily rate across all reservations',
    reservations.average_length_of_stay AS AVG(reservations.nights)
      WITH SYNONYMS = ('ALOS', 'average stay duration')
      COMMENT = 'Average length of stay in nights',
    reservations.average_lead_time AS AVG(reservations.advance_booking_days)
      WITH SYNONYMS = ('booking lead time', 'advance booking')
      COMMENT = 'Average number of days between booking and check-in',
    reservations.cancellation_rate AS (COUNT(CASE WHEN reservations.reservation_status = 'Cancelled' THEN reservations.reservation_id END) * 100.0 / COUNT(reservations.reservation_id))
      WITH SYNONYMS = ('cancellation percentage')
      COMMENT = 'Percentage of reservations that were cancelled',
      
    -- Customer Metrics
    customers.unique_customers AS COUNT(DISTINCT customers.customer_id)
      WITH SYNONYMS = ('customer count', 'guest count')
      COMMENT = 'Number of unique customers',
    customers.customer_retention_rate AS (COUNT(DISTINCT customers.customer_id) * 100.0 / COUNT(DISTINCT customers.customer_id))
      WITH SYNONYMS = ('retention rate', 'customer loyalty rate')
      COMMENT = 'Customer retention rate percentage',
    customers.average_customer_value AS AVG(reservations.total_amount)
      WITH SYNONYMS = ('customer lifetime value', 'CLV', 'average booking value')
      COMMENT = 'Average booking value per customer',
      
    -- Hotel Performance Metrics
    hotels.unique_hotels AS COUNT(DISTINCT hotels.hotel_id)
      WITH SYNONYMS = ('property count', 'hotel count')
      COMMENT = 'Number of unique hotels',
    hotels.average_hotel_revenue AS AVG(reservations.total_amount)
      WITH SYNONYMS = ('revenue per hotel', 'average booking revenue')
      COMMENT = 'Average booking revenue per hotel',
      
    -- Ancillary Revenue Metrics
    ancillary_sales.total_ancillary_revenue AS SUM(ancillary_sales.total_amount)
      WITH SYNONYMS = ('ancillary revenue', 'service revenue', 'additional revenue')
      COMMENT = 'Total revenue from ancillary services',
    ancillary_sales.ancillary_transactions AS COUNT(ancillary_sales.sale_id)
      WITH SYNONYMS = ('service transactions', 'ancillary purchases')
      COMMENT = 'Number of ancillary service transactions',
    ancillary_sales.average_ancillary_spend AS AVG(ancillary_sales.total_amount)
      WITH SYNONYMS = ('average service spend')
      COMMENT = 'Average spending per ancillary transaction',
    ancillary_sales.ancillary_penetration AS (COUNT(DISTINCT ancillary_sales.reservation_id) * 100.0 / COUNT(DISTINCT reservations.reservation_id))
      WITH SYNONYMS = ('service penetration rate', 'ancillary penetration rate')
      COMMENT = 'Percentage of reservations with ancillary purchases',
      
    -- Revenue Summary Metrics
    revenue_summary.total_available_rooms AS SUM(revenue_summary.total_rooms_available)
      WITH SYNONYMS = ('room inventory', 'available inventory')
      COMMENT = 'Total available room inventory',
    revenue_summary.total_rooms_sold AS SUM(revenue_summary.rooms_sold)
      WITH SYNONYMS = ('occupied rooms')
      COMMENT = 'Total number of rooms sold',
    revenue_summary.average_occupancy AS AVG(revenue_summary.occupancy_rate)
      WITH SYNONYMS = ('occupancy rate', 'utilization')
      COMMENT = 'Average occupancy rate across all hotels',
    revenue_summary.total_hotel_revenue AS SUM(revenue_summary.total_revenue)
      WITH SYNONYMS = ('total revenue', 'hotel revenue')
      COMMENT = 'Total revenue across all hotels',
    revenue_summary.average_revpar AS AVG(revenue_summary.revpar)
      WITH SYNONYMS = ('RevPAR', 'revenue per available room')
      COMMENT = 'Average revenue per available room',
    revenue_summary.average_adr AS AVG(revenue_summary.adr)
      WITH SYNONYMS = ('ADR', 'average daily rate')
      COMMENT = 'Average daily rate from revenue summary'
  )

  COMMENT = 'Comprehensive semantic view for hotel revenue analytics and business intelligence';

-- Grant appropriate permissions for Cortex Analyst usage
GRANT REFERENCES, SELECT ON SEMANTIC VIEW hotel_revenue_analytics TO ROLE ACCOUNTADMIN;

-- Example query to validate the semantic view
SELECT 'Semantic view created successfully' as status;

-- Grant privileges to DEMO_ROLE
GRANT SELECT ON SEMANTIC VIEW hotel_revenue_analytics TO ROLE DEMO_ROLE;
GRANT USAGE ON SEMANTIC VIEW hotel_revenue_analytics TO ROLE DEMO_ROLE;

-- Show available dimensions and metrics
SHOW SEMANTIC DIMENSIONS FOR SEMANTIC VIEW hotel_revenue_analytics;
SHOW SEMANTIC METRICS FOR SEMANTIC VIEW hotel_revenue_analytics;
