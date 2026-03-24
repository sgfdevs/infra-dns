# SGF Devs DNS Infrastructure

OpenTofu configuration for SGF Devs DNS management in Cloudflare.

## Scope

- OpenTofu in `src/tf/` manages DNS zones and records.
- v1 targets the `sgf.dev` zone and a narrow, explicit record set.

Core records in v1:

- `hello-nginx.sgf.dev` -> CNAME to `x86-vps-node-01.levizitting.com`

## Usage

### Prerequisites

- [OpenTofu](https://opentofu.org/) >= 1.11 (version pinned in `src/tf/.tofu-version`)
- Cloudflare API token with DNS edit permissions

### Local Operations

```bash
make help
make tf-init
make tf-plan
make tf-show ARGS=tfplan
make tf-output
make tf-apply
make tf-validate
make tf-format
make tf-lint-fix
```

## CI

- Pull requests run Terraform validate and plan.
- Pushes to `main` run Terraform plan+apply.

## Required GitHub Secrets

- `TF_VAR_cloudflare_api_token`
- `AWS_ROLE_ARN`
- `OUTPUT_ENCRYPTION_KEY`

## Migration Notes

This stack only manages records declared in `src/tf/main.tf`; it does not attempt
to import or reconcile every record in the zone.

If `hello-nginx.sgf.dev` already exists in Cloudflare, import it before first apply:

```bash
tofu -chdir=src/tf import 'cloudflare_dns_record.core["hello-nginx"]' <zone_id>/<record_id>
```
