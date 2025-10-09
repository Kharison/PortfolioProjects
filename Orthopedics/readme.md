# Orthopedic Patient Analytics Dashboard

## 📊 Project Overview

An interactive Power BI dashboard analyzing orthopedic department operations, providing insights into patient volume patterns, wait time efficiency, and satisfaction trends. This project demonstrates end-to-end data analytics skills from data cleaning to visualization and actionable insights.

## 🎯 Business Objectives

- Analyze patient volume trends across different time periods
- Identify wait time patterns and operational bottlenecks  
- Understand patient satisfaction drivers
- Provide data-driven recommendations for healthcare operations improvement

## 📁 Dataset Information

**File:** `ortho Data.csv`  
**Records:** 500+ patient visits  
**Time Period:** January - October 2023  
**Source:** Synthetic orthopedic patient data

### Data Columns:
- **visit_date**: Date and time of patient visit
- **visit_month**: Month of visit (January-October)
- **visit_day**: Day of week
- **timeframe**: Hour of visit in 12-hour format
- **pat_id**: Patient identifier
- **pat_gender**: Patient gender
- **pat_age**: Patient age
- **pat_sat_score**: Patient satisfaction score (1-10)
- **pat_lastname**: Patient last name (anonymized)
- **pat_race**: Patient race/ethnicity
- **pat_admin_flag**: Administrative flag (TRUE/FALSE)
- **pat_waittime**: Patient wait time in minutes
- **dept_referral**: Department referral (all Orthopedics)

## 🛠️ Technical Implementation

### Data Processing
- Data cleaning and transformation in MySQL
- Handling datetime conversions and formatting
- Creating calculated columns for analysis
- Implementing proper sorting for categorical data

### Power BI Features Used
- Interactive slicers and filters
- Multiple visualization types (bar charts, line charts, KPIs)
- DAX measures and calculated columns
- Data modeling and relationships
- Responsive dashboard design

### Key Metrics Tracked
- 📈 Patient volume trends by month/day/time
- ⏱️ Average wait times and patterns
- 😊 Patient satisfaction analysis
- 👥 Demographic breakdowns
- 🏥 Operational efficiency metrics

## 📈 Dashboard Features

### Main Visualizations
1. **Patient Volume Overview** - Monthly and daily trends
2. **Wait Time Analysis** - Average wait times by various dimensions
3. **Satisfaction Metrics** - Correlation between wait times and satisfaction
4. **Demographic Insights** - Patient distribution by age, gender, race
5. **Time-based Patterns** - Hourly and weekly patterns

## 🚀 Getting Started

### Prerequisites
- MySQL
- Power BI Desktop
- Basic understanding of data analytics concepts

### Usage
1. Open the Power BI dashboard
2. Use slicers to filter by time period, demographics, or other criteria
3. Hover over visualizations to see detailed tooltips
4. Click on chart elements to cross-filter other visuals
