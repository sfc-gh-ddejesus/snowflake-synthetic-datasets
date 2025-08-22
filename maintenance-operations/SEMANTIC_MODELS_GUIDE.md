# Maintenance Operations Semantic Models Guide

## 📋 Overview

This guide outlines the recommended semantic model structure for the industrial maintenance operations synthetic dataset. Rather than a single monolithic semantic model, we recommend **3 focused semantic models** that align with specific business functions and use cases.

## 🔧 Dataset Description

**A comprehensive industrial maintenance database covering equipment reliability, work order management, and operational efficiency across manufacturing facilities.** The model includes equipment lifecycle tracking, technician productivity, failure analysis, and cost optimization data for both preventive and reactive maintenance activities.

**Key metrics include MTTR, MTBF, equipment availability, maintenance cost ratios, and technician productivity.** The dataset supports predictive maintenance, reliability analysis, workforce optimization, and cost control with 30+ synthetic work orders spanning multiple maintenance categories and equipment types.

**Ideal for testing Snowflake Cortex Analyst with natural language queries about equipment performance, maintenance strategies, failure patterns, and operational efficiency.**

## 📊 Recommended Semantic Model Structure

### 1. ⚙️ Equipment Reliability & Performance Model

#### **Tables & Relationships:**
```
EQUIPMENT (equipment_id) 
  ↕️ 
WORK_ORDERS (equipment_id → equipment.equipment_id)
  ↕️
MAINTENANCE_TYPES (maintenance_type_id ← work_orders.maintenance_type_id)
  ↕️
WORK_ORDER_FAILURES (work_order_id → work_orders.work_order_id)
  ↕️
FAILURE_CODES (failure_code ← work_order_failures.failure_code)
```

#### **Join Relationships:**
- **Equipment ← Work Orders**: One equipment item has many work orders
- **Maintenance Types ← Work Orders**: One maintenance type used in many work orders  
- **Work Orders ← Failures**: One work order can have multiple failure modes
- **Failure Codes ← Work Order Failures**: Track specific failure patterns

#### **Description:**
**Core equipment performance and reliability analytics model.** Focuses on equipment availability, failure analysis, maintenance effectiveness, and downtime tracking. Key metrics include MTTR, MTBF, availability percentage, and failure frequency by equipment type. Perfect for reliability engineers analyzing equipment performance and maintenance strategies.

#### **Key Metrics:**
- Mean Time To Repair (MTTR)
- Mean Time Between Failures (MTBF)
- Equipment Availability Percentage
- Total Downtime Hours
- Maintenance Cost per Equipment
- Failure Rate by Equipment Type

#### **Target Users:**
- Reliability Engineers
- Maintenance Managers
- Operations Teams
- Plant Managers

---

### 2. 👷 Workforce & Productivity Model

#### **Tables & Relationships:**
```
TECHNICIANS (technician_id)
  ↕️
WORK_ORDER_ASSIGNMENTS (technician_id → technicians.technician_id)
  ↕️  
WORK_ORDERS (work_order_id ← work_order_assignments.work_order_id)
  ↕️
MAINTENANCE_TYPES (maintenance_type_id ← work_orders.maintenance_type_id)
```

#### **Join Relationships:**
- **Technicians ← Assignments**: One technician works on many assignments
- **Work Orders ← Assignments**: One work order can have multiple technician assignments
- **Maintenance Types ← Work Orders**: Track productivity by maintenance category

#### **Description:**
**Workforce productivity and performance analytics model.** Tracks technician efficiency, skill utilization, workload distribution, and labor cost optimization. Key metrics include work orders per technician, hours per job, cost per hour, and efficiency by skill level. Ideal for workforce planning, training needs analysis, and resource allocation optimization.

#### **Key Metrics:**
- Work Orders Completed per Technician
- Average Hours per Work Order
- Labor Cost per Hour
- Efficiency by Certification Level
- Workload Distribution
- Skill Utilization Rates

#### **Target Users:**
- Maintenance Supervisors
- HR Teams
- Workforce Planners
- Training Coordinators

---

### 3. 💰 Cost Management & Parts Model

#### **Tables & Relationships:**
```
PARTS_INVENTORY (part_id)
  ↕️
WORK_ORDER_PARTS (part_id → parts_inventory.part_id)
  ↕️
WORK_ORDERS (work_order_id ← work_order_parts.work_order_id)
  ↕️
EQUIPMENT (equipment_id ← work_orders.equipment_id)
```

#### **Join Relationships:**
- **Parts ← Usage**: One part used in many work orders
- **Work Orders ← Parts Usage**: One work order can consume multiple parts
- **Equipment ← Work Orders**: Track parts consumption by equipment type

#### **Description:**
**Maintenance cost optimization and inventory management model.** Analyzes parts consumption patterns, inventory turnover, cost per repair, and supply chain efficiency. Key metrics include inventory turnover ratios, cost per work order, reorder optimization, and parts usage by equipment type. Essential for procurement teams and cost control initiatives.

#### **Key Metrics:**
- Parts Cost per Work Order
- Inventory Turnover Ratio
- Stock-out Frequency
- Cost per Equipment Type
- Supplier Performance
- Reorder Point Optimization

#### **Target Users:**
- Procurement Teams
- Inventory Managers
- Cost Controllers
- Supply Chain Analysts

## 🎯 Implementation Strategy

### **Recommended Implementation Order:**

1. **Start with Equipment Reliability Model**
   - Highest operational impact
   - Covers 80% of maintenance analytics needs
   - Clear ROI for reliability improvements

2. **Add Workforce Productivity Model**
   - Workforce optimization drives cost savings
   - Supports training and development initiatives
   - Enables capacity planning

3. **Include Cost Management Model**
   - Inventory optimization opportunities
   - Supply chain efficiency improvements
   - Budget planning insights

### **Benefits of Multiple Models:**

- **🎯 Focused Use Cases**: Each team gets relevant metrics without clutter
- **⚡ Better Performance**: Smaller models query faster
- **🔒 Security**: Granular access control per business function
- **🛠️ Easier Maintenance**: Simpler to debug and update
- **📱 Natural Language**: More precise Cortex Analyst responses

## 🚀 Natural Language Query Examples

### Equipment Reliability & Performance:
- *"Show me equipment availability by type for this quarter"*
- *"What's the MTTR trend for high criticality equipment?"*
- *"Which equipment has the highest failure rates?"*
- *"Compare preventive vs corrective maintenance costs"*

### Workforce & Productivity:
- *"What's the average productivity by technician certification level?"*
- *"Show me workload distribution across maintenance teams"*
- *"Which technicians are most efficient at pump repairs?"*
- *"What's the labor cost trend by month?"*

### Cost Management & Parts:
- *"Which parts are running low on inventory?"*
- *"What's the total maintenance cost by equipment type?"*
- *"Show me parts consumption patterns by season"*
- *"Which suppliers provide the best value parts?"*

## 📝 Implementation Notes

- **Each model should have 4-6 tables max** for optimal Cortex Analyst performance
- **Create semantic models via Snowflake UI** for better validation and error handling
- **Use consistent naming conventions** across all models
- **Include comprehensive synonyms** for natural language queries
- **Test with sample queries** before deploying to business users

## 🔗 Related Files

- `maintenance_schema.sql` - Database schema creation
- `sample_data.sql` - Reference data population
- `work_orders_data.sql` - Operational data generation
- `sample_queries.sql` - Sample analytical queries
- `business_questions.sql` - Comprehensive business analysis queries
