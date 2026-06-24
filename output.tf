output "instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.web-server.id
}

output "cloud" {
  description = "Cloud Provider"
  value       = "AWS"
}

data "aws_caller_identity" "current" {}

output "aws_account_id" {
  description = "AWS Account ID"
  value       = data.aws_caller_identity.current.account_id
}