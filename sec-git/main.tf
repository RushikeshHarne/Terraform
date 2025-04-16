terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}


resource "github_repository" "my_repo" {
  name        = "${var.myrepo}"
  description = "Repository created with Terraform"
  visibility = var.scope ? "public" : "private"
  #visibility  = "${var.scope}"  # Can also be "private" or "internal" (for GitHub Enterprise)
  auto_init   = true
}

resource "github_repository_file" "readme" {
  repository       = github_repository.my_repo.name
  file             = "${var.file}"
  content          = "# Welcome to ${var.myrepo}\nThis repository was created using Terraform."
  branch           = "main"
  commit_message   = "Add README file"
}
