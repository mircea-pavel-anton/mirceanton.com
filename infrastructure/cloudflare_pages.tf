# =================================================================================================
# Create the CloudFlare Pages Project and sync it to the GitHub repository
# Configure production and preview deployments
# =================================================================================================
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
      preview_branch_includes       = ["post/*"]
      preview_branch_excludes       = ["main"]
    }
  }

  build_config {
    build_command   = "npm run build"
    destination_dir = "public"
  }
}

# =================================================================================================
# Assign the `mirceanton.com` custom domain to the Pages Project
# =================================================================================================
resource "cloudflare_pages_domain" "pages_domain" {
  account_id   = var.cloudflare_account_id
  project_name = cloudflare_pages_project.pages_project.name
  domain       = "mirceanton.com"
}

# =================================================================================================
# Create the CNAME for mirceanton.com -> mirceanton.pages.dev
# =================================================================================================
resource "cloudflare_record" "root" {
  zone_id = cloudflare_zone.zone.id

  type  = "CNAME"
  name  = "@"
  value = "mirceanton.pages.dev"

  comment = "DNS Record for the mirceanton.com Pages Project"

  proxied         = true
  allow_overwrite = true
}
