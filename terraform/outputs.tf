output "bucket_name" {
  description = "Name of the encrypted S3 bucket"
  value       = aws_s3_bucket.secure.id
}

output "bucket_arn" {
  description = "ARN of the encrypted S3 bucket"
  value       = aws_s3_bucket.secure.arn
}
