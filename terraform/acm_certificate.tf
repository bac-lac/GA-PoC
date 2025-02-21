data "aws_acm_certificate" "baclacca" {
  domain   = "bac-lac.ca"
}

resource "aws_acm_certificate" "cert" {
  private_key      = "${var.CERT_PRIVATE_KEY}"
  certificate_body = "${var.CERT_BODY}"

  lifecycle {
    create_before_destroy = true
  }
}