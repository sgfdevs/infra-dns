variable "cloudflare_api_token" {
  description = "Cloudflare API token with DNS edit permissions"
  type        = string
  sensitive   = true
}

variable "aws_region" {
  description = "AWS region containing the SES identities"
  type        = string
  default     = "us-east-2"
}
