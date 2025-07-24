
# Kubernetes Cluster and Django Application Deployment

## ⚙️ Setup Instructions

### Step 1: Create `terraform.tfvars` File

Rename `terraform.tfvars.example` to `terraform.tfvars` and fill in the required values:

```hcl
db_user           = "your_db_user"
db_password       = "your_secure_password"
allowed_account_id = "your_aws_account_id"
environment       = "dev"
```

## 🛠️ Terraform Commands

### 1. **Initialize the project**

Installs the required providers and sets up the backend:

```bash
terraform init
```

### 2. **Check the execution plan**

Shows what Terraform will do before applying it:

```bash
terraform plan
```

### 3. **Apply the configuration**

Creates or updates infrastructure:

```bash
terraform apply
```

### 4. **Enable Remote Backend**

After the S3 bucket and DynamoDB table are created, **uncomment** the backend block in `backend.tf`, then run:

```bash
terraform init -reconfigure
```

### 5. **Manage Infrastructure**

Use these standard Terraform commands:

```bash
terraform plan
terraform apply
```

## Prerequisites

### The following must be installed and configured:

AWS account with sufficient permissions
AWS CLI configured (aws configure)
Docker installed and running
kubectl installed
Helm installed
Terraform installed

### Step 1: Build and Upload Docker Image to ECR

Authenticate Docker with ECR:
```bash
aws ecr get-login-password --region <your-region> | docker login --username AWS --password-stdin <your-account-id>.dkr.ecr.<your-region>.amazonaws.com
```

Create a Docker image:
```bash
docker build -t django-app .
```

Add a tag to the image:
```bash
docker tag django-app:latest <your-account-id>.dkr.ecr.<your-region>.amazonaws.com/ecr-dev
```

Upload the image to ECR:
```bash
docker push <your-account-id>.dkr.ecr.<your-region>.amazonaws.com/ecr-dev
```

### Step 2: Configure kubectl

Update the kubeconfig in the EKS cluster:
```bash
aws eks --region <your-region> update-kubeconfig --name <your-cluster-name>
```

Verify access to the cluster:
```bash
kubectl get nodes
```

### Step 3: Deploy Django App using Helm

Go to the Helm chart directory:
```bash
cd charts/django-app
```

Update values.yaml to add the ECR image repository and tag.

Install the chart:
```bash
helm install my-django .
```

Verify access to the cluster:
```bash
kubectl get nodes
```

Get the external URL:
```bash
kubectl get svc
```

Look for the EXTERNAL-IP of the service. Open the Django app in a browser:

http://<external-elb-dns>

### Step 4: Clean up Resources

To remove all resources:

Uninstall the Helm chart:
```bash
helm uninstall my-django
```

Destroy the Terraform resources:
```bash
terraform destroy
```

