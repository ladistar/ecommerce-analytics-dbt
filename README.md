# E-commerce Analytics dbt Project

A comprehensive dbt project for e-commerce analytics built for BigQuery, featuring customer segmentation, product performance analysis, and marketing campaign tracking.

## Project Structure

```
ecommerce_analytics/
├── dbt_project.yml          # Project configuration
├── profiles.yml             # Connection profiles
├── packages.yml             # dbt package dependencies
├── seeds/                   # Raw data files
│   ├── customers.csv
│   ├── products.csv
│   ├── orders.csv
│   ├── order_items.csv
│   ├── marketing_campaigns.csv
│   ├── web_events.csv
│   └── schema.yml
├── models/
│   ├── staging/             # Cleaned and standardized data
│   │   ├── stg_customers.sql
│   │   ├── stg_products.sql
│   │   ├── stg_orders.sql
│   │   ├── stg_order_items.sql
│   │   ├── stg_marketing_campaigns.sql
│   │   ├── stg_web_events.sql
│   │   └── schema.yml
│   ├── intermediate/        # Business logic and enrichment
│   │   ├── int_customer_metrics.sql
│   │   ├── int_product_performance.sql
│   │   ├── int_order_enriched.sql
│   │   └── schema.yml
│   └── marts/              # Analytics-ready tables
│       ├── mart_customer_analytics.sql
│       ├── mart_sales_analytics.sql
│       ├── mart_product_analytics.sql
│       ├── mart_marketing_analytics.sql
│       └── schema.yml
└── README.md
```

## Data Model

### Seeds (Raw Data)
- **customers**: Customer profiles with demographics and acquisition data
- **products**: Product catalog with pricing and categorization
- **orders**: Order headers with totals and status
- **order_items**: Individual line items within orders
- **marketing_campaigns**: Campaign definitions and budgets
- **web_events**: User interaction events and campaign attribution

### Staging Models
Clean and standardize raw data with:
- Data type casting
- Column renaming for consistency
- Basic calculated fields
- Data quality tests

### Intermediate Models
- **int_customer_metrics**: Customer-level aggregations and segmentation
- **int_product_performance**: Product sales metrics and rankings
- **int_order_enriched**: Orders with customer and temporal context

### Mart Models
Analytics-ready tables for business intelligence:
- **mart_customer_analytics**: Customer lifecycle, value tiers, and cohort analysis
- **mart_sales_analytics**: Sales performance with customer context
- **mart_product_analytics**: Product performance with category/brand comparisons
- **mart_marketing_analytics**: Campaign performance and conversion metrics

## Key Features

### Customer Analytics
- Customer segmentation (Premium, Standard, Basic)
- Lifecycle stages (Active, At Risk, Dormant, Lost)
- Value tiers (VIP, Valuable, Standard, New)
- Cohort analysis by signup and first order month
- RFM-style analysis with recency, frequency, and monetary metrics

### Product Analytics
- Sales performance rankings
- Category and brand performance comparisons
- Margin analysis
- Inventory movement tracking

### Marketing Analytics
- Campaign performance tracking
- Conversion rate analysis (page views → cart → purchase)
- Budget efficiency metrics
- Multi-touch attribution via web events

## Setup Instructions

1. **Prerequisites**
   - dbt Core installed
   - BigQuery project with appropriate permissions
   - Service account key for BigQuery authentication

2. **Configuration**
   ```bash
   # Clone/download the project
   cd ecommerce_analytics
   
   # Install dbt packages
   dbt deps
   
   # Update profiles.yml with your BigQuery credentials
   # Test connection
   dbt debug
   ```

3. **Run the Project**
   ```bash
   # Load seed data
   dbt seed
   
   # Run all models
   dbt run
   
   # Run tests
   dbt test
   
   # Generate documentation
   dbt docs generate
   dbt docs serve
   ```

## Sample Queries

### Customer Segmentation
```sql
SELECT 
    customer_value_tier,
    customer_lifecycle_stage,
    COUNT(*) as customers,
    AVG(total_revenue) as avg_revenue
FROM mart_customer_analytics
GROUP BY 1, 2
ORDER BY avg_revenue DESC;
```

### Product Performance
```sql
SELECT 
    category,
    performance_tier,
    COUNT(*) as products,
    SUM(total_revenue) as category_revenue
FROM mart_product_analytics
GROUP BY 1, 2
ORDER BY category_revenue DESC;
```

### Campaign ROI
```sql
SELECT 
    campaign_type,
    AVG(purchase_conversion_rate) as avg_conversion_rate,
    SUM(budget) as total_budget,
    SUM(purchases) as total_purchases
FROM mart_marketing_analytics
WHERE status = 'completed'
GROUP BY 1
ORDER BY avg_conversion_rate DESC;
```

## Data Quality

The project includes comprehensive data quality tests:
- Unique and not-null constraints on primary keys
- Referential integrity between related tables
- Accepted values tests for categorical fields
- Custom business logic validations

## Dependencies

- **dbt-utils**: Utility macros for common transformations
- **dbt-expectations**: Advanced data quality testing
- **codegen**: Automated code generation helpers
- **elementary**: Data observability and monitoring

## Contributing

1. Follow the established naming conventions
2. Add appropriate tests for new models
3. Update documentation for schema changes
4. Test locally before committing

## License

This project is for demonstration purposes and includes synthetic data.
