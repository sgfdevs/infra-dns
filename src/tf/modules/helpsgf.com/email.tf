resource "cloudflare_dns_record" "helpsgf_com_mx" {
  for_each = {
    primary = {
      content  = "aspmx.l.google.com"
      priority = 1
    }
    alt1 = {
      content  = "alt1.aspmx.l.google.com"
      priority = 5
    }
    alt2 = {
      content  = "alt2.aspmx.l.google.com"
      priority = 5
    }
    alt3 = {
      content  = "alt3.aspmx.l.google.com"
      priority = 10
    }
    alt4 = {
      content  = "alt4.aspmx.l.google.com"
      priority = 10
    }
  }

  zone_id  = var.zone_id
  name     = "@"
  type     = "MX"
  content  = each.value.content
  priority = each.value.priority
  comment  = var.comment
  proxied  = false
  ttl      = 1
}

resource "cloudflare_dns_record" "helpsgf_com_ses_verification" {
  zone_id = var.zone_id
  name    = "_amazonses"
  type    = "TXT"
  content = "agM3t5yi5MRn58esHR3DZN+Ih29xj3e2t9N8herMIkw="
  comment = var.comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "helpsgf_com_ses_spf" {
  zone_id = var.zone_id
  name    = "amazonses"
  type    = "TXT"
  content = "v=spf1 include:amazonses.com ~all"
  comment = var.comment
  proxied = false
  ttl     = 1
}
