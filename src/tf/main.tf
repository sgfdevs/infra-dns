locals {
  x86_public_vps_target = "x86-vps-node-01.levizitting.com"
  dns_record_comment    = "managedBy=tf,repo=sgfdevs/infra-dns"

  # Public SGF platform endpoints managed by this stack and routed to the shared edge.
  records = {
    "argocd" = {
      type    = "CNAME"
      content = local.x86_public_vps_target
      proxied = false
      ttl     = 300
    }
    "dex" = {
      type    = "CNAME"
      content = local.x86_public_vps_target
      proxied = false
      ttl     = 300
    }
    "auth" = {
      type    = "CNAME"
      content = local.x86_public_vps_target
      proxied = false
      ttl     = 300
    }
    "grafana" = {
      type    = "CNAME"
      content = local.x86_public_vps_target
      proxied = false
      ttl     = 300
    }
    "secrets" = {
      type    = "CNAME"
      content = local.x86_public_vps_target
      proxied = false
      ttl     = 300
    }
    "headlamp" = {
      type    = "CNAME"
      content = local.x86_public_vps_target
      proxied = false
      ttl     = 300
    }
    "longhorn" = {
      type    = "CNAME"
      content = local.x86_public_vps_target
      proxied = false
      ttl     = 300
    }
    "seaweedfs" = {
      type    = "CNAME"
      content = local.x86_public_vps_target
      proxied = false
      ttl     = 300
    }
    "traefik" = {
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
