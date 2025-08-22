-- =====================================================
-- Maintenance Operations - Semantic Model Views
-- Pre-built views with all necessary joins for BI tools
-- =====================================================

USE DATABASE MAINTENANCE_OPERATIONS;
USE SCHEMA OPERATIONS;

-- =====================================================
-- 1. COMPREHENSIVE WORK ORDER FACT VIEW
-- Central fact table with all dimensions joined
-- =====================================================
CREATE OR REPLACE VIEW VW_WORK_ORDER_FACT AS
SELECT 
    -- Primary Keys
    wo.WORK_ORDER_ID,
    wo.EQUIPMENT_ID,
    wo.MAINTENANCE_TYPE_ID,
    woa.TECHNICIAN_ID,
    wop.PART_ID,
    wof.FAILURE_CODE,
    
    -- Work Order Measures
    wo.ACTUAL_HOURS,
    wo.ESTIMATED_HOURS,
    wo.ACTUAL_COST,
    wo.ESTIMATED_COST,
    wo.DOWNTIME_HOURS,
    
    -- Calculated Measures
    wo.ACTUAL_COST - wo.ESTIMATED_COST as COST_VARIANCE,
    wo.ACTUAL_HOURS - wo.ESTIMATED_HOURS as HOURS_VARIANCE,
    CASE WHEN wo.ESTIMATED_HOURS > 0 THEN wo.ACTUAL_HOURS / wo.ESTIMATED_HOURS * 100 ELSE NULL END as EFFICIENCY_PERCENT,
    
    -- Work Order Attributes
    wo.PRIORITY,
    wo.STATUS,
    wo.DESCRIPTION as WO_DESCRIPTION,
    wo.REQUESTED_BY,
    
    -- Dates
    wo.REQUESTED_DATE,
    wo.SCHEDULED_START_DATE,
    wo.SCHEDULED_END_DATE,
    wo.ACTUAL_START_DATE,
    wo.ACTUAL_END_DATE,
    DATEDIFF('hour', wo.ACTUAL_START_DATE, wo.ACTUAL_END_DATE) as ACTUAL_DURATION_HOURS,
    
    -- Equipment Dimensions
    e.EQUIPMENT_NAME,
    e.EQUIPMENT_TYPE,
    e.MANUFACTURER as EQUIPMENT_MANUFACTURER,
    e.MODEL as EQUIPMENT_MODEL,
    e.LOCATION,
    e.FACILITY,
    e.CRITICALITY_LEVEL,
    e.REPLACEMENT_COST,
    DATEDIFF('year', e.INSTALLATION_DATE, CURRENT_DATE()) as EQUIPMENT_AGE_YEARS,
    
    -- Maintenance Type Dimensions
    mt.TYPE_NAME as MAINTENANCE_TYPE,
    mt.CATEGORY as MAINTENANCE_CATEGORY,
    mt.TYPICAL_DURATION_HOURS,
    
    -- Technician Dimensions (from lead technician)
    t.FIRST_NAME || ' ' || t.LAST_NAME as TECHNICIAN_NAME,
    t.SPECIALIZATION,
    t.CERTIFICATION_LEVEL,
    t.HOURLY_RATE,
    woa.ROLE as TECHNICIAN_ROLE,
    woa.HOURS_WORKED as TECHNICIAN_HOURS,
    woa.HOURS_WORKED * t.HOURLY_RATE as LABOR_COST,
    
    -- Parts Dimensions
    p.PART_NAME,
    p.CATEGORY as PART_CATEGORY,
    p.MANUFACTURER as PART_MANUFACTURER,
    wop.QUANTITY_USED,
    wop.UNIT_COST as PART_UNIT_COST,
    wop.TOTAL_COST as PARTS_COST,
    
    -- Failure Dimensions
    fc.FAILURE_DESCRIPTION,
    fc.FAILURE_CATEGORY,
    fc.ROOT_CAUSE,
    wof.NOTES as FAILURE_NOTES

FROM WORK_ORDERS wo
    -- Required joins
    INNER JOIN EQUIPMENT e ON wo.EQUIPMENT_ID = e.EQUIPMENT_ID
    INNER JOIN MAINTENANCE_TYPES mt ON wo.MAINTENANCE_TYPE_ID = mt.MAINTENANCE_TYPE_ID
    
    -- Optional joins
    LEFT JOIN WORK_ORDER_ASSIGNMENTS woa ON wo.WORK_ORDER_ID = woa.WORK_ORDER_ID AND woa.ROLE = 'LEAD'
    LEFT JOIN TECHNICIANS t ON woa.TECHNICIAN_ID = t.TECHNICIAN_ID
    LEFT JOIN WORK_ORDER_PARTS wop ON wo.WORK_ORDER_ID = wop.WORK_ORDER_ID
    LEFT JOIN PARTS_INVENTORY p ON wop.PART_ID = p.PART_ID
    LEFT JOIN WORK_ORDER_FAILURES wof ON wo.WORK_ORDER_ID = wof.WORK_ORDER_ID
    LEFT JOIN FAILURE_CODES fc ON wof.FAILURE_CODE = fc.FAILURE_CODE;

