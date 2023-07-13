provider vault {
  address= var.vault_address
  token = var.vault_token
}


terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}


resource "vault_aws_secret_backend" "aws-secret" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"

  default_lease_ttl_seconds = "1200"
  max_lease_ttl_seconds     = "1800"
}

resource "vault_aws_secret_backend_role" "vault-admin" {
  backend = "${vault_aws_secret_backend.aws-secret.path}"
  name    = "vault-admin-role"
  credential_type = "iam_user"
  policy_document =  <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "iam:*",
      "Resource": "*"
    }
  ]
}
EOF
}

data "vault_aws_access_credentials" "creds" {
  backend = data.terraform_remote_state.admin.outputs.backend
  role    = data.terraform_remote_state.admin.outputs.role
}
