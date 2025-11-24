resource "aws_resource_tag" "tag_eni" {
  for_each = data.aws_network_interfaces.ni.ids
  resource_id = each.value
  key         = each.key
  value       = each.value
}