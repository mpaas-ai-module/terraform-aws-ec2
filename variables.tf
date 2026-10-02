variable "boot_disk_delete_on_termination" {
  description = "deletion protection config of boot disk"
  type        = bool
}

variable "ami" {
  description = "ID of AMI to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
}

variable "root_block_volume_size" {
  description = "Whether to create an instance Size of the root volume in gigabytes"
  type        = number
}

variable "root_block_encryption" {
  description = "root_block_encryption"
  type        = bool
}
# variable "http_endpoint" {
#   description = "http_endpoint"
#   type        = string
# }
variable "http_tokens" {
  description = "http_tokens"
  type        = string
}
variable "http_put_response_hop_limit" {
  description = "http_put_response_hop_limit"
  type        = number
}

# variable "instance_name" {
#   description = "Name to be used on EC2 instance created"
#   type        = string
# }
variable "name" {
  description = "Key name of the Key Pair to use for the instance; which can be managed using the aws_key_pair resource"
  type        = string
}
variable "compliant" {
  type        = bool
  default     = true
  description = "Tag to ensure compliance"
}
variable "key_name" {
  description = "Key name of the Key Pair to use for the instance; which can be managed using the aws_key_pair resource"
  type        = string
}

variable "region" {
  description = "AWS Region the instance is launched in"
  type        = string
}

variable "subnet_id" {
  description = "VPC Subnet ID to launch in"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "VPC security group for your instance."
  type        = list(string)
}
variable "role_arn" {
  description = " The ARN of the IAM role"
  type        = string
}
variable "is_os_linux" {
  description = "whether the OS is linux or windows"
  type        = bool
}
variable "data_block_needed" {
  description = "addtnl_block_needed"
  type        = bool
  default     = false
}
# variable "data_ebs_name" {
#   description = "ebs_block_name"
#   type = string
# }
# variable "data_ebs_volume_size" {
#   description = "additional_ebs_volume_size"
#   type = number
#   default = null
# }
# variable "data_ebs_encryption" {
#   description = "additional_ebs_encryption"
#   type = bool
# }
# variable "data_disk_delete_on_termination" {
#   description = "addtnl_disk_delete_on_termination"
#   type = bool
# }
variable "root_block_volume_type" {
  description = "root_block_volume_type"
  type        = string
}
# variable "data_ebs_volume_type" {
#   description = "data_ebs_volume_type"
#   type = string
# }
# variable "data_ebs_iops" {
#   description = "data_ebs_iops"
#   type = number
#   default = null
# }
variable "data_ebs_name" {
  description = "ebs_block_name"
  type        = string
  default     = ""
}
variable "data_ebs_volume_size" {
  description = "additional_ebs_volume_size"
  type        = number
  default     = 0
}
variable "data_ebs_encryption" {
  description = "additional_ebs_encryption"
  type        = bool
  default     = true
}
variable "data_disk_delete_on_termination" {
  description = "addtnl_disk_delete_on_termination"
  type        = bool
  default     = true
}

variable "data_ebs_volume_type" {
  description = "data_ebs_volume_type"
  type        = string
  default     = "gp3"
}
variable "data_ebs_iops" {
  description = "data_ebs_iops"
  type        = number
  default     = 0
}
variable "kms_key_alias" {
  type        = string
  description = "ARN of the existing Customer Managed KMS Key used to encrypt the RDS database storage"
  default     = "alias/mm_cmk_kms"
}

variable "key_algorithm" {
  type        = string
  default     = "RSA"
  description = "Key algorithm"
}
variable "rsa_bits" {
  type        = number
  default     = 4690
  description = "RSA bits for the key generation"
}