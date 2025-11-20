data "aws_network_interface" "ecs" {
  filter {
    name   = "tag:Description"
    values = ["*ecs*"]
  }
}
