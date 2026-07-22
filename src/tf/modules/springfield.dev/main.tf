terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
}

locals {
  records = {
    wildcard = {
      name    = "*"
      type    = "A"
      content = "75.126.102.228"
      proxied = false
      ttl     = 1
    }
    apex = {
      name    = "@"
      type    = "A"
      content = "75.126.102.228"
      proxied = false
      ttl     = 1
    }
    www = {
      name    = "www"
      type    = "A"
      content = "75.126.102.228"
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
