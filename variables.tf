variable "aws_region" {
  description = "AWS region where the S3 bucket will be created"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Globally unique name for the S3 bucket"
  type        = string
}

variable "website_folder" {
  description = "Local folder name containing the static website files"
  type        = string
  default     = "dior-jenna"
}

variable "project_tag" {
  description = "Project tag applied to AWS resources"
  type        = string
  default     = "Static Website Hosting With Terraform"
}
