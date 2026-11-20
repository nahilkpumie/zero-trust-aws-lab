# Zero-Trust AWS Lab

Infrastructure-as-code lab building a hardened AWS environment from scratch,
with security enforced in the pipeline rather than audited after deployment.

## Why

Most cloud breaches are not exotic. They are public buckets, over-permissive
IAM roles and security groups open to the world — misconfigurations that
nobody caught before deployment. This lab builds the opposite: every resource
is defined in code, and every change is scanned against security policy
before it can be merged.

## Current state — v0.1.0

An S3 bucket, hardened by default:

| Control | Implementation |
|---|---|
| Encryption at rest | SSE-S3 (AES256), applied to every object |
| Versioning | Enabled — survives accidental deletion |
| Public access | Blocked at all four levels |
| Tagging | Enforced through provider `default_tags` |

## Roadmap

- [x] **v0.1.0** — Encrypted S3 bucket
- [ ] **v0.2.0** — Zero-Trust VPC: public and private subnets, deny-all security groups
- [ ] **v0.3.0** — Least-privilege IAM, SSM Session Manager (no bastion, no open SSH)
- [ ] **v0.4.0** — Checkov and tfsec in GitHub Actions, OIDC auth, no long-lived keys
- [ ] **v0.5.0** — Ansible hardening over SSM
- [ ] **v1.0.0** — Reusable modules, encrypted S3 remote backend with state locking

## Usage

```bash
cd terraform
terraform init
terraform plan -out=tfplan
terraform apply tfplan
terraform destroy
```

## Design notes

**No NAT Gateway.** Private subnets reach AWS services through VPC endpoints.
A NAT Gateway costs around $32/month even while idle and buys nothing here.

**No bastion host.** Private instances are reached through AWS Systems Manager
Session Manager: no inbound port, no SSH key to distribute, every session logged.

**State is never committed.** `terraform.tfstate` holds resource attributes in
clear text. v1.0.0 moves it to an encrypted S3 backend with locking.

---

Built by [nahilkpumie](https://github.com/nahilkpumie) while studying secured
infrastructure engineering.
