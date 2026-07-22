locals {
  x86_public_vps_target = "x86-vps-node-01.levizitting.com"
  dns_record_comment    = "managedBy=tf,repo=sgfdevs/infra-dns"
}

module "sgf_dev" {
  source = "./modules/sgf.dev"

  zone_id               = data.cloudflare_zone.sgf_dev.id
  comment               = local.dns_record_comment
  x86_public_vps_target = local.x86_public_vps_target
}
