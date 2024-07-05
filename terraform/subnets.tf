data "aws_subnets" "data" {
  filter {
    name   = "tag:Name"
    values = ["*Data*"]
  }
}

data "aws_subnets" "web" {
  filter {
    name   = "tag:Name"
    values = ["*Web*"]
  }
}

data "aws_subnets" "app" {
  filter {
    name   = "tag:Name"
    values = ["*App*"]
  }
}