output "ecr_repository_url" {
  description = "URL ECR-repo"
  value       = aws_ecr_repository.this.repository_url
}