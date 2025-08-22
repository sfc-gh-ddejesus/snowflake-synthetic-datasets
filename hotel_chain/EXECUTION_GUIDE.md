# Hotel Chain Synthetic Data - Execution Guide

## 📋 Script Execution Order

### **Option 1: Complete Setup (Recommended)**
Run these scripts in this exact order:

```sql
1. hotel_schema_ddl.sql          -- Creates database, schema, and all tables
2. hotel_data_generation.sql     -- Populates all tables with 5K reservations + base data
```

**That's it!** The `hotel_data_generation.sql` now includes everything you need.

---

### **Option 2: High-Volume Data (Alternative)**
If you want more reservation data (15K records), run:

```sql
1. hotel_schema_ddl.sql              -- Creates database, schema, and all tables  
2. hotel_reservations_generation.sql -- Populates all tables with 15K reservations + base data
```

---

### **❌ Don't Run Both Data Scripts Together**
**Never run both data generation scripts** as they will create:
- Duplicate base data (hotels, customers, services, etc.)
- Overlapping reservation IDs
- Double-counted revenue summaries

---

## 🧹 Data Cleanup Instructions

### **Option A: Clear All Data (Keep Table Structure)**
Use this if you want to re-run data generation scripts:

```sql
-- Clear all data but keep table structure
-- Run these in order to handle foreign key dependencies
TRUNCATE TABLE HOTEL_CHAIN_REVENUE_SUMMARY;
TRUNCATE TABLE HOTEL_CHAIN_ANCILLARY_SALES;
TRUNCATE TABLE HOTEL_CHAIN_RESERVATIONS;
TRUNCATE TABLE HOTEL_CHAIN_DAILY_ROOM_RATES;
TRUNCATE TABLE HOTEL_CHAIN_COMPETITIVE_SET;
TRUNCATE TABLE HOTEL_CHAIN_EVENTS_CALENDAR;
TRUNCATE TABLE HOTEL_CHAIN_ROOM_INVENTORY;
TRUNCATE TABLE HOTEL_CHAIN_CORPORATE_ACCOUNTS;
TRUNCATE TABLE HOTEL_CHAIN_CUSTOMERS;
TRUNCATE TABLE HOTEL_CHAIN_ANCILLARY_SERVICES;
TRUNCATE TABLE HOTEL_CHAIN_ROOM_TYPES;
TRUNCATE TABLE HOTEL_CHAIN_HOTELS;

-- Then re-run your chosen data generation script
```

### **Option B: Complete Reset (Drop Everything)**
Use this for a completely fresh start:

```sql
-- Drop all tables
DROP TABLE IF EXISTS HOTEL_CHAIN_REVENUE_SUMMARY;
DROP TABLE IF EXISTS HOTEL_CHAIN_ANCILLARY_SALES;
DROP TABLE IF EXISTS HOTEL_CHAIN_RESERVATIONS;
DROP TABLE IF EXISTS HOTEL_CHAIN_DAILY_ROOM_RATES;
DROP TABLE IF EXISTS HOTEL_CHAIN_COMPETITIVE_SET;
DROP TABLE IF EXISTS HOTEL_CHAIN_EVENTS_CALENDAR;
DROP TABLE IF EXISTS HOTEL_CHAIN_ROOM_INVENTORY;
DROP TABLE IF EXISTS HOTEL_CHAIN_CORPORATE_ACCOUNTS;
DROP TABLE IF EXISTS HOTEL_CHAIN_CUSTOMERS;
DROP TABLE IF EXISTS HOTEL_CHAIN_ANCILLARY_SERVICES;
DROP TABLE IF EXISTS HOTEL_CHAIN_ROOM_TYPES;
DROP TABLE IF EXISTS HOTEL_CHAIN_HOTELS;

-- Drop sequences
DROP SEQUENCE IF EXISTS CUSTOMER_SEQ;
DROP SEQUENCE IF EXISTS RESERVATION_SEQ;
DROP SEQUENCE IF EXISTS ANCILLARY_SALE_SEQ;

-- Then re-run both schema DDL and data generation scripts
```

### **Option C: Drop Entire Schema**
Use this to completely remove everything:

```sql
-- Drop the entire schema (this removes all tables, views, sequences)
DROP SCHEMA IF EXISTS HOTEL_CHAIN CASCADE;

-- Then re-run both schema DDL and data generation scripts
```

---

## 📊 What Each Script Contains

