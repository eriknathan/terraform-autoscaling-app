resource "aws_route_table" "pant_public_route_table" {
  vpc_id = aws_vpc.pant_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.pant_igw.id
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-public-route-table"
    }
  )
}

resource "aws_route_table" "pant_private_route_table" {
  vpc_id = aws_vpc.pant_vpc.id

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-private-route-table"
    }
  )
}

resource "aws_route_table_association" "pant_rtb_assoc" {
  for_each = local.subnet_ids

  subnet_id = each.value

  route_table_id = substr(each.key, 0, 3) == "pub" ? aws_route_table.pant_public_route_table.id : aws_route_table.pant_private_route_table.id
}