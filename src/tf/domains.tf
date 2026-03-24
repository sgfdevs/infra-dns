data "cloudflare_zone" "sgf_dev" {
  filter = {
    name = var.cloudflare_zone_name
  }
}
