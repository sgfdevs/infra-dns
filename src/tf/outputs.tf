output "cloudflare_zone_id" {
  description = "Cloudflare zone ID for managed zone"
  value       = data.cloudflare_zone.sgf_dev.id
}

output "x86_public_vps_target" {
  description = "Shared edge target hostname for public platform CNAMEs"
  value       = local.x86_public_vps_target
}
