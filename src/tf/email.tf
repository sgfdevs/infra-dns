locals {
  email_sgf_dev_dkim_public_key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA6za72OrWxhqepHCK5+RPWFpo0zs3A2HeyHsDwmiy7pQDdWvzHJAysYEwYr25IdA8UmMcg2ArOQgC+KYkyLlvUf7wKf7s0DIIP3rzqVxD/rt8qUnYol/lfWGTwUlEhJReGHp6y8i0EP9CtLWAWZaTWg1Jm3/OzO5NGrqYP9EQcg4kbgAbm/KraQ6kKEiZgBt7Qxqrev07fL0YuNVRn4qxkOlpaJmJHaVoOreB+xksvb5WTFi/3E3439TOHHl8Cdw4MLz9AY1bSkZd1kYRp2erQsqHsLmVJGqinmFSobnki8a8GFYpNxF0rZ6kxrB8pYrnXGL4mMbVbtWm6arkbmTeUQIDAQAB"
  sgf_dev_mail_dkim_public_key  = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDeMVIzrCa3T14JsNY0IRv5/2V1/v2itlviLQBwXsa7shBD6TrBkswsFUToPyMRWC9tbR/5ey0nRBH0ZVxp+lsmTxid2Y2z+FApQ6ra2VsXfbJP3HE6wAO0YTVEJt1TmeczhEd2Jiz/fcabIISgXEdSpTYJhb0ct0VJRxcg4c8c7wIDAQAB"
}

resource "cloudflare_dns_record" "sgf_dev_mx" {
  zone_id  = data.cloudflare_zone.sgf_dev.id
  name     = "@"
  type     = "MX"
  content  = "sgf-dev.mail.protection.outlook.com"
  priority = 0
  comment  = local.dns_record_comment
  proxied  = false
  ttl      = 900
}

resource "cloudflare_dns_record" "sgf_dev_spf" {
  zone_id = data.cloudflare_zone.sgf_dev.id
  name    = "@"
  type    = "TXT"
  content = "v=spf1 include:spf.protection.outlook.com -all"
  comment = local.dns_record_comment
  proxied = false
  ttl     = 900
}

