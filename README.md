
# Terraform, Jenkins, Argo CD, RDS

## ⚙️ Setup Instructions

### The following must be installed and configured:

AWS account with sufficient permissions
AWS CLI configured (aws configure)
Docker installed and running
kubectl installed
Helm installed
Terraform installed

###  Create `terraform.tfvars` File

Rename `terraform.tfvars.example` to `terraform.tfvars` and fill in the required values:

```hcl
github_user         = "username"
github_pat          = "your_github_token"
github_repo_url     = "your_github_repo_url"
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

### 4. **Get all namespaces and find jenkins URL from list**

```bash
kubectl get svc --all-namespaces
```
Use login: admin, password: admin123

### 5. **Jenkins**
- Create a new pipeline job using the seed job.
- On Jenkins settings page select Script Approval and approve seed job script.
- Run the pipeline job to build the Docker image and push it to ECR.


### 6. **ArgoCD**
Terraform configuration includes Argo CD setup. ArgoCD applications and repositories are defined in the modules/argo_cd/charts directory and created during the Terraform apply.

Get ArgoCD URL from list:

```bash
kubectl get svc --all-namespaces
```

To access the ArgoCD UI, you need to get the initial admin password. Run the following command:

```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```
Login: admin.
After Jenkins job execution, ArgoCD application is in Synced state.


### 7. RDS configuration options

You can configure the RDS module using the following variables in terraform.tfvars or as command-line options.

#### Configuration file

You can configure the RDS module using the following variables in terraform.tfvars:

rds_publicly_accessible = true # false for private access
rds_use_aurora = true # false for standard RDS instance
rds_multi_az = false # true for multi-AZ deployment
rds_instance_class = "db.t3.medium" # Instance class for RDS
rds_backup_retention_period = "0" # Set to "0" for no backups, or specify the number of days for backups

#### Database engine and version can be configured using the following variables:

rds_aurora_engine = "aurora-postgresql" # Engine for Aurora cluster
rds_aurora_engine_version = "15.3" # Version for Aurora cluster
rds_aurora_parameter_group_family = "aurora-postgresql15" # Parameter group family for Aurora cluster 
rds_instance_engine = "postgres" # Engine for standard RDS instance
rds_instance_engine_version = "17.2" # Version for standard RDS instance
rds_instance_parameter_group_family = "postgres17" # Parameter group family for standard RDS instance
rds_instance_class = "db.t4g.medium" # Instance class for standard RDS instance
CLI options

#### You can also configure the RDS module using command-line options when running Terraform:

terraform apply -target=module.rds \
  -var="rds_publicly_accessible=true" \
  -var="rds_use_aurora=false" \
  -var="rds_multi_az=false" \
  -var="rds_instance_class=db.t4g.medium"

#### RDS setup examples
Aurora cluster with public access:
terraform apply -target=module.rds \
  -var="rds_publicly_accessible=true" \
  -var="rds_use_aurora=true" 


### 8. **Destroy the Terraform resources**
```bash
terraform destroy
```

