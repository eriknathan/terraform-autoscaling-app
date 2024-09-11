resource "aws_vpc" "pant_vpc" {
  cidr_block = var.cidr_block

  tags = merge(
    local.tags, {
      Name = "${var.project_name}-vpc-tf"
    }
  )
}

resource "aws_internet_gateway" "pant_igw" {
  vpc_id = aws_vpc.pant_vpc.id

  tags = merge(
    local.tags, {
      Name = "${var.project_name}-igw-tf"
    }
  )
}

resource "aws_subnet" "pant_subnets" {
  vpc_id = aws_vpc.pant_vpc.id

  for_each = {
    "subnet_public_1b"  = [cidrsubnet(var.cidr_block, 8, 2), "${var.region}b", "pub-${var.project_name}-subnet-1b-tf"]
    "subnet_public_1a"  = [cidrsubnet(var.cidr_block, 8, 1), "${var.region}a", "pub-${var.project_name}-subnet-1a-tf"]
    "subnet_private_1a" = [cidrsubnet(var.cidr_block, 8, 3), "${var.region}a", "priv-${var.project_name}-subnet-1a-tf"]
    "subnet_private_1b" = [cidrsubnet(var.cidr_block, 8, 4), "${var.region}b", "priv-${var.project_name}-subnet-1b-tf"]
  }

  cidr_block        = each.value[0]
  availability_zone = each.value[1]

  tags = merge(
    local.tags, {
      Name = each.value[2]
    }
  )
}

resource "aws_route_table" "pant_public_route_table" {
  vpc_id = aws_vpc.pant_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.pant_igw.id
  }

  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-public-route-table"
    }
  )
}

resource "aws_route_table" "pant_private_route_table" {
  vpc_id = aws_vpc.pant_vpc.id

  tags = merge(
    local.tags,
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