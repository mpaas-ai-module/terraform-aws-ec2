output "instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.web-server[*].id
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

# --- Added from old repo (missing in new as of comparison) ---
output "my-ouput" {
  value = "Hi Welcome "
}

# ---- Added producer outputs for DAG wiring (mpaas-ai-module migration) ----
output "web_server_id" {
  value = { for k, v in aws_instance.web-server : k => v.id }
}
output "web_server_arn" {
  value = { for k, v in aws_instance.web-server : k => v.arn }
}
output "web_server_private_ip" {
  value = { for k, v in aws_instance.web-server : k => v.private_ip }
}
output "secret_key_arn" {
  value = aws_secretsmanager_secret.secret_key.arn
}
output "secret_key_name" {
  value = aws_secretsmanager_secret.secret_key.name
}
output "s3_bucket_arn" {
  value = aws_s3_bucket.s3_bucket.arn
}
output "s3_bucket_bucket" {
  value = aws_s3_bucket.s3_bucket.bucket
}
output "s3_bucket_bucket_domain_name" {
  value = aws_s3_bucket.s3_bucket.bucket_domain_name
}
