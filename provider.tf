terraform {
  required_version = ">= 1.3"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      # >= 5.46.0, < 6.0.0 — every mpaas AWS module shares this constraint so a
      # multi-module root can resolve. Deliberately bounded: the next major is
      # unvalidated against these modules.
      version = "~> 5.46"
    }
  }
}

# No `backend "s3" {}` here. The backend belongs to the generated ROOT config
# (mpaas writes backend.<env>.tfvars and inits against it); declaring it inside
# the module makes the module unusable as a module.
#
# The generated root declares no provider "aws", so each module configures its
# own and assumes the project's account role. role_arn is injected by the
# platform from the AFT-created account id (never by the AI).
provider "aws" {
  assume_role {
    role_arn = var.role_arn
  }
  region = var.region
}
