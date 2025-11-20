data "aws_network_interface" "ecs" {
  filter {
    name   = "tag:Name"
    values = ["*ecs*"]
  }
}
