# infra-dns

Manages SGF community Cloudflare DNS records as code.

## Scope
- Owns: Cloudflare DNS records declared in this repo for SGF community zones.
- Owns: Terraform/OpenTofu state for DNS changes in this stack.

## Structure
- `src/tf/`: Root OpenTofu stack, provider configuration, and zone lookups.
- `src/tf/modules/<domain>/`: DNS records grouped by Cloudflare zone.
- `.github/workflows/`: Plan/validate/apply automation for DNS changes.

## Run
```bash
make help
make tf-init
make tf-plan
make tf-apply
make tf-output
```
