module "bastion_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "bastion_sg"
  description = "bastion security group"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "ssh"
      cidr_blocks = "0.0.0.0/0" 
    }
  ]
   
   egress_rules = ["all-all"]
  tags = {
    Name = "ani_allow_ssh"
  }
}

module "private_instance_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "private_instance_sg"
  description = "private instance security group"
  vpc_id      = module.vpc.vpc_id

 
    ingress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      description = "ssh"
      cidr_blocks =  module.vpc.vpc_cidr_block
    }
  ]
   
   egress_rules = ["all-all"]
  tags = {
    Name = "ani_allow_all_tcp"
  }
}