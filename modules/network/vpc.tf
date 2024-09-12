resource "aws_vpc" "pant_vpc" {
  cidr_block = var.cidr_block

  tags = merge(
    var.tags, {
      Name = "${var.project_name}-vpc-tf"
    }
  )
}