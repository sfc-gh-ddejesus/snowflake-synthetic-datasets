# Industrial Maintenance Operations Database

## Overview
This is a comprehensive maintenance operations database designed for industrial facilities, containing a full year of realistic maintenance data for analysis and reporting. The database supports queries about equipment maintenance history, technician productivity, failure analysis, and operational insights.

## Database Structure

### Core Tables
- **EQUIPMENT** (25 records) - Master equipment register with all maintainable assets
- **TECHNICIANS** (12 records) - Maintenance technician information and qualifications  
- **MAINTENANCE_TYPES** (10 records) - Classification of maintenance activities
- **WORK_ORDERS** (30+ records) - Main maintenance work order tracking
- **WORK_ORDER_ASSIGNMENTS** (40+ records) - Technician assignments and labor hours
- **PARTS_INVENTORY** (15 records) - Spare parts and materials inventory
- **WORK_ORDER_PARTS** (17 records) - Parts consumption tracking
- **MAINTENANCE_PROCEDURES** (5 records) - Standard maintenance procedures
- **FAILURE_CODES** (12 records) - Standardized failure modes and solutions
- **WORK_ORDER_FAILURES** (7 records) - Failure tracking for root cause analysis

### Key Features
- ✅ Realistic industrial equipment (pumps, compressors, heat exchangers, motors, valves, instruments)
- ✅ Generic facility location data
- ✅ Full year of maintenance operations (2023)
- ✅ Mix of preventive, corrective, emergency, and predictive maintenance
- ✅ Complete cost tracking (labor + parts)
- ✅ Downtime and productivity metrics
- ✅ Failure analysis and root cause tracking
- ✅ Parts inventory management
- ✅ Standard maintenance procedures

## Files Included

1. **`maintenance_schema.sql`** - Complete database schema (DDL)
2. **`sample_data.sql`** - Static reference data (equipment, technicians, parts, etc.)
3. **`work_orders_data.sql`** - Work orders and operational data
4. **`complete_deployment.sql`** - Combined deployment script with advanced views
5. **`sample_queries.sql`** - Comprehensive analysis queries
6. **`README.md`** - This documentation

## Quick Deployment

### Option 1: Complete Deployment (Recommended)
```sql
-- Execute all scripts in order:
-- 1. Schema creation
@maintenance_schema.sql

-- 2. Reference data
@sample_data.sql

-- 3. Operational data
@work_orders_data.sql

-- 4. Advanced views (optional)
@complete_deployment.sql
```

### Option 2: Manual Step-by-Step
1. Run `maintenance_schema.sql` to create tables and basic views
2. Run `sample_data.sql` to populate reference data
3. Run `work_orders_data.sql` to add work orders and operational data
4. Test with queries from `sample_queries.sql`

## Sample Use Cases & Queries

### 1. How to Fix Equipment Issues
```sql
-- Find maintenance procedures for pumps
SELECT PROCEDURE_NAME, STEP_BY_STEP_INSTRUCTIONS, TOOLS_REQUIRED
FROM MAINTENANCE_PROCEDURES 
WHERE EQUIPMENT_TYPE = 'Centrifugal Pump';

-- Find solutions for bearing failures
SELECT FAILURE_DESCRIPTION, ROOT_CAUSE, RECOMMENDED_ACTION
FROM FAILURE_CODES 
WHERE FAILURE_DESCRIPTION LIKE '%Bearing%';
```

### 2. Equipment Maintenance History
```sql
-- Complete history for specific equipment
SELECT * FROM VW_EQUIPMENT_MAINTENANCE_HISTORY 
WHERE EQUIPMENT_ID = 'EQ001';

-- Equipment reliability metrics
SELECT * FROM VW_EQUIPMENT_RELIABILITY 
ORDER BY AVAILABILITY_PERCENT;
```

