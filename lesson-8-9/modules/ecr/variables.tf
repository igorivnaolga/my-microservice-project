variable "repository_name" {
  description = "Name ECR-repo"
  type        = string
}

variable "scan_on_push" {
  description = "Enable image scanning on push"
  type        = bool
  default     = true
}

variable "image_tag_mutability" {
  type        = string
  description = "IMMUTABLE заблокує зміну існуючих тегів; MUTABLE дозволяє перезапис."
  default     = "MUTABLE"
}

variable "environment" {
  description = "Environment name (e.g. dev, prod)"
  type        = string
}

variable "force_delete" {
  type        = bool
  description = "Якщо true, видалення репо автоматично видаляє всі образи всередині."
  default     = true
}

variable "repository_policy" {
  type        = string
  description = "JSON-політика репозиторію."
  default     = null
}