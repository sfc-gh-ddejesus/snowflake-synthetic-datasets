# Hotel Chain - Sales & Revenue Management Data Model for Snowflake

## Overview

This project provides a comprehensive synthetic dataset and data model specifically designed for **Snowflake Data Cloud**. The dataset includes realistic hotel operations data with over 15,000 reservation records and associated ancillary sales, optimized for Snowflake's architecture and SQL capabilities.

## Project Components

### 1. Database Schema (`hotel_schema_ddl.sql`)
- **12 core tables** with proper relationships and constraints
- **Indexes** for optimized query performance  
- **Views** for common business queries
- **Foreign key relationships** maintaining data integrity

### 2. Data Generation Scripts
- **Base Data** (`hotel_data_generation.sql`): Hotels, customers, room types, services
- **Transactions** (`hotel_reservations_generation.sql`): 15,000+ reservations and sales records
- **Revenue Data**: Daily rates, occupancy, and performance metrics

### 3. Business Analysis (`hotel_business_questions.sql`)
- **20+ analytical questions** with complete SQL queries
- **Performance metrics**: RevPAR, ADR, occupancy analysis
- **Customer insights**: Loyalty, segmentation, lifetime value
- **Revenue optimization**: Pricing, demand forecasting

## Data Model Architecture

### Core Business Entities

#### Hotels & Inventory
- **HOTELS**: 25 properties across Americas, ASPAC, EAME regions
- **ROOM_TYPES**: 10 different room categories (Standard to Presidential Suite)
- **HOTEL_ROOM_INVENTORY**: Room allocation by hotel and type
- **COMPETITIVE_SET**: Competitor analysis data

#### Customers & Accounts
- **CUSTOMERS**: 5,000 customer profiles with loyalty tiers
- **CORPORATE_ACCOUNTS**: 10 major corporate clients with negotiated rates
- **Loyalty Programs**: Bronze, Silver, Gold, Platinum

#### Reservations & Sales
- **RESERVATIONS**: Primary booking table with 15,000+ records
- **ANCILLARY_SALES**: Additional services and amenities purchases
- **DAILY_ROOM_RATES**: Dynamic pricing and inventory management
- **REVENUE_SUMMARY**: Daily performance rollups

#### Operational Data
- **ANCILLARY_SERVICES**: 15 service categories (F&B, Spa, Business, etc.)
- **EVENTS_CALENDAR**: Local events impacting demand
- **Market Analysis**: Regional and seasonal performance data

### Key Metrics Included

#### Financial Performance
- **Revenue Per Available Room (RevPAR)**
- **Average Daily Rate (ADR)**  
- **Occupancy Rates**
- **Ancillary Revenue Penetration**
- **Corporate Account Performance**

#### Customer Analytics
- **Customer Lifetime Value**
- **Loyalty Program Effectiveness**
- **Booking Channel Performance**
- **Repeat Guest Analysis**

#### Operational Efficiency
- **Cancellation and No-Show Rates**
- **Lead Time Analysis**
- **Room Type Utilization**
- **Seasonal Demand Patterns**

## Installation Instructions

### Prerequisites
- Snowflake account with CREATE privileges
- Sufficient warehouse credits for data generation (recommended: Large warehouse)

### Setup Steps

1. **Create Database Structure**
   ```sql
   -- Run the DDL script
   @hotel_schema_ddl.sql
   ```

2. **Generate Base Data**
   ```sql
   -- Run base data generation
   @hotel_data_generation.sql
   ```

3. **Generate Transaction Data**
   ```sql
   -- Run reservation and sales data generation (15,000+ records)
   @hotel_reservations_generation.sql
   ```

4. **Verify Data Quality**
   ```sql
   -- Check record counts
   SELECT 'Hotels' as table_name, COUNT(*) as record_count FROM HOTELS
   UNION ALL
   SELECT 'Customers', COUNT(*) FROM CUSTOMERS
   UNION ALL  
   SELECT 'Reservations', COUNT(*) FROM RESERVATIONS
   UNION ALL
   SELECT 'Ancillary Sales', COUNT(*) FROM ANCILLARY_SALES;
   ```

### Expected Data Volumes
- **Hotels**: 25 properties
- **Customers**: 5,000 profiles
- **Reservations**: ~15,000 bookings
- **Ancillary Sales**: ~9,000 transactions
- **Daily Rates**: ~73,000 rate records (365 days × 25 hotels × 8 room types)
- **Revenue Summary**: ~9,125 daily summaries

## Business Questions & Analytics

The project includes 20+ business analyst questions covering:

### Revenue Performance (Questions 1-3)
- Monthly revenue trends by brand and region
- Hotel performance vs competitive benchmarks  
- Ancillary revenue contribution analysis

### Customer Behavior (Questions 4-6)  
- Customer lifetime value by loyalty tier
- Ancillary service purchase propensity
- Booking lead time patterns

### Operational Efficiency (Questions 7-8)
- Cancellation rates by channel and lead time
- Room type utilization analysis

