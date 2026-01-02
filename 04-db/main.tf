module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 6.0"

  identifier = "${var.project_name}-${var.environment}"

  engine         = "mysql"
  engine_version = "8.0.40"

  instance_class    = "db.t3.micro"
  allocated_storage = 5

  # Database credentials
  db_name  = "transactions"
  username = "root"
  password = "ExpenseApp1"

  port = 3306

  # Networking
  vpc_security_group_ids = [data.aws_ssm_parameter.db_sg_id.value]
  db_subnet_group_name   = data.aws_ssm_parameter.db_subnet_group_name.value

  # Parameter & option groups
  family               = "mysql8.0"
  major_engine_version = "8.0"

  skip_final_snapshot = true

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}"
    }
  )
}
