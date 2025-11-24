data "aws_network_interfaces" "ni" {
  filter {
    name   = "description"
    values = ["*ecs*"]
  }
}

output "network_interface_ids" {
  value = data.aws_network_interfaces.ni.ids
}