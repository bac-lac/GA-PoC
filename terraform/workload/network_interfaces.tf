data "aws_network_interfaces" "ni" {
  depends_on = [module.ecs_service.ga_service_mft]
  filter {
    name   = "description"
    values = ["*ecs*"]
  }
}

output "network_interface_ids" {
  value = data.aws_network_interfaces.ni.ids
}

resource "aws_ec2_tag" "tag_eni" {
  for_each = toset(data.aws_network_interfaces.ni.ids)
  resource_id = each.value
  key         = "SSC_CBRID"
  value       = "${var.SSC_CBRID}"
}