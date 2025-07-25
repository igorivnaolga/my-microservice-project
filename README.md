
# Terraform, Jenkins, Argo CD

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


### 7. **Destroy the Terraform resources**
```bash
terraform destroy
```

