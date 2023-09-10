resource "cloudflare_pages_project" "mirceanton" {
  account_id        = var.cloudflare_account_id
  name              = "mirceanton"
  production_branch = "main"
}

resource "cloudflare_pages_domain" "mirceanton-com" {
  account_id   = var.cloudflare_account_id
  project_name = "mirceanton"
  domain       = "mirceanton.com"

  depends_on = [
    cloudflare_pages_project.mirceanton
  ]
}
