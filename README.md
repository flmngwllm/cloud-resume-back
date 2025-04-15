# Cloud Resume Challenge – Backend

This is the backend and infrastructure-as-code portion of my Cloud Resume Challenge. It powers the dynamic functionality of my resume site, including a visitor counter backed by AWS services.

## 📦 What It Includes

- AWS Lambda (Python): Handles API requests to increment and return visit count
- API Gateway: Exposes a REST endpoint securely
- DynamoDB: Stores the visit count with high availability
- S3: Hosts the static frontend
- CloudFront: Distributes the frontend globally
- Route 53: Manages DNS records for a custom domain
- AWS Certificate Manager: Provides HTTPS support
- Origin Access Control (OAC): Secures S3 access from CloudFront
- GitHub Actions: Automates Lambda packaging and deployment
- Terraform: Provisions all infrastructure

## 🧪 Lambda Function

- Written in Python
- Increments visit count in DynamoDB
- Returns count as a JSON response
- Integrated with API Gateway
- Deployed via GitHub Actions

## 🔐 Security

- Least privilege IAM role for Lambda
- CloudFront OAC restricts direct access to S3
- HTTPS enforced via ACM and CloudFront

## 📄 Files & Structure

```bash
.
├── main.tf              # Terraform main config
├── variables.tf         # Terraform input variables
├── outputs.tf           # Terraform outputs
├── lambda/
│   └── app.py           # Visitor count logic
├── .github/workflows/
│   └── deploy.yml       # GitHub Actions pipeline for Lambda
```
## 📁 Related Repositories

- [Frontend Repo](https://github.com/flmngwllm/cloud-resume-front)) 
