data "terraform_remote_state" "random-separator" {
  backend = "remote"
  config = {
    hostname = var.tfe_hostname
    organization = var.organization
    workspaces = {
      name = var.separator-workspace
    }
  }
}

data "terraform_remote_state" "random-length" {
  backend = "remote"
  config = {
    organization = var.organization
    workspaces = {
      name = var.length-workspace
    }
  }
}

resource "random_pet" "pet" {
  keepers = {
    uuid = uuid()
  }

  prefix    = "my"
  length    = data.terraform_remote_state.random-length.outputs.integer
  separator = data.terraform_remote_state.random-separator.outputs.separator
}
