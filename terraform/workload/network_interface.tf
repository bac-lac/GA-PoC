data "aws_network_interface" "ni" {
  filter {
    name   = "description"
    values = ["*ecs*"]
  }
}