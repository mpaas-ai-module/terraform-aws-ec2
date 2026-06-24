terraform {
  required_version = ">= 0.13" #Recommended CLI version ">= 1.11.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.46.0" #Please refer official terraform provider documentation before updating provider version 
    }
  }
  backend "s3" {}
}
# PoC fork: embedded provider block removed (blocked depends_on/count/for_each)
