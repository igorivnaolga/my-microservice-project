variable "vpc_cidr" {
  description = "vpc module"
  type        = string
}

variable "vpc_name" {
  description = "vpc name"
  type = string
}

variable "public_subnets" {
  description = "public subnets"
  type = list(string)
}

variable "private_subnets" {
  description = "private subnets"
  type = list(string)
}

variable "availability_zones" {
  description = "availability zones"
  type = list(string)
}
