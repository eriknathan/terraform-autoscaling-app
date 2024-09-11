locals {
  subnet_ids = { 
    for k, v in aws_subnet.pant_subnets : v.tags.Name => v.id
  }

  tags = {
    Departament  = "DevOps"
    Organization = "Infrastructure and Operations"
    Project      = "pantLabz"
    Created      = "2024/09/10"
    Enviroment   = "Development"
    Author       = "@eriknathan | Erik Nathan"
  }
}