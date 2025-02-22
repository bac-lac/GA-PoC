data "aws_security_group" "app" {
  filter {
    name   = "tag:Name"
    values = ["*App*"]
  }
}

data "aws_security_group" "web" {
  filter {
    name   = "tag:Name"
    values = ["*Web*"]
  }
}

data "aws_security_group" "data" {
  filter {
    name   = "tag:Name"
    values = ["*Data*"]
  }
}