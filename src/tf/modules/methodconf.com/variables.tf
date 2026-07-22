variable "zone_id" {
  description = "Cloudflare zone ID for methodconf.com"
  type        = string
}

variable "comment" {
  description = "Comment applied to managed DNS records"
  type        = string
}

variable "aws_region" {
  description = "AWS region containing the SES identity"
  type        = string
}
