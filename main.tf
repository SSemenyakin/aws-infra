provider "aws" {
  version                 = "1.43.2"
  shared_credentials_file = "/home/sergey/.aws/credentials"
  profile                 = "default"
  region                  = "us-east-1"
}

terraform {
  version = "0.11.10"

  backend "s3" {
    bucket = "my-aws-infra"
    key    = "infra/infra.tfstate"
    region = "us-east-1"
  }
}
