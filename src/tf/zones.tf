locals {
  devfestsgf_com   = "devfestsgf.com"
  hack4goodsgf_com = "hack4goodsgf.com"
  helpsgf_com      = "helpsgf.com"
  methodconf_com   = "methodconf.com"
  sgf_dev          = "sgf.dev"
  sgfwebdevs_com   = "sgfwebdevs.com"
  springfield_dev  = "springfield.dev"
}

data "cloudflare_zone" "sgf_dev" {
  filter = {
    name = local.sgf_dev
  }
}

data "cloudflare_zone" "devfestsgf_com" {
  filter = {
    name = local.devfestsgf_com
  }
}

data "cloudflare_zone" "hack4goodsgf_com" {
  filter = {
    name = local.hack4goodsgf_com
  }
}

data "cloudflare_zone" "helpsgf_com" {
  filter = {
    name = local.helpsgf_com
  }
}

data "cloudflare_zone" "methodconf_com" {
  filter = {
    name = local.methodconf_com
  }
}

data "cloudflare_zone" "sgfwebdevs_com" {
  filter = {
    name = local.sgfwebdevs_com
  }
}

data "cloudflare_zone" "springfield_dev" {
  filter = {
    name = local.springfield_dev
  }
}