resource "cloudflare_dns_record" "sgf_dev_microsoft_dkim" {
  for_each = {
    selector_1 = {
      name    = "selector1._domainkey"
      content = "selector1-sgf-dev._domainkey.sgfdev.onmicrosoft.com"
    }
    selector_2 = {
      name    = "selector2._domainkey"
      content = "selector2-sgf-dev._domainkey.sgfdev.onmicrosoft.com"
    }
  }

  zone_id = data.cloudflare_zone.sgf_dev.id
  name    = each.value.name
  type    = "CNAME"
  content = each.value.content
  comment = local.dns_record_comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "sgf_dev_dmarc" {
  zone_id = data.cloudflare_zone.sgf_dev.id
  name    = "_dmarc"
  type    = "TXT"
  content = "v=DMARC1; p=none; pct=100; rua=mailto:re+w7uekgngs7n@dmarc.postmarkapp.com; sp=none; aspf=r;"
  comment = local.dns_record_comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "sgf_dev_bimi" {
  zone_id = data.cloudflare_zone.sgf_dev.id
  name    = "default._bimi"
  type    = "TXT"
  content = "\"v=BIMI1; l=https://www.sgf.dev/bimi.svg; a=; avp=brand;\""
  comment = local.dns_record_comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "sgf_dev_ses_verification" {
  zone_id = data.cloudflare_zone.sgf_dev.id
  name    = "_amazonses"
  type    = "TXT"
  content = "8bGAoexnHvNluOfiXVVpN1ov5SuDB7+hllR0RTVLHus="
  comment = local.dns_record_comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "sgf_dev_ses_dkim" {
  for_each = {
    "tgspmcpf225ezxnpb3ulbuizyqyotuji" = "tgspmcpf225ezxnpb3ulbuizyqyotuji.dkim.amazonses.com"
    "xxjzrcixpkgijyd4zvaovotpb47eaupc" = "xxjzrcixpkgijyd4zvaovotpb47eaupc.dkim.amazonses.com"
    "aeh65o4lv7qonzgcxjds73hbg6krcrao" = "aeh65o4lv7qonzgcxjds73hbg6krcrao.dkim.amazonses.com"
  }

  zone_id = data.cloudflare_zone.sgf_dev.id
  name    = "${each.key}._domainkey"
  type    = "CNAME"
  content = each.value
  comment = local.dns_record_comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "sgf_dev_smtp2go_dkim" {
  zone_id = data.cloudflare_zone.sgf_dev.id
  name    = "s470710._domainkey"
  type    = "CNAME"
  content = "dkim.smtp2go.net"
  comment = local.dns_record_comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "sgf_dev_brevo_verification" {
  zone_id = data.cloudflare_zone.sgf_dev.id
  name    = "@"
  type    = "TXT"
  content = "brevo-code:45c4b9a09b510161bd655fb1198fb245"
  comment = local.dns_record_comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "sgf_dev_mail_dkim" {
  zone_id = data.cloudflare_zone.sgf_dev.id
  name    = "mail._domainkey"
  type    = "TXT"
  content = "k=rsa;p=${local.sgf_dev_mail_dkim_public_key}"
  comment = local.dns_record_comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "email_sgf_dev_mx" {
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

  zone_id  = data.cloudflare_zone.sgf_dev.id
  name     = "email"
  type     = "MX"
  content  = each.value.content
  priority = each.value.priority
  comment  = local.dns_record_comment
  proxied  = false
  ttl      = 1
}

resource "cloudflare_dns_record" "email_sgf_dev_spf" {
  zone_id = data.cloudflare_zone.sgf_dev.id
  name    = "email"
  type    = "TXT"
  content = "v=spf1 include:mxlogin.com -all"
  comment = local.dns_record_comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "email_sgf_dev_dkim" {
  zone_id = data.cloudflare_zone.sgf_dev.id
  name    = "x._domainkey.email"
  type    = "TXT"
  content = "v=DKIM1; k=rsa; p=${local.email_sgf_dev_dkim_public_key}"
  comment = local.dns_record_comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "email_sgf_dev_dmarc" {
  zone_id = data.cloudflare_zone.sgf_dev.id
  name    = "_dmarc.email"
  type    = "TXT"
  content = "v=DMARC1; p=none; pct=100; rua=mailto:re+myq6uaa4s9o@dmarc.postmarkapp.com; sp=none; aspf=r;"
  comment = local.dns_record_comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "email_sgf_dev_bimi" {
  zone_id = data.cloudflare_zone.sgf_dev.id
  name    = "default._bimi.email"
  type    = "TXT"
  content = "\"v=BIMI1; l=https://www.sgf.dev/bimi.svg; a=; avp=brand;\""
  comment = local.dns_record_comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "api_sgf_dev_mx" {
  zone_id  = data.cloudflare_zone.sgf_dev.id
  name     = "api"
  type     = "MX"
  content  = "mx5.dnihost.net"
  priority = 10
  comment  = local.dns_record_comment
  proxied  = false
  ttl      = 1
}

resource "cloudflare_dns_record" "api_sgf_dev_ses_verification" {
  zone_id = data.cloudflare_zone.sgf_dev.id
  name    = "_amazonses.api"
  type    = "TXT"
  content = "ad1eLGblxZZAo4S+fV7ET4YospzsupjuHHAzy4en03M="
  comment = local.dns_record_comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "api_sgf_dev_ses_dkim" {
  for_each = {
    "3w5zvlzllozubuhhqj3rg2zbqi7cx3hx" = "3w5zvlzllozubuhhqj3rg2zbqi7cx3hx.dkim.amazonses.com"
    "nmfla6n2zcmebt4lczpav4no2iupoc2k" = "nmfla6n2zcmebt4lczpav4no2iupoc2k.dkim.amazonses.com"
    "g7vdgtjbddhiqf73iaobvawexotf4xaf" = "g7vdgtjbddhiqf73iaobvawexotf4xaf.dkim.amazonses.com"
  }

  zone_id = data.cloudflare_zone.sgf_dev.id
  name    = "${each.key}._domainkey.api"
  type    = "CNAME"
  content = each.value
  comment = local.dns_record_comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "mail_out_aws_h4g_sgf_dev_mx" {
  zone_id  = data.cloudflare_zone.sgf_dev.id
  name     = "mail-out-aws-h4g"
  type     = "MX"
  content  = "feedback-smtp.us-east-1.amazonses.com"
  priority = 10
  comment  = local.dns_record_comment
  proxied  = false
  ttl      = 1
}

resource "cloudflare_dns_record" "mail_out_aws_h4g_sgf_dev_spf" {
  zone_id = data.cloudflare_zone.sgf_dev.id
  name    = "mail-out-aws-h4g"
  type    = "TXT"
  content = "v=spf1 include:amazonses.com ~all"
  comment = local.dns_record_comment
  proxied = false
  ttl     = 1
}
