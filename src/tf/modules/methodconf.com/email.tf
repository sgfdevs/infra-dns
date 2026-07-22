locals {
  methodconf_com_dkim_public_key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAptycD1pDM3MJ0wYI7PIcfLeznUKztxu/GP5rW4o/UEhHVNlbmSKYrrqP5hv3uj3qxHRL4jokXO05RKQeelq3QkQS5YfQdwZiQd4GsiVkbWgNzGUo4Jn219wHWkJvZQK2J1lLaiWOB65hMDAYqAyy56IrEnX8q5q8wUcEHxhKVrT7ibHX6HcB9dj34NQ13X5b8yTAVvmv9DaHku4CAx1BZ7IBh6AVBOoNgQdxP9fpwCPom70YuKksza5dBoC9NRbZS77+n6weDC9+Rlj19G5mg5Q49cVyoVMEa2KaYtFNqDhP383FVoCxRqy6r8oNWCheQQ9NphnqxQVr1sX8g24nuwIDAQAB"
}

resource "cloudflare_dns_record" "methodconf_com_access" {
  for_each = toset(["mail", "mailadmin", "webmail"])

  zone_id = var.zone_id
  name    = each.key
  type    = "CNAME"
  content = "pixel.mxrouting.net"
  comment = var.comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "methodconf_com_mx" {
  for_each = {
    primary = {
      content  = "pixel.mxrouting.net"
      priority = 10
    }
    secondary = {
      content  = "pixel-relay.mxrouting.net"
      priority = 20
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

resource "cloudflare_dns_record" "methodconf_com_spf" {
  zone_id = var.zone_id
  name    = "@"
  type    = "TXT"
  content = "v=spf1 include:mxlogin.com -all"
  comment = var.comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "methodconf_com_dkim" {
  zone_id = var.zone_id
  name    = "x._domainkey"
  type    = "TXT"
  content = "v=DKIM1; k=rsa; p=${local.methodconf_com_dkim_public_key}"
  comment = var.comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "methodconf_com_dmarc" {
  zone_id = var.zone_id
  name    = "_dmarc"
  type    = "TXT"
  content = "v=DMARC1; p=none; pct=100; rua=mailto:re+e5evkelgcqo@dmarc.postmarkapp.com; sp=none; aspf=r;"
  comment = var.comment
  proxied = false
  ttl     = 1
}
