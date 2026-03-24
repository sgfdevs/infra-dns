# SGF Devs DNS Infrastructure

OpenTofu configuration for SGF Devs DNS management in Cloudflare.

## Scope

- OpenTofu in `src/tf/` manages DNS zones and records.
- v1 targets the `sgf.dev` zone and core service records.

Core records in v1:

- `x86-public-vps.sgf.dev` -> CNAME to `infra-public-edge` output `vps_hostname`
- `hello-nginx.sgf.dev` -> CNAME to `x86-public-vps.sgf.dev`

## Usage

### Prerequisites

- [OpenTofu](https://opentofu.org/) >= 1.11 (version pinned in `src/tf/.tofu-version`)
- AWS credentials configured locally (for remote state backend)
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

If records already exist in Cloudflare, import them before first apply:

```bash
tofu -chdir=src/tf import 'cloudflare_dns_record.core["x86-public-vps"]' <zone_id>/<record_id>
tofu -chdir=src/tf import 'cloudflare_dns_record.core["hello-nginx"]' <zone_id>/<record_id>
```
