output "cloudflare_zone_id" {
  description = "Cloudflare zone ID for managed zone"
  value       = data.cloudflare_zone.sgf_dev.id
}

output "x86_public_vps_target" {
  description = "Target hostname for hello-nginx CNAME"
  value       = local.x86_public_vps_target
}

output "managed_record_ids" {
  description = "Cloudflare DNS record IDs managed by this stack"
  value = {
    for name, record in cloudflare_dns_record.core :
    name => record.id
  }
}