-- =====================================================
-- 2. EQUIPMENT DIMENSION VIEW
-- Equipment master with calculated attributes
-- =====================================================
CREATE OR REPLACE VIEW VW_EQUIPMENT_DIMENSION AS
SELECT 
    EQUIPMENT_ID,
    EQUIPMENT_NAME,
    EQUIPMENT_TYPE,
    MANUFACTURER,
    MODEL,
    SERIAL_NUMBER,
    INSTALLATION_DATE,
    LOCATION,
    FACILITY,
    CRITICALITY_LEVEL,
    STATUS,
    REPLACEMENT_COST,
    
    -- Calculated attributes
    DATEDIFF('year', INSTALLATION_DATE, CURRENT_DATE()) as AGE_YEARS,
    DATEDIFF('month', INSTALLATION_DATE, CURRENT_DATE()) as AGE_MONTHS,
    
    -- Hierarchy fields for drill-down
    FACILITY as FACILITY_LEVEL,
    LOCATION as LOCATION_LEVEL,
    EQUIPMENT_TYPE as TYPE_LEVEL,
    EQUIPMENT_NAME as EQUIPMENT_LEVEL,
    
    CREATED_DATE,
    UPDATED_DATE
FROM EQUIPMENT;

-- =====================================================
-- 3. TECHNICIAN DIMENSION VIEW
-- Technician master with calculated attributes
-- =====================================================
CREATE OR REPLACE VIEW VW_TECHNICIAN_DIMENSION AS
SELECT 
    TECHNICIAN_ID,
    FIRST_NAME,
    LAST_NAME,
    FIRST_NAME || ' ' || LAST_NAME as FULL_NAME,
    EMAIL,
    PHONE,
    HIRE_DATE,
    SPECIALIZATION,
    CERTIFICATION_LEVEL,
    HOURLY_RATE,
    STATUS,
    
    -- Calculated attributes
    DATEDIFF('year', HIRE_DATE, CURRENT_DATE()) as YEARS_OF_SERVICE,
    DATEDIFF('month', HIRE_DATE, CURRENT_DATE()) as MONTHS_OF_SERVICE,
    
    -- Hierarchy fields
    SPECIALIZATION as SPECIALIZATION_LEVEL,
    CERTIFICATION_LEVEL as CERTIFICATION_LEVEL_HIERARCHY,
    FULL_NAME as TECHNICIAN_LEVEL,
    
    CREATED_DATE
FROM TECHNICIANS;

-- =====================================================
-- 4. MAINTENANCE TYPE DIMENSION VIEW
-- Maintenance classification hierarchy
-- =====================================================
CREATE OR REPLACE VIEW VW_MAINTENANCE_TYPE_DIMENSION AS
SELECT 
    MAINTENANCE_TYPE_ID,
    TYPE_NAME,
    DESCRIPTION,
    CATEGORY,
    TYPICAL_DURATION_HOURS,
    
    -- Hierarchy fields
    CATEGORY as CATEGORY_LEVEL,
    TYPE_NAME as TYPE_LEVEL,
    
    -- Classification flags
    CASE WHEN CATEGORY = 'PREVENTIVE' THEN 1 ELSE 0 END as IS_PREVENTIVE,
    CASE WHEN CATEGORY = 'CORRECTIVE' THEN 1 ELSE 0 END as IS_CORRECTIVE,
    CASE WHEN CATEGORY = 'EMERGENCY' THEN 1 ELSE 0 END as IS_EMERGENCY,
    CASE WHEN CATEGORY = 'PREDICTIVE' THEN 1 ELSE 0 END as IS_PREDICTIVE,
    
    CREATED_DATE
FROM MAINTENANCE_TYPES;

