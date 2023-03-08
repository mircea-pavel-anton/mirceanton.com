resource "cloudflare_pages_project" "mirceanton" {
  account_id        = var.cloudflare_account_id
  name              = "mirceanton"
  production_branch = "main"
}
