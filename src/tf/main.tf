locals {
  x86_public_vps_target = "x86-vps-node-01.levizitting.com"

  records = {
    "hello-nginx" = {
      type    = "CNAME"
      content = local.x86_public_vps_target
      proxied = false
      ttl     = 300
    }
  }
}

resource "cloudflare_dns_record" "core" {
  for_each = local.records

  zone_id = data.cloudflare_zone.sgf_dev.id
  name    = each.key
  type    = each.value.type
  content = each.value.content
  proxied = each.value.proxied
  ttl     = each.value.ttl
}
