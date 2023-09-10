resource "cloudflare_zone" "zone" {
  account_id = var.cloudflare_account_id
  zone       = "mirceanton.com"
}

resource "cloudflare_pages_project" "pages_project" {
  account_id        = var.cloudflare_account_id
  name              = "mirceanton"
  production_branch = "main"

  source {
    type = "github"
    config {
      owner                         = "mirceanton"
      repo_name                     = "mirceanton.com"
      production_branch             = "main"
      pr_comments_enabled           = true
      deployments_enabled           = true
      production_deployment_enabled = true
      preview_deployment_setting    = "custom"
      preview_branch_excludes       = ["main"]
    }
  }
}

resource "cloudflare_pages_domain" "pages_domain" {
  account_id   = var.cloudflare_account_id
  project_name = cloudflare_pages_project.pages_project.name
  domain       = "mirceanton.com"
}
