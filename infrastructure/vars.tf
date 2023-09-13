variable "cloudflare_account_id" {
  type        = string
  description = "Account ID for CloudFlare"
}

variable "cloudflare_email" {
  type        = string
  description = "clouflare email address"
}

variable "cloudflare_api_key" {
  type        = string
  description = "cloudflare api key"
}


variable "brevo_dkim" {
  type        = string
  description = "DKIM TXT Record for the Brevo Integration"
}

variable "brevo_code" {
  type        = string
  description = "BrevoCode TXT Record for the Brevo Integration"
}
