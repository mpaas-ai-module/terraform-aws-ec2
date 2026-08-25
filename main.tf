######################################
# to fetch existing key automatically using Key Alias
######################################
#
# Two ways in, because the two platforms supply the key differently:
#
#   kms_key_id     mpaas-ai passes the CMK arn straight through — the Ec2
#                  template renders `kms_key_id = var.<name>_kms_key_id`, wired
#                  from the KMS node in the architecture (dependency_fields.py).
#   kms_key_alias  old mpaas passes nothing and relies on this lookup finding
#                  alias/mm_cmk_kms in the project's own account.
#
# The lookup is created ONLY when kms_key_id is empty. Declaring it
# unconditionally would read the alias on every plan, so a project whose account
# has no alias/mm_cmk_kms fails even though it supplied the arn directly.
data "aws_kms_key" "existing" {
  count  = var.kms_key_id == "" ? 1 : 0
  key_id = var.kms_key_alias
}

locals {
  # one() rather than [0]: with count = 0 the list is empty, and indexing it
  # errors even on the branch the conditional does not take.
  kms_key_arn = var.kms_key_id != "" ? var.kms_key_id : one(data.aws_kms_key.existing[*].arn)
}

resource "aws_instance" "web-server" {
  disable_api_termination = true
  tags = {
    Name      = var.name
    compliant = var.compliant
  }


  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.generated_key.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  root_block_device {
    volume_size           = var.root_block_volume_size
    delete_on_termination = var.boot_disk_delete_on_termination
    encrypted             = var.root_block_encryption
    volume_type           = var.root_block_volume_type
    kms_key_id            = local.kms_key_arn
  }
  # Additional EBS block device, conditionally created
  dynamic "ebs_block_device" {
    for_each = var.data_block_needed ? [1] : []
    content {
      device_name           = var.data_ebs_name
      volume_size           = var.data_ebs_volume_size
      encrypted             = var.data_ebs_encryption
      delete_on_termination = var.data_disk_delete_on_termination
      volume_type           = var.data_ebs_volume_type
      iops                  = var.data_ebs_iops
      kms_key_id            = local.kms_key_arn
    }
  }

  user_data = var.is_os_linux ? templatefile("${path.module}/host-defender.tpl", {}) : templatefile("${path.module}/windows_startup_script.tpl", {})
  # user_data = var.is_os_linux ? templatefile("${path.module}/linux_startup_script.tpl", {}) : templatefile("${path.module}/windows_startup_script.tpl", {})
  lifecycle {
    ignore_changes = [tags]
  }
  metadata_options {
    http_tokens                 = var.http_tokens
    http_put_response_hop_limit = var.http_put_response_hop_limit
  }
}

resource "tls_private_key" "key" {
  algorithm = var.key_algorithm
  rsa_bits  = var.rsa_bits
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.key.public_key_openssh
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_secretsmanager_secret" "secret_key" {
  name_prefix = var.name
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_secretsmanager_secret_version" "secret_key_value" {
  secret_id     = aws_secretsmanager_secret.secret_key.id
  secret_string = tls_private_key.key.private_key_pem
}
