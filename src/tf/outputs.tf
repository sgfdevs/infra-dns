output "cloudflare_zone_id" {
  description = "Cloudflare zone ID for managed zone"
  value       = data.cloudflare_zone.sgf_dev.id
}

output "x86_public_vps_target" {
  description = "Shared edge target hostname for public platform CNAMEs"
  value       = local.x86_public_vps_target
}

output "managed_record_ids" {
  description = "Cloudflare DNS record IDs managed by this stack"
  value = merge(
    {
      for name, record in cloudflare_dns_record.core :
      name => record.id
    },
    {
      "sgf.dev/MX"                   = cloudflare_dns_record.sgf_dev_mx.id
      "sgf.dev/SPF"                  = cloudflare_dns_record.sgf_dev_spf.id
      "sgf.dev/DMARC"                = cloudflare_dns_record.sgf_dev_dmarc.id
      "sgf.dev/BIMI"                 = cloudflare_dns_record.sgf_dev_bimi.id
      "sgf.dev/SES-verification"     = cloudflare_dns_record.sgf_dev_ses_verification.id
      "sgf.dev/SMTP2GO-DKIM"         = cloudflare_dns_record.sgf_dev_smtp2go_dkim.id
      "sgf.dev/Brevo-verification"   = cloudflare_dns_record.sgf_dev_brevo_verification.id
      "sgf.dev/mail-DKIM"            = cloudflare_dns_record.sgf_dev_mail_dkim.id
      "email.sgf.dev/SPF"            = cloudflare_dns_record.email_sgf_dev_spf.id
      "email.sgf.dev/DKIM"           = cloudflare_dns_record.email_sgf_dev_dkim.id
      "email.sgf.dev/DMARC"          = cloudflare_dns_record.email_sgf_dev_dmarc.id
      "email.sgf.dev/BIMI"           = cloudflare_dns_record.email_sgf_dev_bimi.id
      "api.sgf.dev/MX"               = cloudflare_dns_record.api_sgf_dev_mx.id
      "api.sgf.dev/SES-verification" = cloudflare_dns_record.api_sgf_dev_ses_verification.id
      "mail-out-aws-h4g.sgf.dev/MX"  = cloudflare_dns_record.mail_out_aws_h4g_sgf_dev_mx.id
      "mail-out-aws-h4g.sgf.dev/SPF" = cloudflare_dns_record.mail_out_aws_h4g_sgf_dev_spf.id
    },
    {
      for selector, record in cloudflare_dns_record.sgf_dev_microsoft_dkim :
      "sgf.dev/Microsoft-DKIM/${selector}" => record.id
    },
    {
      for selector, record in cloudflare_dns_record.sgf_dev_ses_dkim :
      "sgf.dev/SES-DKIM/${selector}" => record.id
    },
    {
      for server, record in cloudflare_dns_record.email_sgf_dev_mx :
      "email.sgf.dev/MX/${server}" => record.id
    },
    {
      for selector, record in cloudflare_dns_record.api_sgf_dev_ses_dkim :
      "api.sgf.dev/SES-DKIM/${selector}" => record.id
    }
  )
}
