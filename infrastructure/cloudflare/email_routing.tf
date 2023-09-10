resource "cloudflare_email_routing_rule" "no_reply_drop" {
  zone_id = cloudflare_zone.mirceanton_com.id
  name    = "Drop all emails to noreply address"
  enabled = true

  matcher {
    type  = "literal"
    field = "to"
    value = "noreply@mirceanton.com"
  }

  action {
    type  = "drop"
  }
}

resource "cloudflare_email_routing_catch_all" "catch_all_forward" {
  zone_id = cloudflare_zone.mirceanton_com.id
  name    = "Catch all emails and forward to GMail"
  enabled = true

  matcher {
    type = "all"
  }

  action {
    type  = "forward"
    value = ["mircea.pavel.anton@gmail.com"]
  }
}