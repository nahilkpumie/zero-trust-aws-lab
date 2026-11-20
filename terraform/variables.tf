variable "aws_region" {
  description = "AWS region used for all resources"
  type        = string
  default     = "eu-west-3"
}

variable "project_name" {
  description = "Prefix applied to resource names and tags"
  type        = string
  default     = "zero-trust-lab"
}
