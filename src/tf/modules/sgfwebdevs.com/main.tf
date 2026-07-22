terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
}

locals {
  records = {
    admin = {
      name    = "admin"
      type    = "A"
      content = "198.211.115.135"
      proxied = false
      ttl     = 1
    }
    git = {
      name    = "git"
      type    = "A"
      content = "104.131.97.151"
      proxied = false
      ttl     = 1
    }
    git_test = {
      name    = "git-test"
      type    = "A"
      content = "104.131.97.151"
      proxied = false
      ttl     = 1
    }
    sails = {
      name    = "sails"
      type    = "A"
      content = "104.236.36.116"
      proxied = false
      ttl     = 1
    }
    wildcard = {
      name    = "*"
      type    = "A"
      content = "104.131.97.151"
      proxied = false
      ttl     = 1
    }
    apex = {
      name    = "@"
      type    = "A"
      content = "162.243.233.179"
      proxied = false
      ttl     = 1
    }
    stomp = {
      name    = "stomp"
      type    = "A"
      content = "104.236.54.113"
      proxied = false
      ttl     = 1
    }
    winner = {
      name    = "winner"
      type    = "A"
      content = "104.131.97.151"
      proxied = false
      ttl     = 1
    }
    www = {
      name    = "www"
      type    = "A"
      content = "104.131.97.151"
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
