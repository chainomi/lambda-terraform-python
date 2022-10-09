terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.34.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.1.1"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "2.2.0"
    }  
  }

  required_version = ">= 0.14"

}

