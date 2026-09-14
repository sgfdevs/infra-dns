terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
}

locals {
  records = {
    apex = {
      name    = "@"
      type    = "CNAME"
      content = var.k3s_tunnel_target
      proxied = true
      ttl     = 1
    }
    score = {
      name    = "score"
      type    = "CNAME"
      content = "h4g1.logic40.net"
      proxied = false
      ttl     = 1
    }
    staging = {
      name    = "staging"
      type    = "CNAME"
      content = var.x86_public_vps_target
      proxied = false
      ttl     = 300
    }
    www = {
      name    = "www"
      type    = "CNAME"
      content = var.k3s_tunnel_target
      proxied = true
      ttl     = 1
    }
  }
}

resource "cloudflare_dns_record" "core" {
  for_each = local.records

  zone_id  = var.zone_id
  name     = each.value.name
  type     = each.value.type
  content  = each.value.content
  priority = try(each.value.priority, null)
  comment  = var.comment
  proxied  = each.value.proxied
  ttl      = each.value.ttl
}
