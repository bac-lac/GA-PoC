resource "aws_acm_certificate" "baclacca" {
  private_key      = "${var.CERT_PRIVATE_KEY}"
  certificate_body = "${var.CERT_BODY}"

  lifecycle {
    create_before_destroy = true
  }
}