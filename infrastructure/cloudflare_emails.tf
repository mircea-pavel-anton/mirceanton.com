# =================================================================================================
# Enable CloudFlare Email Routing (note: this automatically configures the MX and TXT records)
# =================================================================================================
resource "cloudflare_email_routing_settings" "email_routing_enable" {
  zone_id = cloudflare_zone.zone.id
  enabled = "true"
}

# =================================================================================================
# Email Routing Target -> personal Gmail
# =================================================================================================
resource "cloudflare_email_routing_address" "gmail" {
  account_id = var.cloudflare_account_id
  email      = "mircea.pavel.anton@gmail.com"
}

# =================================================================================================
# Email Routing Rule: Forward emails to my personal gmail
# =================================================================================================
resource "cloudflare_email_routing_rule" "gmail_forwarder" {
  for_each = toset([
    "personal@mirceanton.com",
    "contact@mirceanton.com",
    "mircea@mirceanton.com",
    "me@mirceanton.com",
    "spam@mirceanton.com"
  ])

  zone_id = cloudflare_zone.zone.id
  name    = "Gmail Forwarder"
  enabled = true

  matcher {
    type  = "literal"
    field = "to"
    value = each.key
  }

  action {
    type  = "forward"
    value = ["mircea.pavel.anton@gmail.com"]
  }
}

# =================================================================================================
# [DISABLED] Email Routing Rule: forward all emails to my personal gmail account
# =================================================================================================
resource "cloudflare_email_routing_catch_all" "catch_all" {
  zone_id = cloudflare_zone.zone.id
  name    = "Gmail Forwarder"
  enabled = false

  matcher {
    type = "all"
  }

  action {
    type  = "forward"
    value = ["mircea.pavel.anton@gmail.com"]
  }
}
