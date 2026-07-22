locals {
  email_sgf_dev_dkim_public_key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA6za72OrWxhqepHCK5+RPWFpo0zs3A2HeyHsDwmiy7pQDdWvzHJAysYEwYr25IdA8UmMcg2ArOQgC+KYkyLlvUf7wKf7s0DIIP3rzqVxD/rt8qUnYol/lfWGTwUlEhJReGHp6y8i0EP9CtLWAWZaTWg1Jm3/OzO5NGrqYP9EQcg4kbgAbm/KraQ6kKEiZgBt7Qxqrev07fL0YuNVRn4qxkOlpaJmJHaVoOreB+xksvb5WTFi/3E3439TOHHl8Cdw4MLz9AY1bSkZd1kYRp2erQsqHsLmVJGqinmFSobnki8a8GFYpNxF0rZ6kxrB8pYrnXGL4mMbVbtWm6arkbmTeUQIDAQAB"
  sgf_dev_mail_dkim_public_key  = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDeMVIzrCa3T14JsNY0IRv5/2V1/v2itlviLQBwXsa7shBD6TrBkswsFUToPyMRWC9tbR/5ey0nRBH0ZVxp+lsmTxid2Y2z+FApQ6ra2VsXfbJP3HE6wAO0YTVEJt1TmeczhEd2Jiz/fcabIISgXEdSpTYJhb0ct0VJRxcg4c8c7wIDAQAB"
  ses_email_identity            = "sgf.dev"
}

data "aws_sesv2_email_identity" "sgf_dev" {
  email_identity = local.ses_email_identity
}

data "aws_sesv2_email_identity_mail_from_attributes" "sgf_dev" {
  email_identity = data.aws_sesv2_email_identity.sgf_dev.email_identity
}

resource "cloudflare_dns_record" "sgf_dev_mx" {
  zone_id  = var.zone_id
  name     = "@"
  type     = "MX"
  content  = "sgf-dev.mail.protection.outlook.com"
  priority = 0
  comment  = var.comment
  proxied  = false
  ttl      = 900
}

