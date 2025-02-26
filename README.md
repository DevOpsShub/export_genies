# .NET + ReactJS CRUD App on AWS EKS

This project deploys a .NET Core backend, ReactJS frontend, and PostgreSQL database as a CRUD application on Amazon Elastic Kubernetes Service (EKS) using Terraform for infrastructure and GitHub Actions for CI/CD. It includes logging with Fluent Bit to CloudWatch, alerts for high CPU/memory and pod failures, and secure handling of sensitive data with Kubernetes Secrets.

## Architecture
- **Backend**: .NET Core API, containerized with Docker.
- **Frontend**: ReactJS app, served via Nginx.
- **Database**: PostgreSQL, deployed as a StatefulSet.
- **Infrastructure**: AWS VPC, EKS cluster, and security groups via Terraform.
- **CI/CD**: GitHub Actions builds Docker images, pushes to ECR, and deploys to EKS.
- **Monitoring**: Fluent Bit for logs, CloudWatch for metrics and alerts.

## Prerequisites
- **AWS Account**: With programmatic access (Access Key ID, Secret Access Key).
- **Tools**:
  - Terraform (>= 1.5)
  - AWS CLI
  - `kubectl`
  - Git
  - Docker
- **GitHub Repo**: Fork this repository to your GitHub account.

## Setup Instruction

### 1. Clone the Repository
```bash
git clone https://github.com/DevOpsShub/export_genies/
cd dotnet-postgresql-reactjs-crud-app
```

### 2. Set up for Terraform

Run:
```bash
aws configure    # setup the credentials
```

Navigate to the Terraform directory:
```bash
cd terraform
```

Initialize Terraform:
```bash
terraform init
```

Review and Apply:
```bash
terraform plan
terraform apply
```

Configure `kubectl`:
```bash
aws eks update-kubeconfig --region us-east-1 --name crud-app-cluster
kubectl apply -f k8s/db-credentials.yaml
kubectl get nodes
```

### 3. Set Up GitHub Actions Secrets
Go to your GitHub repo → Settings → Secrets and variables → Actions.
Add these secrets:
- `AWS_ACCESS_KEY_ID`: Your AWS Access Key ID.
- `AWS_SECRET_ACCESS_KEY`: Your AWS Secret Access Key.

### 4. Deploy the Application
The CI/CD pipeline automatically deploys on push to `main`. To test manually:

Update Dockerfiles (if not already present):
- `DotNetCoreReactJsPostgreSQLCrudApp/Dockerfile`
- `reactjs-crud-app/Dockerfile`

### 5. Kubernetes Configuration
The `k8s/` directory contains Kubernetes manifests:
- `db-credentials.yaml`
- `postgres.yaml`
- `backend.yaml`
- `frontend.yaml`
- `backend-hpa.yaml`
- `frontend-hpa.yaml`

### 6. Configure GitHub Actions Workflow
Verify `.github/workflows/cicd.yml` file with the CI/CD pipeline configuration.

### 7. Monitor Workflow
Go to the **Actions** tab in GitHub to see the pipeline run.
- Images are built, pushed to ECR, and deployed to EKS with versioned tags (e.g., v1.0.1).

### 8. CloudWatch Setup
Refer to the documentation for CloudWatch monitoring configuration.

## Project Structure
```
DotNetCoreReactJsPostgreSQLCrudApp/  # .NET backend code and Dockerfile
reactjs-crud-app/                   # React frontend code and Dockerfile
k8s/                                 # Kubernetes manifests (deployments, services, secrets, etc.)
terraform-eks/                       # Terraform files for AWS infrastructure
.github/workflows/cicd.yml           # CI/CD pipeline configuration
