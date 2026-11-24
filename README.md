# AWS S3 Static Website Hosting with Terraform

This project uses Terraform to automatically deploy a static website (`dior-jenna`) onto an AWS S3 bucket configured for public web hosting.

## What Terraform Builds

1. **Amazon S3 Bucket (`aws_s3_bucket`):** Creates the storage bucket for the website.
2. **Public Access & Bucket Policy (`aws_s3_bucket_public_access_block`, `aws_s3_bucket_policy`):** Unlocks public read access so visitors can view the website in their browser.
3. **Static Website Hosting (`aws_s3_bucket_website_configuration`):** Configures S3 to serve `index.html` as a web server.
4. **Automatic File Upload (`aws_s3_object`):** Uploads all HTML, CSS, JavaScript, fonts, and image files with the proper content types.

## Project Files

- `main.tf` — Main Terraform configuration for S3 hosting and file uploads
- `variables.tf` — Input variables (`aws_region`, `bucket_name`, `website_folder`, `project_tag`)
- `outputs.tf` — Outputs the live website URL and bucket ARN
- `terraform.tfvars.example` — Example variable values
- `dior-jenna/` — Static website source files

## How to Use This Template

1. Copy `terraform.tfvars.example` to `terraform.tfvars` and set your unique S3 bucket name:
   ```hcl
   bucket_name    = "your-unique-bucket-name"
   website_folder = "dior-jenna"
   ```
2. Run Terraform in your terminal:
   ```bash
   terraform init
   terraform apply -auto-approve
   ```
3. Open the `website_url` printed in the terminal.

## Clean Up (Delete AWS Resources)

```bash
terraform destroy -auto-approve
```