resource "cloudflare_dns_record" "sgf_dev_spf" {
  zone_id = var.zone_id
  name    = "@"
  type    = "TXT"
  content = "v=spf1 include:spf.protection.outlook.com -all"
  comment = var.comment
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

  zone_id = var.zone_id
  name    = each.value.name
  type    = "CNAME"
  content = each.value.content
  comment = var.comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "sgf_dev_dmarc" {
  zone_id = var.zone_id
  name    = "_dmarc"
  type    = "TXT"
  content = "v=DMARC1; p=none; pct=100; rua=mailto:re+w7uekgngs7n@dmarc.postmarkapp.com; sp=none; aspf=r;"
  comment = var.comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "sgf_dev_bimi" {
  zone_id = var.zone_id
  name    = "default._bimi"
  type    = "TXT"
  content = "\"v=BIMI1; l=https://www.sgf.dev/bimi.svg; a=; avp=brand;\""
  comment = var.comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "sgf_dev_ses_dkim" {
  for_each = toset(data.aws_sesv2_email_identity.sgf_dev.dkim_signing_attributes[0].tokens)

  zone_id = var.zone_id
  name    = "${each.value}._domainkey"
  type    = "CNAME"
  content = "${each.value}.dkim.amazonses.com"
  comment = var.comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "sgf_dev_ses_mail_from_mx" {
  zone_id  = var.zone_id
  name     = data.aws_sesv2_email_identity_mail_from_attributes.sgf_dev.mail_from_domain
  type     = "MX"
  content  = "feedback-smtp.${var.aws_region}.amazonses.com"
  priority = 10
  comment  = var.comment
  proxied  = false
  ttl      = 1
}

resource "cloudflare_dns_record" "sgf_dev_ses_mail_from_spf" {
  zone_id = var.zone_id
  name    = data.aws_sesv2_email_identity_mail_from_attributes.sgf_dev.mail_from_domain
  type    = "TXT"
  content = "v=spf1 include:amazonses.com -all"
  comment = var.comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "sgf_dev_smtp2go_dkim" {
  zone_id = var.zone_id
  name    = "s470710._domainkey"
  type    = "CNAME"
  content = "dkim.smtp2go.net"
  comment = var.comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "sgf_dev_brevo_verification" {
  zone_id = var.zone_id
  name    = "@"
  type    = "TXT"
  content = "brevo-code:45c4b9a09b510161bd655fb1198fb245"
  comment = var.comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "sgf_dev_mail_dkim" {
  zone_id = var.zone_id
  name    = "mail._domainkey"
  type    = "TXT"
  content = "k=rsa;p=${local.sgf_dev_mail_dkim_public_key}"
  comment = var.comment
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

  zone_id  = var.zone_id
  name     = "email"
  type     = "MX"
  content  = each.value.content
  priority = each.value.priority
  comment  = var.comment
  proxied  = false
  ttl      = 1
}

resource "cloudflare_dns_record" "email_sgf_dev_spf" {
  zone_id = var.zone_id
  name    = "email"
  type    = "TXT"
  content = "v=spf1 include:mxlogin.com -all"
  comment = var.comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "email_sgf_dev_dkim" {
  zone_id = var.zone_id
  name    = "x._domainkey.email"
  type    = "TXT"
  content = "v=DKIM1; k=rsa; p=${local.email_sgf_dev_dkim_public_key}"
  comment = var.comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "email_sgf_dev_dmarc" {
  zone_id = var.zone_id
  name    = "_dmarc.email"
  type    = "TXT"
  content = "v=DMARC1; p=none; pct=100; rua=mailto:re+myq6uaa4s9o@dmarc.postmarkapp.com; sp=none; aspf=r;"
  comment = var.comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "email_sgf_dev_bimi" {
  zone_id = var.zone_id
  name    = "default._bimi.email"
  type    = "TXT"
  content = "\"v=BIMI1; l=https://www.sgf.dev/bimi.svg; a=; avp=brand;\""
  comment = var.comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "api_sgf_dev_mx" {
  zone_id  = var.zone_id
  name     = "api"
  type     = "MX"
  content  = "mx5.dnihost.net"
  priority = 10
  comment  = var.comment
  proxied  = false
  ttl      = 1
}

resource "cloudflare_dns_record" "api_sgf_dev_ses_verification" {
  zone_id = var.zone_id
  name    = "_amazonses.api"
  type    = "TXT"
  content = "ad1eLGblxZZAo4S+fV7ET4YospzsupjuHHAzy4en03M="
  comment = var.comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "api_sgf_dev_ses_dkim" {
  for_each = {
    "3w5zvlzllozubuhhqj3rg2zbqi7cx3hx" = "3w5zvlzllozubuhhqj3rg2zbqi7cx3hx.dkim.amazonses.com"
    "nmfla6n2zcmebt4lczpav4no2iupoc2k" = "nmfla6n2zcmebt4lczpav4no2iupoc2k.dkim.amazonses.com"
    "g7vdgtjbddhiqf73iaobvawexotf4xaf" = "g7vdgtjbddhiqf73iaobvawexotf4xaf.dkim.amazonses.com"
  }

  zone_id = var.zone_id
  name    = "${each.key}._domainkey.api"
  type    = "CNAME"
  content = each.value
  comment = var.comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "mail_out_aws_h4g_sgf_dev_mx" {
  zone_id  = var.zone_id
  name     = "mail-out-aws-h4g"
  type     = "MX"
  content  = "feedback-smtp.us-east-1.amazonses.com"
  priority = 10
  comment  = var.comment
  proxied  = false
  ttl      = 1
}

resource "cloudflare_dns_record" "mail_out_aws_h4g_sgf_dev_spf" {
  zone_id = var.zone_id
  name    = "mail-out-aws-h4g"
  type    = "TXT"
  content = "v=spf1 include:amazonses.com ~all"
  comment = var.comment
  proxied = false
  ttl     = 1
}
