# Hotel Chain Semantic Models Guide

## 📋 Overview

This guide outlines the recommended semantic model structure for the hotel chain synthetic dataset. Rather than a single monolithic semantic model, we recommend **3 focused semantic models** that align with specific business functions and use cases.

## 🏨 Dataset Description

**A comprehensive hotel revenue management dataset covering guest reservations, room bookings, and ancillary service sales across a global hotel portfolio.** The model includes hotels across multiple regions and market segments, customer loyalty data, corporate accounts, and detailed transaction-level data for both accommodation and additional services.

**Key metrics include ADR, RevPAR, occupancy rates, guest retention, and ancillary revenue penetration.** The dataset supports revenue optimization, guest analytics, channel performance analysis, and operational benchmarking with 10,000+ synthetic reservations spanning multiple years and seasonal patterns.

**Ideal for testing Snowflake Cortex Analyst with natural language queries about hotel performance, guest behavior, pricing strategies, and revenue trends.**

## 📊 Recommended Semantic Model Structure

### 1. 🏨 Core Revenue Management Model

#### **Tables & Relationships:**
```
HOTELS (hotel_id) 
  ↕️ 
RESERVATIONS (hotel_id → hotels.hotel_id)
  ↕️
ROOM_TYPES (room_type_id ← reservations.room_type_id)
  ↕️
REVENUE_SUMMARY (hotel_id → hotels.hotel_id, business_date)
```

#### **Join Relationships:**
- **Hotels ← Reservations**: One hotel has many reservations
- **Room Types ← Reservations**: One room type used in many reservations  
- **Hotels ← Revenue Summary**: One hotel has daily revenue records

#### **Description:**
**Core hotel operations and revenue metrics model.** Focuses on property performance, room revenue, occupancy rates, and pricing analytics. Key metrics include ADR, RevPAR, occupancy percentage, and revenue trends by hotel, brand, and market segment. Perfect for revenue managers analyzing pricing strategies and operational performance.

#### **Key Metrics:**
- Average Daily Rate (ADR)
- Revenue per Available Room (RevPAR)
- Occupancy Rate
- Total Room Revenue
- Booking Lead Time
- Revenue by Channel/Segment

#### **Target Users:**
- Revenue Managers
- Operations Teams
- General Managers
- Finance Teams

---

### 2. 👤 Guest Analytics Model

#### **Tables & Relationships:**
```
CUSTOMERS (customer_id)
  ↕️
RESERVATIONS (customer_id → customers.customer_id)
  ↕️  
CORPORATE_ACCOUNTS (account_id ← reservations.corporate_account_id)
  ↕️
HOTELS (hotel_id ← reservations.hotel_id)
```

#### **Join Relationships:**
- **Customers ← Reservations**: One customer makes many reservations
- **Corporate Accounts ← Reservations**: One corporate account has many bookings
- **Hotels ← Reservations**: Guest stays across different properties

#### **Description:**
**Guest behavior and customer relationship analytics model.** Tracks customer loyalty, booking patterns, geographic distribution, and corporate vs leisure segmentation. Key metrics include guest retention rates, loyalty tier progression, booking lead times, and customer lifetime value. Ideal for marketing teams, CRM analysis, and guest experience optimization.

#### **Key Metrics:**
- Guest Retention Rate
- Customer Lifetime Value
- Loyalty Tier Distribution
- Booking Patterns by Demographics
- Corporate vs Leisure Segmentation
- Geographic Guest Distribution

#### **Target Users:**
- Marketing Teams
- CRM Analysts
- Guest Experience Teams
- Sales Teams

---

### 3. 🍽️ Ancillary Services Model

#### **Tables & Relationships:**
```
ANCILLARY_SERVICES (service_id)
  ↕️
ANCILLARY_SALES (service_id → ancillary_services.service_id)
  ↕️
RESERVATIONS (reservation_id ← ancillary_sales.reservation_id)
  ↕️
CUSTOMERS (customer_id ← reservations.customer_id)
```

#### **Join Relationships:**
- **Services ← Sales**: One service type sold many times
- **Reservations ← Ancillary Sales**: One reservation can have multiple service purchases
- **Customers ← Reservations**: Track which guests buy additional services

#### **Description:**
**Additional revenue streams and service performance model.** Analyzes spa, dining, business center, and other ancillary service sales. Key metrics include service penetration rates, average spend per service category, upselling success, and revenue per guest. Essential for F&B managers, spa operations, and teams focused on maximizing non-room revenue.

#### **Key Metrics:**
- Service Penetration Rate
- Average Spend per Service Category
- Revenue per Guest (non-room)
- Upselling Success Rate
- Service Category Performance
- Seasonal Service Trends

#### **Target Users:**
- F&B Managers
- Spa Operations
- Concierge Teams
- Revenue Optimization Teams

## 🎯 Implementation Strategy

### **Recommended Implementation Order:**

1. **Start with Core Revenue Management Model**
   - Highest business impact
   - Covers 80% of hotel analytics needs
   - Clear ROI for revenue optimization

2. **Add Guest Analytics Model**
   - Customer insights drive marketing ROI
   - Supports personalization initiatives
   - Enables targeted campaigns

3. **Include Ancillary Services Model**
   - Revenue optimization opportunities
   - Service quality improvements
   - Cross-selling insights

### **Benefits of Multiple Models:**

- **🎯 Focused Use Cases**: Each team gets relevant metrics without clutter
- **⚡ Better Performance**: Smaller models query faster
- **🔒 Security**: Granular access control per business function
- **🛠️ Easier Maintenance**: Simpler to debug and update
- **📱 Natural Language**: More precise Cortex Analyst responses

## 🚀 Natural Language Query Examples

### Core Revenue Management:
- *"Show me ADR and RevPAR by hotel brand for Q4"*
- *"What's the occupancy trend for luxury hotels this year?"*
- *"Compare revenue performance between direct bookings and OTA channels"*

### Guest Analytics:
- *"What's the average booking lead time for business travelers?"*
- *"Show guest retention rates by loyalty tier"*
- *"Which customer segments have the highest lifetime value?"*

### Ancillary Services:
- *"Which ancillary services have the highest penetration rate?"*
- *"What's the average spa spend per guest by hotel?"*
- *"Show F&B revenue trends by season"*

## 📝 Implementation Notes

- **Each model should have 4-6 tables max** for optimal Cortex Analyst performance
- **Create semantic models via Snowflake UI** for better validation and error handling
- **Use consistent naming conventions** across all models
- **Include comprehensive synonyms** for natural language queries
- **Test with sample queries** before deploying to business users

## 🔗 Related Files

- `hotel_schema_ddl.sql` - Database schema creation
- `hotel_data_generation.sql` - Reference data population
- `hotel_reservations_generation.sql` - Transactional data generation
- `hotel_business_questions.sql` - Sample analytical queries
