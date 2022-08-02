output "vpc_public_subnets" {
  description = "IDs of the VPC's public subnets"
  value       = module.vpc.public_subnets
}

output "ec2_instance_public_ips" {
  description = "Public IP addresses of EC2 instances"
  value       = module.ec2_instances[*].public_ip
}

output "website_bucket_arn" {
  description = "ARN of the bucket"
  value       = module.website-s3-bucket.arn
}

output "website_bucket_name" {
  description = "Name (id) of the bucket"
  value       = module.website-s3-bucket.name
}

output "website_bucket_domain" {
  description = "Domain name of the bucket"
  value       = module.website-s3-bucket.domain
}
