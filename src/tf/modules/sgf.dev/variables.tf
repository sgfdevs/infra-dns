variable "zone_id" {
  description = "Cloudflare zone ID for sgf.dev"
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

variable "public_edge_target" {
  description = "Shared edge target hostname for public platform CNAMEs"
  type        = string
}

variable "k3s_tunnel_target" {
  description = "Cloudflare Tunnel target for public cluster services"
  type        = string
}
