locals {
  subnet_ids = {
    for k, v in aws_subnet.pant_subnets : v.tags.Name => v.id
  }
}