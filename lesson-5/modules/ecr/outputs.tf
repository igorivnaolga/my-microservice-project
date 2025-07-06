output "ecr_repository_url" {
  description = "URL ECR-репозиторію"
  value       = aws_ecr_repository.this.repository_url
}