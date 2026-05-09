terraform {
  backend "s3" {
    bucket         = "prj-google-boutique-tfstate-672965014914"
    key            = "prod/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "prj-google-boutique-tfstate-lock"
    encrypt        = true
  }
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 5.0" }
  }
}

provider "aws" {
  region = "ap-south-1"
  default_tags {
    tags = {
      Project     = "google-online-boutique"
      Environment = "prod"
      ManagedBy   = "terraform"
    }
  }
}
