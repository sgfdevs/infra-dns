data "cloudflare_zero_trust_tunnel_cloudflareds" "k3s" {
  account_id = data.cloudflare_zone.sgf_dev.account.id
  name       = "sgfdevs-infra-k8s-apps"
  is_deleted = false
  max_items  = 2
}

locals {
  k3s_tunnel_id     = one(data.cloudflare_zero_trust_tunnel_cloudflareds.k3s.result[*].id)
  k3s_tunnel_target = "${local.k3s_tunnel_id}.cfargotunnel.com"
}
