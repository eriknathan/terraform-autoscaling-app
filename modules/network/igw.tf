resource "aws_internet_gateway" "pant_igw" {
  vpc_id = aws_vpc.pant_vpc.id

  tags = merge(
    var.tags, {
      Name = "${var.project_name}-igw-tf"
    }
  )
}
