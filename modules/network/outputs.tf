output "vpc_id" {
  value = aws_vpc.pant_vpc.id
}

output "igw_id" {
  value = aws_internet_gateway.pant_igw.id
}

output "subnet_ids" {
  value = local.subnet_ids
}

output "public_route_table_id" {
  value = aws_route_table.pant_public_route_table.id
}

output "private_route_table_id" {
  value = aws_route_table.pant_private_route_table.id
}

output "route_table_association_ids" {
  value = [for k, v in aws_route_table_association.pant_rtb_assoc : v.id]
}
