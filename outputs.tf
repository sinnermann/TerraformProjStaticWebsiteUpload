output "website_url" {
  description = "Public HTTP endpoint for the S3 static website"
  value       = "http://${aws_s3_bucket_website_configuration.website_config.website_endpoint}"
}

output "bucket_arn" {
  description = "ARN of the created S3 bucket"
  value       = aws_s3_bucket.my_bucket.arn
}
