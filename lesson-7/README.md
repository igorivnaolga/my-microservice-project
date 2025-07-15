# Terraform AWS Infrastructure — Lesson 5

## 📁 Project Structure

```
terraform-practice/
├── main.tf                  # Main configuration that includes modules
├── variables.tf             # Global input variables
├── outputs.tf               # Global output values
├── backend.tf
├── terraform.tfvars
├── modules/
│   ├── s3-backend/          # S3 & DynamoDB module for state storage and locking
│   │   ├── s3.tf
|   |   ├── dynamodb.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── vpc/                 # VPC module for networking infrastructure
│   │   ├── vpc.tf
|   |   ├── routes.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── ecr/                 # ECR module for Docker image repository
│       ├── ecr.tf
│       ├── variables.tf
│       └── outputs.tf
```

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

### 6. **Destroy infrastructure**

Tears down all managed resources:

```bash
terraform destroy
```

---

## Module Descriptions

### `s3-backend`

This module creates:

- An S3 bucket for storing the Terraform state file
- A DynamoDB table for state locking
- A separate log bucket with a lifecycle rule

> Used to manage and lock Terraform state securely.

---

### `vpc`

This module creates:

- A VPC with a specified CIDR block
- Public and private subnets across availability zones
- An internet gateway and routing tables

> Sets up the foundational AWS networking environment.

---

### `ecr`

This module creates:

- An Amazon ECR repository for Docker images
- Enables automatic image scanning
- Configures repository access policy

> Ideal for deploying containerized applications to ECS or EKS.

---
