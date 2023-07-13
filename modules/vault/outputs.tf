output "backend" {
  value = "${vault_aws_secret_backend.aws-secret.path}"
}

output "role" {
  value = "${vault_aws_secret_backend_role.vault-admin.name}"
}
