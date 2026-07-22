# infra-dns

Manages Cloudflare DNS records for `sgf.dev` as code.

## Scope
- Owns: Cloudflare DNS records declared in this repo for the `sgf.dev` zone.
- Owns: Terraform/OpenTofu state for DNS changes in this stack.

## Structure
- `src/tf/`: Root OpenTofu stack, provider configuration, and zone lookups.
- `src/tf/modules/sgf.dev/`: All DNS records for the `sgf.dev` zone.
- `.github/workflows/`: Plan/validate/apply automation for DNS changes.

## Run
```bash
make help
make tf-init
make tf-plan
make tf-apply
make tf-output
```
