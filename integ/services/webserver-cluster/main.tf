provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "terra-forma-juanjo-3001"
    # 1:1 mapeo organizacion directorios
    key = "integ/services/webserver-cluster/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terra-forma-juanjo-3001-locks"
    encrypt = true
  }
}

module "webserver_cluster" {
  source = "../../../../modules/services/webserver-cluster"
  db_remote_state_bucket = "terra-forma-juanjo-3001"
  db_remote_state_key = "integ/data-stores/mysql/terraform.tfstate"
}

resource "aws_security_group_rule" "example" {
  type              = "ingress"
  from_port         = 12345
  to_port           = 12345
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.webserver_cluster.sg_id
}

output "alb_dns_name" {
  value = module.webserver_cluster.public_ip
}