### 3. Maintenance Productivity Analysis
```sql
-- Technician performance metrics
SELECT * FROM VW_TECHNICIAN_PERFORMANCE 
ORDER BY WORK_ORDERS_PER_WEEK DESC;

-- Monthly maintenance trends
SELECT * FROM VW_MONTHLY_MAINTENANCE_TRENDS;
```

### 4. Business Intelligence
```sql
-- Maintenance cost analysis by equipment type
SELECT * FROM VW_MAINTENANCE_COST_ANALYSIS 
ORDER BY TOTAL_COST DESC;

-- Most problematic equipment
SELECT EQUIPMENT_NAME, TOTAL_MAINTENANCE_COST, TOTAL_DOWNTIME_HOURS
FROM VW_EQUIPMENT_RELIABILITY 
ORDER BY TOTAL_MAINTENANCE_COST DESC LIMIT 10;
```

## Key Performance Indicators (KPIs)

The database supports calculation of standard maintenance KPIs:

- **Equipment Availability** = (Total Time - Downtime) / Total Time × 100
- **Mean Time To Repair (MTTR)** = Total Downtime / Number of Failures
- **Maintenance Cost Ratio** = Maintenance Cost / Replacement Cost × 100
- **Preventive vs Reactive Ratio** = Preventive WOs / Reactive WOs
- **Work Order Completion Rate** = Completed WOs / Total WOs × 100
- **Technician Productivity** = Work Orders Completed / Time Period

## Advanced Analytics Views

Pre-built views for common analysis:
- `VW_EQUIPMENT_RELIABILITY` - Equipment performance and reliability metrics
- `VW_MAINTENANCE_COST_ANALYSIS` - Cost breakdown by equipment type and criticality
- `VW_TECHNICIAN_PERFORMANCE` - Technician productivity and efficiency metrics
- `VW_FAILURE_ANALYSIS` - Failure mode analysis with cost impact
- `VW_PARTS_ANALYSIS` - Parts inventory and usage analysis
- `VW_MONTHLY_MAINTENANCE_TRENDS` - Time-series maintenance activity trends

## Data Quality & Realism

The sample data includes:
- ✅ Realistic equipment from industrial operations
- ✅ Appropriate maintenance intervals and costs
- ✅ Seasonal variation in maintenance activities
- ✅ Proper relationships between equipment, failures, and parts
- ✅ Varying technician skill levels and specializations
- ✅ Emergency repairs, planned maintenance, and predictive activities
- ✅ Current work orders in various states (open, in-progress, completed)

## Customization

To adapt for specific organizations:
1. **Equipment**: Modify equipment types, locations, and manufacturers in EQUIPMENT table
2. **Maintenance Types**: Adjust maintenance categories and intervals in MAINTENANCE_TYPES
3. **Technicians**: Update names, specializations, and rates in TECHNICIANS table
4. **Parts**: Replace with organization-specific parts and suppliers in PARTS_INVENTORY
5. **Procedures**: Add company-specific maintenance procedures and safety requirements

## Technical Specifications

- **Database Platform**: Snowflake (Cloud Data Warehouse)
- **SQL Dialect**: Snowflake SQL with standard ANSI SQL compatibility
- **Data Size**: ~5MB for complete dataset
- **Query Performance**: Sub-second response for most analytical queries
- **Indexes**: Optimized for common query patterns

## Maintenance & Updates

For ongoing use:
1. Add new equipment as facilities expand
2. Update technician information as team changes
3. Create new work orders for actual maintenance activities
4. Archive old data annually to maintain performance
5. Update procedures and failure codes based on lessons learned

## Support & Questions

This database structure supports typical maintenance management system requirements and can be extended for specific organizational needs. The sample queries demonstrate the types of analysis possible with this data model.

For additional customization or questions about the data model, consider:
- Adding more detailed cost centers and budget tracking
- Integrating with external systems (SCADA, ERP, etc.)
- Implementing automated work order generation
- Adding more sophisticated scheduling and resource optimization

---

*Generated for industrial maintenance operations analysis*
