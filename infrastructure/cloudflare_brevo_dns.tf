# =================================================================================================
# TXT Record for Brevo
# =================================================================================================
resource "cloudflare_record" "brevo_code" {
  zone_id = cloudflare_zone.zone.id

  type  = "TXT"
  name  = "@"
  value = var.brevo_code

  comment = "Terraform Managed DNS Record for the Brevo Integration"

  allow_overwrite = true
}

# =================================================================================================
# TXT Record for Brevo
# =================================================================================================
resource "cloudflare_record" "dkim" {
  zone_id = cloudflare_zone.zone.id

  type  = "TXT"
  name  = "mail._domainkey"
  value = var.brevo_dkim

  comment = "Terraform Managed DNS Record for the Brevo Integration"

  allow_overwrite = true
}
