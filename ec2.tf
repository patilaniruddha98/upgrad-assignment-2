module "bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "bastion"

  ami                    = "ami-00874d747dde814fa"
  instance_type          = "t2.medium"
  key_name               = "courseAssignment"
  monitoring             = true
  vpc_security_group_ids = [module.bastion_sg.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "jenkins" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "jenkins"

  ami                    = "ami-00874d747dde814fa"
  instance_type          = "t2.medium"
  key_name               = "courseAssignment"
  monitoring             = true
  vpc_security_group_ids = [module.private_instance_sg.security_group_id]
  subnet_id              = module.vpc.private_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "app" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "app"

  ami                    = "ami-00874d747dde814fa"
  instance_type          = "t2.medium"
  key_name               = "courseAssignment"
  monitoring             = true
  vpc_security_group_ids = [module.private_instance_sg.security_group_id]
  subnet_id              = module.vpc.private_subnets[1]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}