variable "zone_id" {
  description = "Cloudflare zone ID for sgf.dev"
  type        = string
}

variable "comment" {
  description = "Comment applied to managed DNS records"
  type        = string
}

variable "x86_public_vps_target" {
  description = "Shared edge target hostname for public platform CNAMEs"
  type        = string
}
