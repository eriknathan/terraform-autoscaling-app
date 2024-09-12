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
    var.tags, {
      Name = each.value[2]
    }
  )
}