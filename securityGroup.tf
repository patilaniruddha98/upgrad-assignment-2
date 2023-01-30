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

 
   computed_ingress_with_source_security_group_id = [
    {
      rule                     = "private_instance_sg"
      source_security_group_id = module.bastion_sg.security_group_id
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "ssh"
      source_security_group_id = module.bastion_sg.security_group_id
    },
  ]
   number_of_computed_ingress_with_source_security_group_id = 1
   
   egress_rules = ["all-all"]
  tags = {
    Name = "ani_allow_all_tcp"
  }
}