### Pricing & Revenue Management (Questions 9-10)
- Dynamic pricing effectiveness
- Price elasticity analysis

### Corporate & Group Business (Questions 11-12)
- Corporate account value analysis
- Geographic distribution of business travel

### Market Analysis (Questions 13-14)
- Seasonal demand patterns
- Event impact on performance

### Digital Channels (Questions 15-16)
- Booking channel ROI analysis
- Loyalty program effectiveness

### Operational Insights (Questions 17-18)
- Guest satisfaction drivers
- Hotel efficiency metrics

### Forecasting (Questions 19-20)
- Demand forecasting models
- Growth opportunity analysis

## Sample Queries

### Revenue Performance by Brand
```sql
SELECT 
    h.BRAND,
    COUNT(DISTINCT h.HOTEL_ID) as HOTEL_COUNT,
    AVG(rs.OCCUPANCY_RATE) as AVG_OCCUPANCY,
    AVG(rs.ADR) as AVG_DAILY_RATE,
    AVG(rs.REVPAR) as AVG_REVPAR,
    SUM(rs.TOTAL_REVENUE) as TOTAL_REVENUE
FROM HOTELS h
JOIN REVENUE_SUMMARY rs ON h.HOTEL_ID = rs.HOTEL_ID
WHERE rs.BUSINESS_DATE >= DATEADD('month', -3, CURRENT_DATE())
GROUP BY h.BRAND
ORDER BY AVG_REVPAR DESC;
```

### Customer Lifetime Value Analysis
```sql
SELECT 
    c.LOYALTY_TIER,
    COUNT(DISTINCT c.CUSTOMER_ID) as CUSTOMER_COUNT,
    AVG(customer_metrics.total_spend) as AVG_LIFETIME_VALUE,
    AVG(customer_metrics.stay_count) as AVG_STAYS_PER_CUSTOMER
FROM CUSTOMERS c
JOIN (
    SELECT 
        CUSTOMER_ID,
        COUNT(*) as stay_count,
        SUM(TOTAL_AMOUNT) as total_spend
    FROM RESERVATIONS 
    WHERE RESERVATION_STATUS = 'Completed'
    GROUP BY CUSTOMER_ID
) customer_metrics ON c.CUSTOMER_ID = customer_metrics.CUSTOMER_ID
GROUP BY c.LOYALTY_TIER
ORDER BY AVG_LIFETIME_VALUE DESC;
```

## Data Governance & Quality

### Data Quality Features
- **Referential Integrity**: Foreign key constraints ensure data consistency
- **Data Validation**: Realistic ranges and distributions for all numeric fields
- **Temporal Consistency**: Proper date relationships (booking < check-in < check-out)
- **Business Logic**: Pricing aligned with market segments and demand patterns

### Synthetic Data Characteristics
- **Realistic Distributions**: Based on actual hospitality industry patterns
- **Geographic Diversity**: Properties across 20+ cities and 15+ countries
- **Seasonal Patterns**: Demand varies by location and time of year
- **Customer Segmentation**: Mix of business, leisure, corporate, and group guests
- **Revenue Management**: Dynamic pricing with demand-based adjustments

## Performance Considerations

### Optimizations Included
- **Indexes**: Strategic indexes on date fields and foreign keys
- **Partitioning**: Consider partitioning large tables by date for better performance
- **Materialized Views**: Pre-calculated metrics in REVENUE_SUMMARY table
- **Query Patterns**: Optimized for typical hospitality analytics workloads

### Recommended Warehouse Sizing
- **Data Loading**: Large warehouse for initial data generation
- **Analytics**: Medium warehouse for regular query workloads
- **Development**: Small warehouse for testing and development

## Extensions & Customization

### Potential Enhancements
1. **Additional Brands**: Expand to include Hyatt's full portfolio
2. **Guest Feedback**: Add satisfaction scores and review data
3. **Revenue Management**: Enhanced pricing algorithms and demand forecasting
4. **Mobile Analytics**: App usage and digital engagement metrics
5. **Sustainability**: Environmental impact and ESG metrics

### Industry Adaptations
The data model can be adapted for specific hotel chains by:
- Modifying brand names and property details
- Adjusting pricing ranges for different market segments
- Customizing service offerings and amenities
- Adapting geographic distribution

## Support & Maintenance

### Data Refresh
- **Monthly Updates**: Refresh with new reservations and performance data
- **Seasonal Adjustments**: Update demand patterns and pricing
- **Market Changes**: Incorporate new events and competitive dynamics

### Monitoring & Alerting
- **Data Quality Checks**: Regular validation of data integrity
- **Performance Monitoring**: Query performance and warehouse utilization
- **Business Metrics**: KPI dashboards and automated reporting

## License & Disclaimer

This is a synthetic dataset created for analytical and educational purposes. All data is artificially generated and does not represent actual hotel operations or customer information. Use of this data model should comply with your organization's data governance policies.

---

**Version**: 1.0  
**Last Updated**: 2024  
**Contact**: Data Analytics Team