-- =====================================================
-- 5. PARTS DIMENSION VIEW
-- Parts inventory with calculated attributes
-- =====================================================
CREATE OR REPLACE VIEW VW_PARTS_DIMENSION AS
SELECT 
    PART_ID,
    PART_NAME,
    PART_NUMBER,
    DESCRIPTION,
    CATEGORY,
    MANUFACTURER,
    UNIT_COST,
    QUANTITY_ON_HAND,
    REORDER_POINT,
    LOCATION as STORAGE_LOCATION,
    
    -- Calculated attributes
    QUANTITY_ON_HAND * UNIT_COST as INVENTORY_VALUE,
    CASE 
        WHEN QUANTITY_ON_HAND <= REORDER_POINT THEN 'REORDER_REQUIRED'
        WHEN QUANTITY_ON_HAND <= REORDER_POINT * 1.5 THEN 'LOW_STOCK'
        ELSE 'ADEQUATE'
    END as STOCK_STATUS,
    
    -- Hierarchy fields
    CATEGORY as CATEGORY_LEVEL,
    MANUFACTURER as MANUFACTURER_LEVEL,
    PART_NAME as PART_LEVEL,
    
    CREATED_DATE,
    UPDATED_DATE
FROM PARTS_INVENTORY;

-- =====================================================
-- 6. FAILURE DIMENSION VIEW
-- Failure codes classification
-- =====================================================
CREATE OR REPLACE VIEW VW_FAILURE_DIMENSION AS
SELECT 
    FAILURE_CODE,
    FAILURE_DESCRIPTION,
    FAILURE_CATEGORY,
    ROOT_CAUSE,
    RECOMMENDED_ACTION,
    
    -- Hierarchy fields
    FAILURE_CATEGORY as CATEGORY_LEVEL,
    FAILURE_DESCRIPTION as DESCRIPTION_LEVEL,
    
    CREATED_DATE
FROM FAILURE_CODES;

-- =====================================================
-- 7. DATE DIMENSION VIEW
-- Date hierarchy for time-based analysis
-- =====================================================
CREATE OR REPLACE VIEW VW_DATE_DIMENSION AS
SELECT DISTINCT
    DATE(ACTUAL_START_DATE) as DATE_KEY,
    ACTUAL_START_DATE as FULL_DATETIME,
    
    -- Date components
    YEAR(ACTUAL_START_DATE) as YEAR,
    QUARTER(ACTUAL_START_DATE) as QUARTER,
    MONTH(ACTUAL_START_DATE) as MONTH,
    WEEK(ACTUAL_START_DATE) as WEEK,
    DAY(ACTUAL_START_DATE) as DAY,
    DAYOFWEEK(ACTUAL_START_DATE) as DAY_OF_WEEK,
    
    -- Date names
    MONTHNAME(ACTUAL_START_DATE) as MONTH_NAME,
    DAYNAME(ACTUAL_START_DATE) as DAY_NAME,
    
    -- Hierarchy
    YEAR(ACTUAL_START_DATE) as YEAR_LEVEL,
    YEAR(ACTUAL_START_DATE) || '-Q' || QUARTER(ACTUAL_START_DATE) as QUARTER_LEVEL,
    YEAR(ACTUAL_START_DATE) || '-' || LPAD(MONTH(ACTUAL_START_DATE), 2, '0') as MONTH_LEVEL,
    DATE(ACTUAL_START_DATE) as DAY_LEVEL,
    
    -- Fiscal periods (assuming fiscal year starts July 1)
    CASE 
        WHEN MONTH(ACTUAL_START_DATE) >= 7 THEN YEAR(ACTUAL_START_DATE) + 1
        ELSE YEAR(ACTUAL_START_DATE)
    END as FISCAL_YEAR,
    
    CASE 
        WHEN MONTH(ACTUAL_START_DATE) BETWEEN 7 AND 9 THEN 1
        WHEN MONTH(ACTUAL_START_DATE) BETWEEN 10 AND 12 THEN 2
        WHEN MONTH(ACTUAL_START_DATE) BETWEEN 1 AND 3 THEN 3
        ELSE 4
    END as FISCAL_QUARTER

FROM WORK_ORDERS 
WHERE ACTUAL_START_DATE IS NOT NULL;

-- =====================================================
-- 8. AGGREGATED FACT VIEWS FOR PERFORMANCE
-- =====================================================

-- Daily aggregated work order metrics
CREATE OR REPLACE VIEW VW_DAILY_WORK_ORDER_METRICS AS
SELECT 
    DATE(wo.ACTUAL_START_DATE) as DATE_KEY,
    wo.EQUIPMENT_ID,
    wo.MAINTENANCE_TYPE_ID,
    
    COUNT(*) as WORK_ORDERS_COMPLETED,
    SUM(wo.ACTUAL_HOURS) as TOTAL_HOURS,
    SUM(wo.ACTUAL_COST) as TOTAL_COST,
    SUM(wo.DOWNTIME_HOURS) as TOTAL_DOWNTIME,
    AVG(wo.ACTUAL_HOURS) as AVG_HOURS,
    AVG(wo.ACTUAL_COST) as AVG_COST,
    
    COUNT(CASE WHEN mt.CATEGORY = 'PREVENTIVE' THEN 1 END) as PREVENTIVE_COUNT,
    COUNT(CASE WHEN mt.CATEGORY = 'CORRECTIVE' THEN 1 END) as CORRECTIVE_COUNT,
    COUNT(CASE WHEN mt.CATEGORY = 'EMERGENCY' THEN 1 END) as EMERGENCY_COUNT,
    COUNT(CASE WHEN mt.CATEGORY = 'PREDICTIVE' THEN 1 END) as PREDICTIVE_COUNT

