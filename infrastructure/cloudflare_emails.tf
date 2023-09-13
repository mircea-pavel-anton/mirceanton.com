# =================================================================================================
# Enable CloudFlare Email Routing (note: this automatically configures the MX and TXT records)
# =================================================================================================
resource "cloudflare_email_routing_settings" "email_routing_enable" {
  zone_id = cloudflare_zone.zone.id
  enabled = "true"
}