### **`hotel_data_generation.sql`:**
- ✅ 25 Hotels across 3 regions (Americas, ASPAC, EAME)
- ✅ 5,000 Customers with loyalty tiers  
- ✅ 10 Room types + inventory allocation
- ✅ 15 Ancillary services
- ✅ 10 Corporate accounts
- ✅ 10 Major events affecting demand
- ✅ Competitive set data
- ✅ Daily room rates (365 days × hotels × room types)
- ✅ **5,000 Reservations** with full variety
- ✅ ~3,000 Ancillary sales
- ✅ Daily revenue summaries

### **`hotel_reservations_generation.sql`:**
- ✅ Same base data as above
- ✅ **15,000 Reservations** (3x more)
- ✅ ~9,000 Ancillary sales
- ✅ More comprehensive revenue data

---

## 🎯 Recommendations

### **For Development/Testing:**
**Use Option 1** (`hotel_data_generation.sql`):
- ✅ 5,000 reservations is plenty for testing and analysis
- ✅ Faster execution time (~2-3 minutes)
- ✅ All tables get populated with excellent variety
- ✅ Perfect for development and demos

### **For Production/Analytics:**
**Use Option 2** (`hotel_reservations_generation.sql`):
- ✅ 15,000 reservations provide richer datasets
- ✅ Better for statistical analysis and reporting
- ✅ More realistic data volumes for performance testing

---

## 🔄 Typical Workflow

### **First Time Setup:**
```sql
1. Run: hotel_schema_ddl.sql
2. Run: hotel_data_generation.sql
3. Verify data with sample queries
```

### **If You Need to Re-run Data:**
```sql
1. Run: Cleanup Option A (TRUNCATE statements)
2. Run: hotel_data_generation.sql (or hotel_reservations_generation.sql)
```

### **If You Modified the Schema:**
```sql
1. Run: Cleanup Option B or C (DROP statements)
2. Run: hotel_schema_ddl.sql
3. Run: hotel_data_generation.sql
```

---

## ✅ Verification Queries

After running the scripts, verify your data with these queries:

```sql
-- Check record counts
SELECT 'Hotels' as table_name, COUNT(*) as records FROM HOTEL_CHAIN_HOTELS
UNION ALL
SELECT 'Customers', COUNT(*) FROM HOTEL_CHAIN_CUSTOMERS
UNION ALL
SELECT 'Reservations', COUNT(*) FROM HOTEL_CHAIN_RESERVATIONS
UNION ALL
SELECT 'Ancillary Sales', COUNT(*) FROM HOTEL_CHAIN_ANCILLARY_SALES
UNION ALL
SELECT 'Daily Rates', COUNT(*) FROM HOTEL_CHAIN_DAILY_ROOM_RATES
UNION ALL
SELECT 'Revenue Summary', COUNT(*) FROM HOTEL_CHAIN_REVENUE_SUMMARY;

-- Check data variety
SELECT 'Unique Hotels in Reservations' as metric, COUNT(DISTINCT HOTEL_ID) as count 
FROM HOTEL_CHAIN_RESERVATIONS
UNION ALL
SELECT 'Unique Customers in Reservations', COUNT(DISTINCT CUSTOMER_ID) 
FROM HOTEL_CHAIN_RESERVATIONS
UNION ALL
SELECT 'Unique Room Types in Reservations', COUNT(DISTINCT ROOM_TYPE_ID) 
FROM HOTEL_CHAIN_RESERVATIONS;

-- Check revenue data
SELECT 
    HOTEL_ID,
    SUM(TOTAL_REVENUE) as total_revenue,
    AVG(OCCUPANCY_RATE) as avg_occupancy,
    COUNT(*) as days_with_data
FROM HOTEL_CHAIN_REVENUE_SUMMARY 
WHERE TOTAL_REVENUE > 0
GROUP BY HOTEL_ID
ORDER BY total_revenue DESC
LIMIT 5;
```

Expected results:
- Hotels: 25 records
- Customers: 5,000 records  
- Reservations: 5,000 (basic) or 15,000 (full) records
- All 25 hotels should appear in reservations
- All 10 room types should be represented
- Revenue data should show realistic occupancy rates (30-95%)

---

## 🚨 Troubleshooting

### **No Data in Tables:**
- Verify you ran the DDL script first
- Check that you're connected to the correct database/schema
- Run the verification queries to identify which tables are empty

### **Duplicate Key Errors:**
- You likely ran a data generation script twice
- Use Cleanup Option A and re-run the data generation script

### **Performance Issues:**
- The scripts are optimized for Snowflake
- Data generation should complete in 2-5 minutes depending on warehouse size
- Consider using a larger warehouse (M or L) for faster execution

---

**Ready to go?** Start with:
1. `hotel_schema_ddl.sql`
2. `hotel_data_generation.sql`
