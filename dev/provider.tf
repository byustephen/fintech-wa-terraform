terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.30.0"
    }
  }

  # backend "s3" {
  #   bucket  = "test-wafd-terraform-state-file-storage"
  #   key     = "global/s3/terraform.tfstate"
  #   region  = "us-west-2"
  #   encrypt = "true"
  # }
}

provider "aws" {
  region  = "us-west-2"
}


