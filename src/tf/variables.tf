variable "cloudflare_api_token" {
  description = "Cloudflare API token with DNS edit permissions"
  type        = string
  sensitive   = true
}

variable "cloudflare_zone_name" {
  description = "Cloudflare zone name to manage"
  type        = string
  default     = "sgf.dev"
}

variable "infra_public_edge_state_bucket" {
  description = "S3 bucket holding infra-public-edge remote state"
  type        = string
  default     = "levizitting-infra-tf-state"
}

variable "infra_public_edge_state_key" {
  description = "S3 object key for infra-public-edge remote state"
  type        = string
  default     = "public-vps/terraform.tfstate"
}

variable "infra_public_edge_state_region" {
  description = "AWS region for infra-public-edge remote state"
  type        = string
  default     = "us-east-2"
}
