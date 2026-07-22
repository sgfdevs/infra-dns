terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
}

locals {
  records = {
    app = {
      name    = "app"
      type    = "A"
      content = "104.214.115.18"
      proxied = false
      ttl     = 1
    }
    apex = {
      name    = "@"
      type    = "A"
      content = "104.214.115.18"
      proxied = false
      ttl     = 1
    }
    www = {
      name    = "www"
      type    = "A"
      content = "104.214.115.18"
      proxied = false
      ttl     = 1
    }
    apex_ipv6_1 = {
      name    = "@"
      type    = "AAAA"
      content = "2606:4700:3036::6815:516b"
      proxied = true
      ttl     = 1
    }
    apex_ipv6_2 = {
      name    = "@"
      type    = "AAAA"
      content = "2606:4700:3037::ac43:8de3"
      proxied = true
      ttl     = 1
    }
    www_ipv6_1 = {
      name    = "www"
      type    = "AAAA"
      content = "2606:4700:3036::6815:516b"
      proxied = true
      ttl     = 1
    }
    www_ipv6_2 = {
      name    = "www"
      type    = "AAAA"
      content = "2606:4700:3037::ac43:8de3"
      proxied = true
      ttl     = 1
    }
    google_site_verification = {
      name    = "@"
      type    = "TXT"
      content = "google-site-verification=BeGYFyNLtK4yhiSLYQsu1eCcRTbBL93D7qzQpwJPPxo"
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
