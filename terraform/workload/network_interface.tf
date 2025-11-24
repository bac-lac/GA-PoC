resource "aws_ec2_tag" "tag_eni" {
  for_each = toset(data.aws_network_interfaces.ni.ids)
  resource_id = each.value
  key         = each.key
  value       = each.value
}