remote_state {
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  backend = "s3"
  config = {
    region = get_env("REGION")
    bucket = get_env("BUCKET")
    key    = "${path_relative_to_include()}/.tfstate"
  }
}

generate "variables" {
  path      = "variables.tf"
  if_exists = "overwrite"
  contents  = <<EOF
variable "foo" {}
variable "bar" {}
variable "foobar" {}
variable "barfoo" {}
EOF
}

inputs = {
  foo = "1"
  bar = "2"
  foobar = "3"
  barfoo = "4"
}

generate "outputs" {
  path      = "outputs.tf"
  if_exists = "overwrite"
  contents  = <<EOF
output "foo" { value = var.foo }
output "bar" { value = var.bar }
output "foobar" { value = var.foobar }
output "barfoo" { value = var.barfoo }
EOF
}