terraform {
  required_version = ">= 1.1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.73.0"
    }

    local = {
      source  = "hashicorp/local"
      version = ">= 2.1.0"
    }

    template = {
      source  = "hashicorp/template"
      version = ">= 2.2.0"
    }
  }
  # backend "s3" {
  #   bucket = "holacash-tfstate"
  #   key    = "tf/state"
  #   region = "us-east-1"
  # }
}
