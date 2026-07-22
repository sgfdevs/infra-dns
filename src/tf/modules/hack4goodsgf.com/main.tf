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
      type    = "A"
      content = "104.207.254.9"
      proxied = false
      ttl     = 1
    }
    score = {
      name    = "score"
      type    = "CNAME"
      content = "h4g1.logic40.net"
      proxied = false
      ttl     = 1
    }
    www = {
      name    = "www"
      type    = "CNAME"
      content = "hack4goodsgf.com"
      proxied = false
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
