variable "repository_name" {
  description = "Name ECR-repo"
  type        = string
}

variable "scan_on_push" {
  description = "Enable image scanning on push"
  type        = bool
  default     = false
}

variable "environment" {
  description = "Environment name (e.g. dev, prod)"
  type        = string
}