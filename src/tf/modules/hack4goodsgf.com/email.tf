locals {
  hack4goodsgf_com_dkim_public_key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0ODimRk2cBzFrgWDH9rFdfgzV3IHw8cqBEcwx0KlngoET2UfdiBDnNWWI+RNgxGfS890GwS7JV88uaXuHxWwakde21c6gMF7FSLI5vpVlU9ayAYc/ioakfa3Ecr5UkATrlPTgZki2PgxgCiKOH/Aa5oFHTu/YR6+csP2T1f5TPjrFuC9uUghGZRX94XLise3h2qdRg0IbxTLjF+e2QCrP6c0gAWOSzkR5r5ZOH0xG6BgOq27CJiuySx5FE2PhVs3zYOhra8DE6Z6bhYOKDyIGY7/eElgcMmdTuNyyujw6Bjh2zFLB4oPUhfBHvd+66zDmuj7XoKjKcu4nAX4jvgagwIDAQAB"
}

resource "cloudflare_dns_record" "hack4goodsgf_com_access" {
  for_each = toset(["mail", "mailadmin"])

  zone_id = var.zone_id
  name    = each.key
  type    = "CNAME"
  content = "pixel.mxrouting.net"
  comment = var.comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "hack4goodsgf_com_mx" {
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

resource "cloudflare_dns_record" "hack4goodsgf_com_spf" {
  zone_id = var.zone_id
  name    = "@"
  type    = "TXT"
  content = "\"v=spf1 include:mxlogin.com -all\""
  comment = var.comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "hack4goodsgf_com_dkim" {
  zone_id = var.zone_id
  name    = "x._domainkey"
  type    = "TXT"
  content = "\"v=DKIM1; k=rsa; p=${substr(local.hack4goodsgf_com_dkim_public_key, 0, 237)}\" \"${substr(local.hack4goodsgf_com_dkim_public_key, 237, -1)}\""
  comment = var.comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "hack4goodsgf_com_dmarc" {
  zone_id = var.zone_id
  name    = "_dmarc"
  type    = "TXT"
  content = "\"v=DMARC1; p=none; pct=100; rua=mailto:re+vaeco7g957f@dmarc.postmarkapp.com; sp=none; aspf=r;\""
  comment = var.comment
  proxied = false
  ttl     = 1
}
