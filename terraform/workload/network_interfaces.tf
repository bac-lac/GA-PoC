data "aws_network_interfaces" "ni" {
  filter {
    name   = "description"
    values = ["*ecs*"]
  }
}