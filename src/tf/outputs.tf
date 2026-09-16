output "cloudflare_zone_id" {
  description = "Cloudflare zone ID for managed zone"
  value       = data.cloudflare_zone.sgf_dev.id
}

output "public_edge_target" {
  description = "Shared edge target hostname for public platform CNAMEs"
  value       = local.public_edge_target
}
