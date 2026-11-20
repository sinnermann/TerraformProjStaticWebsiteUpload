provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name

  tags = {
    Project = var.project_tag
  }
}

# 1. Unlock public access on the bucket
resource "aws_s3_bucket_public_access_block" "my_bucket_public_access_block" {
  bucket = aws_s3_bucket.my_bucket.id

  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}

# 2. Enable Static Website Hosting
resource "aws_s3_bucket_website_configuration" "website_config" {
  bucket = aws_s3_bucket.my_bucket.id

  index_document {
    suffix = "index.html"
  }
}

# 3. Allow public read access to all website files
resource "aws_s3_bucket_policy" "public_read_policy" {
  bucket = aws_s3_bucket.my_bucket.id

  depends_on = [aws_s3_bucket_public_access_block.my_bucket_public_access_block]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.my_bucket.arn}/*"
      }
    ]
  })
}

# 4. Upload all files and nested folders inside var.website_folder
resource "aws_s3_object" "website_files" {
  for_each = fileset("${path.module}/${var.website_folder}", "**/*")

  bucket = aws_s3_bucket.my_bucket.id
  key    = each.value
  source = "${path.module}/${var.website_folder}/${each.value}"
  etag   = filemd5("${path.module}/${var.website_folder}/${each.value}")

  content_type = lookup({
    "html"  = "text/html",
    "css"   = "text/css",
    "js"    = "application/javascript",
    "json"  = "application/json",
    "jpg"   = "image/jpeg",
    "jpeg"  = "image/jpeg",
    "png"   = "image/png",
    "gif"   = "image/gif",
    "webp"  = "image/webp",
    "svg"   = "image/svg+xml",
    "ico"   = "image/x-icon",
    "woff"  = "font/woff",
    "woff2" = "font/woff2",
    "ttf"   = "font/ttf",
    "eot"   = "application/vnd.ms-fontobject"
  }, lower(element(split(".", each.value), length(split(".", each.value)) - 1)), "application/octet-stream")
}
