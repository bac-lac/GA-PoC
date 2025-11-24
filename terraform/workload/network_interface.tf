resource "aws_network_interface" "test" {
  for_each = data.aws_network_interfaces.ni.ids


  tags = {
    TESTTAG = each.key
  }
}