terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "devi-tf-state-file-bucket"
    key = "devi-state-file-task-modules"
    region = "us-east-2"
  }
}

provider "aws" {
    region = "us-east-2" 
}