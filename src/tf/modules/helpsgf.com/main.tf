terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
}

locals {
  records = {
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
