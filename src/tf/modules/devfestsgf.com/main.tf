terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
}

locals {
  records = {
    legacy_2018 = {
      name    = "2018"
      type    = "A"
      content = "162.243.233.179"
      proxied = false
      ttl     = 1
    }
    apex_1 = {
      name    = "@"
      type    = "A"
      content = "151.101.1.195"
      proxied = false
      ttl     = 1
    }
    apex_2 = {
      name    = "@"
      type    = "A"
      content = "151.101.65.195"
      proxied = false
      ttl     = 1
    }
    google_site_verification = {
      name    = "@"
      type    = "TXT"
      content = "\"google-site-verification=a6FNiKWz0Upn8tp9nTM__vnQzUb6wrmW2y5enRnORC8\""
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
