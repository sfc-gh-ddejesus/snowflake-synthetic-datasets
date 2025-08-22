# Snowflake Synthetic Datasets

This repository contains synthetic datasets specifically designed and optimized for **Snowflake Data Cloud**. Each dataset provides realistic business scenarios with complete Snowflake compatibility, advanced semantic layers, and AI-ready analytics capabilities.

## 🎯 **Available Datasets**

- **🏨 Hotel Chain** - Revenue management and guest analytics for hospitality industry
- **🔧 Maintenance Operations** - Industrial equipment maintenance and reliability analysis

## 🏔️ **Built for Snowflake**

✅ **Native Snowflake SQL** - Optimized for Snowflake's architecture and functions  
✅ **Semantic Views** - Business-friendly layers for Cortex Analyst  
✅ **Enterprise Ready** - Production-scale datasets with proper licensing  
✅ **AI/ML Compatible** - Ready for Snowflake's ML and AI capabilities  
✅ **Performance Optimized** - Designed for Snowflake's cloud architecture

## 🏨 Hotel Chain Dataset

A comprehensive sales and revenue management dataset for a fictional hotel chain with 25 properties across three regions. **Purpose-built for Snowflake Data Cloud**.

**📁 Location**: `hotel_chain/`

**✨ Snowflake Features**:
- **3 Focused Semantic Models** - Revenue Management, Guest Analytics, Ancillary Services
- **Native Snowflake SQL** - Optimized DDL and data generation scripts  
- **15,000+ realistic reservations** with proper Snowflake data types
- **9,000+ ancillary sales transactions** using Snowflake functions
- **Customer loyalty program** with business-friendly dimensions
- **Corporate accounts** and group booking analytics
- **Dynamic pricing models** for revenue management
- **25+ business metrics** across focused semantic models
- **Natural language ready** for Cortex Analyst

**🎯 Use Cases**:
- **Snowflake** revenue management optimization
- Customer analytics and segmentation on **Snowflake Data Cloud**
- Operational efficiency analysis
- **Snowflake** business intelligence training
- Data warehouse design patterns for **Snowflake**

[**📖 Full Documentation →**](hotel_chain/README.md)

## 🔧 Maintenance Operations Dataset

A comprehensive industrial maintenance database designed for equipment reliability analysis and operational efficiency insights. **Purpose-built for Snowflake Data Cloud**.

**📁 Location**: `maintenance-operations/`

**✨ Snowflake Features**:
- **Maintenance Analytics Semantic Model** - Equipment reliability, technician productivity, failure analysis
- **Native Snowflake SQL** - Optimized DDL with advanced views and functions
- **30+ realistic work orders** with complete maintenance lifecycle tracking
- **25 industrial equipment assets** with proper categorization and criticality levels
- **12 technician profiles** with specializations and performance metrics
- **Advanced KPI calculations** using Snowflake functions (MTTR, availability, cost ratios)
- **Failure tracking and root cause analysis** with standardized failure codes
- **Parts inventory management** with usage patterns and reorder analytics
- **Natural language ready** for Cortex Analyst maintenance queries

**🎯 Use Cases**:
- **Equipment reliability** analysis on Snowflake Data Cloud
- **Predictive maintenance** modeling with Snowflake ML
- **Technician productivity** and workforce optimization
- **Maintenance cost** analysis and budget planning
- **Failure pattern analysis** for continuous improvement
- **Parts inventory optimization** and supply chain analytics

[**📖 Full Documentation →**](maintenance-operations/README.md)

## 🚀 Quick Start with Snowflake

Each dataset is **Snowflake-ready** and includes:
- **Snowflake DDL**: Optimized database schemas for Snowflake Data Cloud
- **Semantic Views**: Business-friendly layers for Cortex Analyst
- **Data Generation**: Scripts using native Snowflake functions (GENERATOR, RANDOM, etc.)
- **Business Analytics**: Pre-built queries optimized for Snowflake SQL
- **Natural Language**: Ready for Cortex Analyst AI-powered analytics
- **Documentation**: Complete setup guides and Snowflake best practices

### Snowflake Setup

**Hotel Chain Dataset**:
```sql
-- 1. Create schema and tables (Snowflake-optimized)
@hotel_schema_ddl.sql

-- 2. Generate realistic data using Snowflake functions
@hotel_data_generation.sql
@hotel_reservations_generation.sql

-- 3. Start asking natural language questions!
-- "What is the revenue by hotel brand this year?"
-- "Show me occupancy rates by region and month"
```

**Maintenance Operations Dataset**:
```sql
-- 1. Create schema and load sample data
@maintenance_schema.sql
@sample_data.sql
@work_orders_data.sql

-- 2. Start analyzing maintenance operations!
-- "Which equipment has the highest maintenance costs?"
-- "Show me technician productivity by specialization"
-- "What are the most common failure modes?"
```

## 📊 Future Snowflake Datasets

Planned additions (all optimized for Snowflake):
- **E-commerce & Retail Analytics** with Snowflake semantic layers
- **Healthcare Patient Management** using Snowflake secure data sharing
- **Financial Services** with Snowflake's compliance features  
- **Manufacturing Supply Chain** leveraging Snowflake's streaming capabilities
- **SaaS Customer Engagement** with Cortex ML integration
- **Human Resources & Workforce Analytics** with employee lifecycle tracking
- **Supply Chain & Logistics** with real-time tracking and optimization

## 🤝 Contributing

Contributions are welcome! Please follow our **Snowflake-focused** guidelines:
- **Snowflake-native** data model design principles
- **Semantic view** development best practices  
- **Cortex Analyst** integration patterns
- **Snowflake SQL** optimization techniques
- Documentation standards for Snowflake users

## 📝 License

Licensed under the Apache License, Version 2.0. These Snowflake-optimized synthetic datasets are provided for educational and analytical purposes. All data is artificially generated and does not represent real business operations or customer information.

Perfect for:
- **Snowflake training** and certification preparation
- **Cortex Analyst** demonstrations and workshops
- **Proof of concepts** on Snowflake Data Cloud
- **Academic research** using Snowflake's advanced features
