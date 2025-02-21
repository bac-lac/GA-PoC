data "aws_acm_certificate" "baclacca" {
  domain   = "bac-lac.ca"
}

resource "aws_acm_certificate" "cert" {
  private_key      = <<EOT
${var.CERT_PRIVATE_KEY}
EOT
  certificate_body = <<EOT
${var.CERT_BODY}
EOT

  lifecycle {
    create_before_destroy = true
  }
}