# Hotel Chain Semantic View Guide

## Overview

This guide explains how to use the **Snowflake Semantic View** created for the hotel chain dataset. The semantic view enables natural language queries through Cortex Analyst and provides a business-friendly layer over the hotel revenue data.

## Semantic View: `hotel_revenue_analytics`

### What is a Semantic View?

A [Snowflake Semantic View](https://docs.snowflake.com/en/user-guide/views-semantic/sql) is a business-oriented layer that defines:
- **Logical tables** with business-friendly names and synonyms
- **Relationships** between tables 
- **Facts** for calculations and aggregations
- **Dimensions** for grouping and filtering
- **Metrics** for key business measurements

This enables:
✅ **Natural language queries** with Cortex Analyst  
✅ **Business-friendly terminology** with synonyms  
✅ **Automated join logic** across related tables  
✅ **Pre-defined calculations** for common metrics  

## Key Components

### 📊 **Logical Tables**
- **hotels** (properties, locations, establishments)
- **customers** (guests, travelers, clients) 
- **reservations** (bookings, stays)
- **room_types** (accommodation types)
- **corporate_accounts** (business accounts)
- **ancillary_sales** (additional services)
- **revenue_summary** (daily performance)

### 🔗 **Relationships** 
Automatically handles joins between:
- Reservations → Hotels, Customers, Room Types, Corporate Accounts
- Ancillary Sales → Reservations, Services, Hotels, Customers
- Revenue Summary → Hotels

### 📈 **Key Metrics Available**

#### Revenue Metrics
- **Total Room Revenue**: `reservations.total_room_revenue`
- **Total Booking Revenue**: `reservations.total_booking_revenue` 
- **Average Daily Rate (ADR)**: `reservations.average_daily_rate`
- **Revenue Per Available Room (RevPAR)**: `revenue_summary.average_revpar`
- **Ancillary Revenue**: `ancillary_sales.total_ancillary_revenue`

#### Operational Metrics  
- **Occupancy Rate**: `revenue_summary.average_occupancy`
- **Length of Stay**: `reservations.average_length_of_stay`
- **Lead Time**: `reservations.average_lead_time`
- **Cancellation Rate**: `reservations.cancellation_rate`

#### Customer Metrics
- **Customer Count**: `customers.unique_customers`
- **Repeat Customers**: `customers.repeat_customers`
- **Customer Lifetime Value**: `customers.average_customer_value`

### 🏷️ **Key Dimensions**

#### Geographic
- **Region**: `hotels.region` (Americas, ASPAC, EAME)
- **Country**: `hotels.country`
- **City**: `hotels.city`

#### Property Attributes
- **Brand**: `hotels.brand` (Grand, Park, Regency, etc.)
- **Market Segment**: `hotels.market_segment` (Luxury, Premium, Select)
- **Property Type**: `hotels.property_type` (Urban, Resort, Airport)

#### Customer Attributes  
- **Loyalty Tier**: `customers.loyalty_tier` (Bronze, Silver, Gold, Platinum)
- **Guest Type**: `reservations.guest_type` (Business, Leisure, Corporate, Group)

#### Time Dimensions
- **Check-in Date**: `reservations.check_in_date`
- **Year/Month/Quarter**: `reservations.check_in_year`, `check_in_month`, `check_in_quarter`
- **Booking Channel**: `reservations.booking_channel` (Direct, OTA, GDS)

## Usage Examples

### 1. **Setup and Validation**
```sql
-- Create the semantic view
@hotel_semantic_view.sql

-- Validate creation
SHOW SEMANTIC VIEWS LIKE 'hotel_revenue_analytics';

-- View available dimensions and metrics
SHOW SEMANTIC DIMENSIONS FOR SEMANTIC VIEW hotel_revenue_analytics;
SHOW SEMANTIC METRICS FOR SEMANTIC VIEW hotel_revenue_analytics;
```

### 2. **Query with SEMANTIC_VIEW() Function**
```sql
-- Revenue by brand and region
SELECT 
  brand,
  region,
  SUM(total_room_revenue) as revenue
FROM SEMANTIC_VIEW(hotel_revenue_analytics)
GROUP BY brand, region
ORDER BY revenue DESC;

-- Monthly occupancy trends
SELECT 
  check_in_month,
  AVG(occupancy_rate) as avg_occupancy,
  COUNT(reservation_id) as bookings
FROM SEMANTIC_VIEW(hotel_revenue_analytics)  
GROUP BY check_in_month
ORDER BY check_in_month;

-- Top performing hotels by RevPAR
SELECT
  hotel_name,
  city,
  market_segment,
  AVG(revpar) as avg_revpar
FROM SEMANTIC_VIEW(hotel_revenue_analytics)
GROUP BY hotel_name, city, market_segment
ORDER BY avg_revpar DESC
LIMIT 10;
```

### 3. **Cortex Analyst Natural Language Queries**

With the semantic view, you can ask questions in natural language:

- *"What is the revenue by hotel brand this year?"*
- *"Show me occupancy rates by region and month"*  
- *"Which loyalty tiers generate the most revenue?"*
- *"What is the cancellation rate by booking channel?"*
- *"Compare ADR between luxury and premium properties"*
- *"Show ancillary revenue penetration by hotel type"*

### 4. **Advanced Analytics Examples**

```sql
-- Customer segmentation analysis
SELECT
  loyalty_tier,
  guest_type,
  COUNT(DISTINCT customer_id) as customers,
  AVG(total_amount) as avg_spend,
  AVG(nights) as avg_stay_length
FROM SEMANTIC_VIEW(hotel_revenue_analytics)
WHERE reservation_status = 'Completed'
GROUP BY loyalty_tier, guest_type;

-- Seasonal performance analysis  
SELECT
  market_segment,
  check_in_quarter,
  AVG(occupancy_rate) as avg_occupancy,
  AVG(adr) as avg_daily_rate,
  SUM(total_revenue) as total_revenue
FROM SEMANTIC_VIEW(hotel_revenue_analytics)
GROUP BY market_segment, check_in_quarter
ORDER BY market_segment, check_in_quarter;

-- Booking channel effectiveness
SELECT
  booking_channel,
  COUNT(*) as total_bookings,
  COUNT(CASE WHEN reservation_status = 'Completed' THEN 1 END) as completed,
  AVG(advance_booking_days) as avg_lead_time,
  AVG(total_amount) as avg_booking_value
FROM SEMANTIC_VIEW(hotel_revenue_analytics)
GROUP BY booking_channel;
```

## Business Questions Enabled

The semantic view enables analysts to easily answer questions like:

1. **Revenue Analysis**
   - Which hotels/brands/regions drive the most revenue?
   - How does ADR vary by market segment and season?
   - What's the contribution of ancillary revenue by service type?

2. **Operational Performance**  
   - What are occupancy trends by property type?
   - How do booking lead times affect cancellation rates?
   - Which room types have the highest utilization?

3. **Customer Insights**
   - How does spending vary by loyalty tier?
   - What's the repeat customer rate by region?
   - Which guest types book furthest in advance?

4. **Channel Performance**
   - Which booking channels have the highest conversion?
   - How does direct vs OTA bookings compare on revenue?
   - What's the cancellation rate by booking source?

## Privileges and Access

To use the semantic view:

```sql
-- Grant basic access
GRANT REFERENCES, SELECT ON SEMANTIC VIEW hotel_revenue_analytics TO ROLE <your_role>;

-- For Cortex Analyst (requires both privileges)
GRANT REFERENCES, SELECT ON SEMANTIC VIEW hotel_revenue_analytics TO ROLE <analyst_role>;

-- Future grants for new semantic views
GRANT REFERENCES, SELECT ON FUTURE SEMANTIC VIEWS IN SCHEMA SALES_REVENUE TO ROLE <analyst_role>;
```

## Best Practices

1. **Use Synonyms**: The semantic view includes business-friendly synonyms - use terms like "properties" instead of "hotels" or "guests" instead of "customers"

2. **Leverage Metrics**: Use pre-defined metrics like `average_daily_rate` instead of calculating `SUM(revenue)/SUM(nights)` manually

3. **Natural Language**: With Cortex Analyst, ask questions naturally rather than writing SQL

4. **Performance**: The semantic view handles join optimization automatically - let it manage table relationships

5. **Documentation**: Reference this guide and the Snowflake semantic views documentation for advanced usage

## Resources

- [Snowflake Semantic Views Documentation](https://docs.snowflake.com/en/user-guide/views-semantic/sql)
- [Cortex Analyst Guide](https://docs.snowflake.com/en/user-guide/snowflake-cortex/cortex-analyst)
- [Semantic View SQL Reference](https://docs.snowflake.com/en/sql-reference/sql/create-semantic-view)

This semantic view transforms the hotel dataset into a powerful, business-friendly analytics platform optimized for Snowflake's AI and analytics capabilities.
