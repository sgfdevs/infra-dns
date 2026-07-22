resource "cloudflare_dns_record" "sgfwebdevs_com_ses_dkim" {
  for_each = {
    "elnj54wqvzpnpl2qwz4wvvoajjxp52da" = "elnj54wqvzpnpl2qwz4wvvoajjxp52da.dkim.amazonses.com"
    "ib5cwsobddmfnjgs6ehk3nd7jvnucoba" = "ib5cwsobddmfnjgs6ehk3nd7jvnucoba.dkim.amazonses.com"
    "o7dof6ixwq3u2eeop5nwjndad3d2bdec" = "o7dof6ixwq3u2eeop5nwjndad3d2bdec.dkim.amazonses.com"
  }

  zone_id = var.zone_id
  name    = "${each.key}._domainkey"
  type    = "CNAME"
  content = each.value
  comment = var.comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "sgfwebdevs_com_mx" {
  zone_id  = var.zone_id
  name     = "@"
  type     = "MX"
  content  = "inbound-smtp.us-west-2.amazonaws.com"
  priority = 10
  comment  = var.comment
  proxied  = false
  ttl      = 1
}

resource "cloudflare_dns_record" "sgfwebdevs_com_ses_verification" {
  zone_id = var.zone_id
  name    = "_amazonses"
  type    = "TXT"
  content = "sIVfRO5IGWfzsvs5trihmWgACiBR5iKLjZ1mssFbRJ8="
  comment = var.comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "sgfwebdevs_com_ses_verification_legacy" {
  zone_id = var.zone_id
  name    = "@"
  type    = "TXT"
  content = "amazonses:sIVfRO5IGWfzsvs5trihmWgACiBR5iKLjZ1mssFbRJ8="
  comment = var.comment
  proxied = false
  ttl     = 1
}
