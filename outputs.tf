#-------------Backend-----------------

#output "s3_bucket_name" {
#  description = "Name of the S3 bucket for storing Terraform state files"
#  value       = module.s3_backend.s3_bucket_name
#}

#output "dynamodb_table_name" {
#  description = "Name of the DynamoDB table for state locking"
#  value       = module.s3_backend.dynamodb_table_name
#}

#-------------VPC-----------------

output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnets
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = module.vpc.internet_gateway_id
}

#output "nat_gateway_id" {
#  description = "ID NAT Gateway"
#  value       = module.vpc.nat_gateway_id
#}

#-------------ECR-----------------

output "ecr_repository_url" {
  description = "Повний URL (hostname/імена) для docker push/pull."
  value       = module.ecr.repository_url
}

output "ecr_repository_arn" {
  description = "ARN створеного репозиторію."
  value       = module.ecr.repository_arn
}

#-------------EKS-----------------

output "eks_cluster_endpoint" {
  description = "EKS API endpoint for connecting to the cluster"
  value       = module.eks.eks_cluster_endpoint
}

output "eks_cluster_name" {
  description = "Name of the EKS cluster"
  value       = module.eks.eks_cluster_name
}

output "eks_node_role_arn" {
  description = "IAM role ARN for EKS Worker Nodes"
  value       = module.eks.eks_node_role_arn
}

output "oidc_provider_arn" {
  description = "OIDC Provider ARN"
  value       = module.eks.oidc_provider_arn
}

output "oidc_provider_url" {
  description = "OIDC Provider URL"
  value       = module.eks.oidc_provider_url
}


#-------------Jenkins-----------------

output "jenkins_release" {
  value = module.jenkins.jenkins_release_name
}

output "jenkins_namespace" {
  value = module.jenkins.jenkins_namespace
}

#-------------ArgoCD-----------------

output "argocd_namespace" {
  description = "ArgoCD namespace"
  value       = module.argo_cd.namespace
}

output "argocd_server_service" {
  description = "ArgoCD server service"
  value       = module.argo_cd.argo_cd_server_service
}

output "argocd_admin_password" {
  description = "Initial admin password"
  value       = module.argo_cd.admin_password
}

#-------------RDS-----------------

output "rds_endpoint" {
  description = "RDS endpoint for connecting to the database"
  value       = module.rds.rds_endpoint
}