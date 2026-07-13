# infra-dns

Manages Cloudflare DNS records for `sgf.dev` as code.

## Scope
- Owns: Cloudflare DNS records declared in this repo for the `sgf.dev` zone.
- Owns: Terraform/OpenTofu state for DNS changes in this stack.

## Managed Records
The following public platform endpoints are DNS-only CNAMEs to the shared edge at
`x86-vps-node-01.levizitting.com`:

- `argocd.sgf.dev`
- `dex.sgf.dev`
- `auth.sgf.dev`
- `grafana.sgf.dev`
- `secrets.sgf.dev`
- `headlamp.sgf.dev`
- `longhorn.sgf.dev`
- `seaweedfs.sgf.dev`
- `traefik.sgf.dev`

## Structure
- `src/tf/`: OpenTofu DNS resources, provider config, backend config, and outputs.
- `.github/workflows/`: Plan/validate/apply automation for DNS changes.

## Run
```bash
make help
make tf-init
make tf-plan
make tf-apply
make tf-output
```
