output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "internet_gateway_id" {
  value = module.vpc.internet_gateway_id
}

#output "nat_gateway_id" {
#  value = module.vpc.nat_gateway_id
#}

output "s3_bucket_name" {
  value = module.s3_backend.s3_bucket_name
}
