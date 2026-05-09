module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "google-boutique-prod"
  cidr = "10.0.0.0/16"

  azs              = ["ap-south-1a", "ap-south-1b", "ap-south-1c" ]
  public_subnets   = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24" ]
  private_subnets  = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24" ]
  database_subnets = ["10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24" ]

  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_flow_log                      = true
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true

  public_subnet_tags = {
    "kubernetes.io/role/elb"              = 1
    "kubernetes.io/cluster/google-boutique-prod" = "shared"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb"     = 1
    "kubernetes.io/cluster/google-boutique-prod" = "shared"
  }
}

output "vpc_id" { value = module.vpc.vpc_id }
output "private_subnets" { value = module.vpc.private_subnets }
output "public_subnets" { value = module.vpc.public_subnets }
