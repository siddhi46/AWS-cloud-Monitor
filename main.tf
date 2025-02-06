provider "aws" {
  region = "us-east-1"
}

# 1. Create an S3 bucket to store user data
resource "aws_s3_bucket" "user_data" {
  bucket = "your-unique-bucket-name"  # Replace with a unique bucket name
  acl    = "private"
}

# 2. Create an IAM policy allowing access to the S3 bucket
resource "aws_iam_policy" "s3_upload_policy" {
  name        = "s3UploadPolicy"
  description = "IAM policy to allow access to upload to the user-data bucket"
  policy      = data.aws_iam_policy_document.s3_upload_policy_document.json
}

# 3. Create an IAM role to allow the application to upload to the bucket
resource "aws_iam_role" "app_role" {
  name               = "AppS3UploadRole"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

# 4. Attach the IAM policy to the IAM role
resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.app_role.name
  policy_arn = aws_iam_policy.s3_upload_policy.arn
}

# 5. Define the policy document to upload to the bucket
data "aws_iam_policy_document" "s3_upload_policy_document" {
  statement {
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.user_data.arn}/user-data/*"]
  }
}

# 6. Define the assume role policy document
data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# Optional: Outputs
output "bucket_name" {
  value = aws_s3_bucket.user_data.bucket
}

output "iam_role_arn" {
  value = aws_iam_role.app_role.arn
}
