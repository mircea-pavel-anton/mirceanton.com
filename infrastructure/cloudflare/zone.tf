resource "cloudflare_zone" "mirceanton_com" {
  account_id = var.cloudflare_account_id
  zone       = "mirceanton.com"
}
