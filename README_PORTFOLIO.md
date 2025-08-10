# 🏪 E-commerce Analytics dbt Portfolio Demo

A complete **self-contained** dbt project that runs entirely on GitHub without external dependencies! Perfect for showcasing your dbt skills in a portfolio.

## ✨ What Makes This Special

- **🚀 Zero External Dependencies**: Runs completely on GitHub using DuckDB
- **📊 Live Demo**: Automatically generates interactive results page
- **📚 Full Documentation**: Complete dbt docs with lineage graphs
- **🔄 CI/CD Pipeline**: Automated testing and deployment
- **💼 Portfolio Ready**: Professional presentation of your dbt skills

## 🎯 Live Demo

Once deployed, your project will automatically generate:

- **📄 Interactive Results Dashboard**: `https://yourusername.github.io/ecommerce-analytics-dbt/demo/demo.html`
- **📚 dbt Documentation**: `https://yourusername.github.io/ecommerce-analytics-dbt/demo/target/index.html`
- **📊 Data Lineage**: Visual representation of your data transformations
- **🧪 Test Results**: Automated data quality validation

## 🏗️ Architecture

```
📦 E-commerce Analytics Pipeline
├── 🌱 Seeds (Sample Data)
│   ├── customers.csv
│   ├── orders.csv
│   ├── products.csv
│   └── marketing_campaigns.csv
├── 🔧 Staging Models
│   ├── stg_customers.sql
│   ├── stg_orders.sql
│   ├── stg_products.sql
│   └── stg_marketing.sql
├── 🏭 Intermediate Models
│   ├── int_customer_orders.sql
│   ├── int_product_metrics.sql
│   └── int_campaign_performance.sql
└── 🎯 Mart Models
    ├── mart_customer_analytics.sql
    ├── mart_product_analytics.sql
    ├── mart_sales_analytics.sql
    └── mart_marketing_analytics.sql
```

## 🚀 Quick Start (Portfolio Setup)

### 1. Fork & Clone
```bash
git clone https://github.com/yourusername/ecommerce-analytics-dbt.git
cd ecommerce-analytics-dbt
```

### 2. Enable GitHub Pages
1. Go to your repository settings
2. Navigate to "Pages" section
3. Set source to "GitHub Actions"

### 3. Push to Main Branch
```bash
git add .
git commit -m "Initial portfolio setup"
git push origin main
```

### 4. Watch the Magic! ✨
- GitHub Actions will automatically run your dbt pipeline
- Results will be deployed to GitHub Pages
- Share the live demo link in your portfolio!

## 📊 What Gets Generated

### Interactive Dashboard
- **Customer Segmentation**: Value tiers and lifecycle stages
- **Product Performance**: Category analysis and profit margins  
- **Sales Trends**: Monthly revenue and order patterns
- **Marketing ROI**: Campaign performance metrics

### dbt Documentation
- **Model Documentation**: Descriptions and column details
- **Data Lineage**: Visual dependency graphs
- **Test Results**: Data quality validation
- **Source Freshness**: Data pipeline health

## 🛠️ Tech Stack

- **dbt Core**: Data transformation framework
- **DuckDB**: In-memory analytical database
- **GitHub Actions**: CI/CD automation
- **GitHub Pages**: Static site hosting
- **Python**: Data processing and HTML generation

## 📁 Key Files

- `/.github/workflows/dbt-portfolio-demo.yml`: Main CI/CD pipeline
- `/profiles_duckdb.yml`: DuckDB connection configuration
- `/requirements_duckdb.txt`: Python dependencies
- `/dbt_project.yml`: dbt project configuration

## 🎨 Customization

### Add Your Own Data
Replace the seed files in `/seeds/` with your own datasets:
```bash
# Your data files
seeds/
├── your_customers.csv
├── your_orders.csv
└── your_products.csv
```

### Modify Models
Update the SQL models in `/models/` to match your business logic:
```sql
-- Example: models/marts/mart_your_analysis.sql
SELECT 
    customer_id,
    SUM(order_total) as lifetime_value,
    COUNT(*) as total_orders
FROM {{ ref('stg_orders') }}
GROUP BY 1
```

### Custom Styling
Edit the HTML template in the GitHub Actions workflow to match your personal brand.

## 🏆 Portfolio Benefits

✅ **Demonstrates dbt Expertise**: Shows mastery of modern data stack
✅ **End-to-End Pipeline**: From raw data to business insights  
✅ **Production-Ready Code**: Includes testing, documentation, CI/CD
✅ **Self-Contained**: No external services required
✅ **Interactive Demo**: Recruiters can see live results
✅ **Professional Presentation**: Clean, modern interface

## 🔗 Portfolio Integration

Add this to your portfolio/resume:

> **E-commerce Analytics Pipeline** | [Live Demo](https://yourusername.github.io/ecommerce-analytics-dbt/demo/demo.html) | [Source Code](https://github.com/yourusername/ecommerce-analytics-dbt)
> 
> Built a comprehensive analytics platform using dbt, featuring customer segmentation, product performance analysis, and marketing ROI tracking. Implemented CI/CD pipeline with automated testing and documentation generation.

## 📈 Sample Results

The demo generates realistic e-commerce metrics:
- **10,000+** customer records with segmentation
- **50,000+** order transactions with trends
- **500+** products with performance tiers
- **100+** marketing campaigns with ROI analysis

## 🤝 Contributing

This is a portfolio template! Feel free to:
- Fork and customize for your own use
- Submit improvements via pull requests
- Share your customized versions

## 📄 License

MIT License - Use freely for your portfolio and projects!

---

**🌟 Star this repo if it helps with your portfolio!**

Built with ❤️ using dbt + GitHub Actions
