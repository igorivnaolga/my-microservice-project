variable "repository_name" {
  description = "Назва ECR-репозиторію"
  type        = string
}

variable "scan_on_push" {
  description = "Enable image scanning on push"
  type        = bool
  default     = false
}