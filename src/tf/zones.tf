locals {
  sgf_dev = "sgf.dev"
}

data "cloudflare_zone" "sgf_dev" {
  filter = {
    name = local.sgf_dev
  }
}
