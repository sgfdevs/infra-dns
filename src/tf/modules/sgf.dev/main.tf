terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
}

locals {
  records = {
    apex = {
      name    = "@"
      type    = "CNAME"
      content = "middleout.levizitting.com"
      proxied = true
      ttl     = 1
    }
    argocd = {
      name    = "argocd"
      type    = "CNAME"
      content = var.x86_public_vps_target
      proxied = false
      ttl     = 300
    }
    auth = {
      name    = "auth"
      type    = "CNAME"
      content = var.x86_public_vps_target
      proxied = false
      ttl     = 300
    }
    atproto = {
      name    = "_atproto"
      type    = "TXT"
      content = "did=did:plc:etkmjzkfci4cyhlwl7rkmwaz"
      proxied = false
      ttl     = 1
    }
    autodiscover = {
      name    = "autodiscover"
      type    = "CNAME"
      content = "autodiscover.outlook.com"
      proxied = false
      ttl     = 900
    }
    cloud = {
      name    = "cloud"
      type    = "CNAME"
      content = "middleout.levizitting.com"
      proxied = true
      ttl     = 1
    }
    covidsupport = {
      name    = "covidsupport"
      type    = "CNAME"
      content = "sgf-covid-support.netlify.app"
      proxied = false
      ttl     = 900
    }
    crm = {
      name    = "crm"
      type    = "CNAME"
      content = "middleout.levizitting.com"
      proxied = true
      ttl     = 1
    }
    dex = {
      name    = "dex"
      type    = "CNAME"
      content = var.x86_public_vps_target
      proxied = false
      ttl     = 300
    }
    discord = {
      name    = "discord"
      type    = "A"
      content = "13.89.227.175"
      proxied = true
      ttl     = 1
    }
    docs = {
      name    = "docs"
      type    = "CNAME"
      content = "middleout.levizitting.com"
      proxied = true
      ttl     = 1
    }
    em470710 = {
      name    = "em470710"
      type    = "CNAME"
      content = "return.smtp2go.net"
      proxied = false
      ttl     = 1
    }
    email = {
      name    = "email"
      type    = "CNAME"
      content = "pixel.mxrouting.net"
      proxied = false
      ttl     = 1
    }
    grafana = {
      name    = "grafana"
      type    = "CNAME"
      content = var.x86_public_vps_target
      proxied = false
      ttl     = 300
    }
    headlamp = {
      name    = "headlamp"
      type    = "CNAME"
      content = var.x86_public_vps_target
      proxied = false
      ttl     = 300
    }
    jobs_api = {
      name    = "jobs.api"
      type    = "CNAME"
      content = "h4g-a-albla-5m3uybla2poy-173703687.us-east-1.elb.amazonaws.com"
      proxied = false
      ttl     = 300
    }
    jobs = {
      name    = "jobs"
      type    = "CNAME"
      content = "portaltowork.netlify.com"
      proxied = false
      ttl     = 900
    }
    link = {
      name    = "link"
      type    = "CNAME"
      content = "track.smtp2go.net"
      proxied = false
      ttl     = 1
    }
    links = {
      name    = "links"
      type    = "A"
      content = "13.89.227.175"
      proxied = true
      ttl     = 1
    }
    longhorn = {
      name    = "longhorn"
      type    = "CNAME"
      content = var.x86_public_vps_target
      proxied = false
      ttl     = 300
    }
    mail_email = {
      name    = "mail.email"
      type    = "CNAME"
      content = "pixel.mxrouting.net"
      proxied = false
      ttl     = 1
    }
    mailadmin_email = {
      name    = "mailadmin.email"
      type    = "CNAME"
      content = "pixel.mxrouting.net"
      proxied = false
      ttl     = 1
    }
    meetup = {
      name    = "meetup"
      type    = "CNAME"
      content = "cranky-heyrovsky-c37638.netlify.com"
      proxied = false
      ttl     = 1
    }
    newsletter = {
      name    = "newsletter"
      type    = "CNAME"
      content = "middleout.levizitting.com"
      proxied = true
      ttl     = 1
    }
    office = {
      name    = "office"
      type    = "CNAME"
      content = "middleout.levizitting.com"
      proxied = true
      ttl     = 1
    }
    outline = {
      name    = "outline"
      type    = "CNAME"
      content = "middleout.levizitting.com"
      proxied = true
      ttl     = 1
    }
    passbolt = {
      name    = "passbolt"
      type    = "CNAME"
      content = "ec2-3-15-211-121.us-east-2.compute.amazonaws.com"
      proxied = false
      ttl     = 1
    }
    plane = {
      name    = "plane"
      type    = "CNAME"
      content = "middleout.levizitting.com"
      proxied = true
      ttl     = 1
    }
    plausible = {
      name    = "plausible"
      type    = "CNAME"
      content = "middleout.levizitting.com"
      proxied = true
      ttl     = 1
    }
    scratch_ui = {
      name    = "scratch-ui"
      type    = "CNAME"
      content = "sgf-dev-scratch-ui.netlify.app"
      proxied = false
      ttl     = 1
    }
    seaweedfs = {
      name    = "seaweedfs"
      type    = "CNAME"
      content = var.x86_public_vps_target
      proxied = false
      ttl     = 300
    }
    secrets = {
      name    = "secrets"
      type    = "CNAME"
      content = var.x86_public_vps_target
      proxied = false
      ttl     = 300
    }
    sentry = {
      name    = "sentry"
      type    = "CNAME"
      content = "middleout.levizitting.com"
      proxied = true
      ttl     = 1
    }
    social = {
      name    = "social"
      type    = "CNAME"
      content = "middleout.levizitting.com"
      proxied = true
      ttl     = 1
    }
    staging = {
      name    = "staging"
      type    = "A"
      content = "208.67.108.84"
      proxied = true
      ttl     = 1
    }
    store = {
      name    = "store"
      type    = "A"
      content = "143.244.170.18"
      proxied = true
      ttl     = 1
    }
    traefik = {
      name    = "traefik"
      type    = "CNAME"
      content = var.x86_public_vps_target
      proxied = false
      ttl     = 300
    }
    webmail_email = {
      name    = "webmail.email"
      type    = "CNAME"
      content = "pixel.mxrouting.net"
      proxied = false
      ttl     = 1
    }
    www = {
      name    = "www"
      type    = "CNAME"
      content = "sgf.dev"
      proxied = true
      ttl     = 1
    }
    api_acm_validation = {
      name    = "_157c9aaa1cb7cbdd73adade6e5f018f3.api"
      type    = "CNAME"
      content = "_7f75475fd973638c05df2a3dc9ff2871.kirrbxfjtw.acm-validations.aws"
      proxied = false
      ttl     = 1
    }
  }
}

resource "cloudflare_dns_record" "core" {
  for_each = local.records

  zone_id = var.zone_id
  name    = each.value.name
  type    = each.value.type
  content = each.value.content
  comment = var.comment
  proxied = each.value.proxied
  ttl     = each.value.ttl
}
