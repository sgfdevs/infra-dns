locals {
  x86_public_vps_target = "x86-vps-node-01.levizitting.com"
  dns_record_comment    = "managedBy=tf,repo=sgfdevs/infra-dns"
}

module "sgf_dev" {
  source = "./modules/sgf.dev"

  zone_id               = data.cloudflare_zone.sgf_dev.id
  comment               = local.dns_record_comment
  aws_region            = var.aws_region
  x86_public_vps_target = local.x86_public_vps_target
}

module "devfestsgf_com" {
  source = "./modules/devfestsgf.com"

  zone_id = data.cloudflare_zone.devfestsgf_com.id
  comment = local.dns_record_comment
}

module "hack4goodsgf_com" {
  source = "./modules/hack4goodsgf.com"

  zone_id = data.cloudflare_zone.hack4goodsgf_com.id
  comment = local.dns_record_comment
}

module "helpsgf_com" {
  source = "./modules/helpsgf.com"

  zone_id = data.cloudflare_zone.helpsgf_com.id
  comment = local.dns_record_comment
}

module "methodconf_com" {
  source = "./modules/methodconf.com"

  zone_id    = data.cloudflare_zone.methodconf_com.id
  comment    = local.dns_record_comment
  aws_region = var.aws_region
}

module "sgfwebdevs_com" {
  source = "./modules/sgfwebdevs.com"

  zone_id = data.cloudflare_zone.sgfwebdevs_com.id
  comment = local.dns_record_comment
}

module "springfield_dev" {
  source = "./modules/springfield.dev"

  zone_id = data.cloudflare_zone.springfield_dev.id
  comment = local.dns_record_comment
}
