variable "zone_id" {
  description = "Cloudflare zone ID for hack4goodsgf.com"
  type        = string
}

variable "comment" {
  description = "Comment applied to managed DNS records"
  type        = string
}

variable "k3s_tunnel_target" {
  description = "Cloudflare Tunnel CNAME target for public cluster traffic"
  type        = string
}

variable "public_edge_target" {
  description = "Shared edge target hostname for public platform CNAMEs"
  type        = string
}
