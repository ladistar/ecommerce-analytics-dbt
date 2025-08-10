# GitHub Deployment Guide

## Prerequisites
1. GitHub account
2. Google Cloud Platform project with BigQuery enabled
3. Service account with BigQuery permissions

## Setup Steps

### 1. Create GitHub Repository
```bash
# Initialize git repository
cd ecommerce_analytics
git init
git add .
git commit -m "Initial dbt project setup"

# Create repository on GitHub and push
git remote add origin https://github.com/yourusername/ecommerce-analytics-dbt.git
git branch -M main
git push -u origin main
```

### 2. Configure GitHub Secrets
Go to your GitHub repository → Settings → Secrets and variables → Actions

Add these secrets:

**DBT_PROFILES_YML** (for development/testing):
```yaml
ecommerce_analytics:
  outputs:
    dev:
      type: bigquery
      method: service-account-json
      project: your-gcp-project-id
      dataset: ecommerce_dev
      threads: 4
      timeout_seconds: 300
      location: US
      keyfile_json: |
        {
          "type": "service_account",
          "project_id": "your-project-id",
          "private_key_id": "your-key-id",
          "private_key": "-----BEGIN PRIVATE KEY-----\nYOUR_PRIVATE_KEY\n-----END PRIVATE KEY-----\n",
          "client_email": "your-service-account@your-project.iam.gserviceaccount.com",
          "client_id": "your-client-id",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token"
        }
  target: dev
```

**DBT_PROFILES_YML_PROD** (for production deployment):
```yaml
ecommerce_analytics:
  outputs:
    prod:
      type: bigquery
      method: service-account-json
      project: your-gcp-project-id
      dataset: ecommerce_prod
      threads: 8
      timeout_seconds: 300
      location: US
      keyfile_json: |
        {
          "type": "service_account",
          "project_id": "your-project-id",
          "private_key_id": "your-key-id",
          "private_key": "-----BEGIN PRIVATE KEY-----\nYOUR_PRIVATE_KEY\n-----END PRIVATE KEY-----\n",
          "client_email": "your-service-account@your-project.iam.gserviceaccount.com",
          "client_id": "your-client-id",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token"
        }
  target: prod
```

### 3. BigQuery Setup
Create datasets in your BigQuery project:
- `ecommerce_dev` (for development)
- `ecommerce_prod` (for production)

### 4. Service Account Permissions
Your service account needs these BigQuery roles:
- BigQuery Data Editor
- BigQuery Job User
- BigQuery User

### 5. Workflow Triggers
The GitHub Actions workflow will run on:
- Push to `main` or `develop` branches
- Pull requests to `main`
- Production deployment only on `main` branch pushes

### 6. Local Development
```bash
# Clone repository
git clone https://github.com/yourusername/ecommerce-analytics-dbt.git
cd ecommerce-analytics-dbt

# Install dependencies
pip install -r requirements.txt

# Copy and configure profiles
cp profiles.yml.example ~/.dbt/profiles.yml
# Edit ~/.dbt/profiles.yml with your credentials

# Install dbt packages
dbt deps

# Test connection
dbt debug

# Run project
dbt seed
dbt run
dbt test
```

### 7. Branch Strategy
- `main`: Production-ready code
- `develop`: Integration branch for features
- Feature branches: `feature/your-feature-name`

### 8. Pull Request Process
1. Create feature branch from `develop`
2. Make changes and test locally
3. Push branch and create PR to `develop`
4. GitHub Actions runs tests automatically
5. After review, merge to `develop`
6. Create PR from `develop` to `main` for production deployment

## Monitoring and Maintenance

### View Workflow Results
- Go to Actions tab in your GitHub repository
- Monitor build status and logs
- Download dbt documentation artifacts

### Updating Models
1. Create feature branch
2. Modify models/tests
3. Test locally with `dbt run` and `dbt test`
4. Push and create PR
5. Review automated test results

### Adding New Data Sources
1. Add seed files to `seeds/` directory
2. Update `seeds/schema.yml`
3. Create corresponding staging models
4. Add tests and documentation
5. Follow PR process

This setup provides a complete CI/CD pipeline for your dbt project with automated testing and deployment!
