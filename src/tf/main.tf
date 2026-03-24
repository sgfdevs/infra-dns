data "terraform_remote_state" "infra_public_edge" {
  backend = "s3"
  config = {
    bucket = var.infra_public_edge_state_bucket
    key    = var.infra_public_edge_state_key
    region = var.infra_public_edge_state_region
  }
}

locals {
  x86_public_vps_target = trimsuffix(data.terraform_remote_state.infra_public_edge.outputs.vps_hostname, ".")

  records = {
    "hello-nginx" = {
      type    = "CNAME"
      content = local.x86_public_vps_target
      proxied = false
      ttl     = 300
    }
  }
}

resource "cloudflare_dns_record" "core" {
  for_each = local.records

  zone_id = data.cloudflare_zone.sgf_dev.id
  name    = each.key
  type    = each.value.type
  content = each.value.content
  proxied = each.value.proxied
  ttl     = each.value.ttl
}
