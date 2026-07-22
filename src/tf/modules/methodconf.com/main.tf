terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
}

locals {
  records = {
    legacy_2020 = {
      name    = "2020"
      type    = "CNAME"
      content = "2020-methodconf.netlify.app"
      proxied = false
      ttl     = 1
    }
    cms = {
      name    = "cms"
      type    = "CNAME"
      content = "middleout.levizitting.com"
      proxied = true
      ttl     = 1
    }
    links = {
      name    = "links"
      type    = "CNAME"
      content = "middleout.levizitting.com"
      proxied = true
      ttl     = 1
    }
    apex = {
      name    = "@"
      type    = "CNAME"
      content = "middleout.levizitting.com"
      proxied = true
      ttl     = 1
    }
    staging = {
      name    = "staging"
      type    = "CNAME"
      content = "middleout.levizitting.com"
      proxied = true
      ttl     = 1
    }
    www = {
      name    = "www"
      type    = "CNAME"
      content = "methodconf.com"
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
