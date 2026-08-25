output "instance_id" {
  description = "EC2 Instance ID"
  # Splat, not a bare .id: module_catalog.go registers ec2_instance_id with
  # Shape: ShapeList and indexes [0] when wiring it into an ALB/NLB target_id.
  # A bare string here would render module.<ec2>.instance_id[0] against a string
  # and fail at plan.
  value = aws_instance.web-server[*].id
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

# ---- Producer outputs for DAG wiring ----
# aws_instance.web-server declares neither count nor for_each, so it is a single
# object. mpaas-ai-module@v1.0.3 wrote these as
# `{ for k, v in aws_instance.web-server : k => v.id }`, which iterates the
# resource's ATTRIBUTES and then dereferences .id on a string — accepted by
# `terraform validate`, rejected by every `terraform plan` with
# "Can't access attributes on a primitive-typed value (string)".
output "web_server_id" {
  value = aws_instance.web-server.id
}

output "web_server_arn" {
  value = aws_instance.web-server.arn
}

output "web_server_private_ip" {
  value = aws_instance.web-server.private_ip
}

output "secret_key_arn" {
  value = aws_secretsmanager_secret.secret_key.arn
}

output "secret_key_name" {
  value = aws_secretsmanager_secret.secret_key.name
}