FROM WORK_ORDERS wo
    INNER JOIN MAINTENANCE_TYPES mt ON wo.MAINTENANCE_TYPE_ID = mt.MAINTENANCE_TYPE_ID
WHERE wo.STATUS = 'COMPLETED' 
  AND wo.ACTUAL_START_DATE IS NOT NULL
GROUP BY DATE(wo.ACTUAL_START_DATE), wo.EQUIPMENT_ID, wo.MAINTENANCE_TYPE_ID;

-- Monthly equipment performance metrics
CREATE OR REPLACE VIEW VW_MONTHLY_EQUIPMENT_METRICS AS
SELECT 
    YEAR(wo.ACTUAL_START_DATE) as YEAR,
    MONTH(wo.ACTUAL_START_DATE) as MONTH,
    wo.EQUIPMENT_ID,
    e.EQUIPMENT_TYPE,
    e.CRITICALITY_LEVEL,
    
    COUNT(*) as WORK_ORDERS_COUNT,
    SUM(wo.ACTUAL_HOURS) as TOTAL_MAINTENANCE_HOURS,
    SUM(wo.ACTUAL_COST) as TOTAL_MAINTENANCE_COST,
    SUM(wo.DOWNTIME_HOURS) as TOTAL_DOWNTIME_HOURS,
    
    -- Reliability KPIs
    (744 - COALESCE(SUM(wo.DOWNTIME_HOURS), 0)) / 744 * 100 as AVAILABILITY_PERCENT,
    COALESCE(SUM(wo.DOWNTIME_HOURS), 0) / NULLIF(COUNT(CASE WHEN mt.CATEGORY IN ('CORRECTIVE', 'EMERGENCY') THEN 1 END), 0) as MTTR_HOURS,
    
    -- Maintenance type breakdown
    COUNT(CASE WHEN mt.CATEGORY = 'PREVENTIVE' THEN 1 END) as PREVENTIVE_COUNT,
    COUNT(CASE WHEN mt.CATEGORY IN ('CORRECTIVE', 'EMERGENCY') THEN 1 END) as REACTIVE_COUNT

FROM WORK_ORDERS wo
    INNER JOIN EQUIPMENT e ON wo.EQUIPMENT_ID = e.EQUIPMENT_ID
    INNER JOIN MAINTENANCE_TYPES mt ON wo.MAINTENANCE_TYPE_ID = mt.MAINTENANCE_TYPE_ID
WHERE wo.STATUS = 'COMPLETED' 
  AND wo.ACTUAL_START_DATE IS NOT NULL
GROUP BY YEAR(wo.ACTUAL_START_DATE), MONTH(wo.ACTUAL_START_DATE), wo.EQUIPMENT_ID, e.EQUIPMENT_TYPE, e.CRITICALITY_LEVEL;

-- =====================================================
-- SEMANTIC MODEL DOCUMENTATION
-- =====================================================
COMMENT ON VIEW VW_WORK_ORDER_FACT IS 'Primary fact table for work order analysis with all dimension attributes';
COMMENT ON VIEW VW_EQUIPMENT_DIMENSION IS 'Equipment dimension with hierarchy and calculated attributes';
COMMENT ON VIEW VW_TECHNICIAN_DIMENSION IS 'Technician dimension with service years and hierarchy';
COMMENT ON VIEW VW_MAINTENANCE_TYPE_DIMENSION IS 'Maintenance type dimension with category flags';
COMMENT ON VIEW VW_PARTS_DIMENSION IS 'Parts dimension with inventory status and value calculations';
COMMENT ON VIEW VW_FAILURE_DIMENSION IS 'Failure codes dimension for root cause analysis';
COMMENT ON VIEW VW_DATE_DIMENSION IS 'Date dimension with fiscal calendar and hierarchy';
COMMENT ON VIEW VW_DAILY_WORK_ORDER_METRICS IS 'Daily aggregated metrics for dashboard performance';
COMMENT ON VIEW VW_MONTHLY_EQUIPMENT_METRICS IS 'Monthly equipment performance with reliability KPIs';
