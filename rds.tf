
resource "aws_db_instance" "web_app_mysql" {
  identifier        = "web-app-mysql"
  engine            = "mysql"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  storage_type      = "gp3"

  db_name  = "webapp"
  username = "appadmin"

  # Let RDS manage the master password in Secrets Manager.
  manage_master_user_password = true

  db_subnet_group_name   = aws_db_subnet_group.web-app-db-subnet-grp.id
  vpc_security_group_ids = [aws_security_group.db-sg-1.id]

  publicly_accessible = false
  multi_az            = true

  storage_encrypted = true
  #backup_retention_period = 7

  auto_minor_version_upgrade = true
  deletion_protection        = false
  skip_final_snapshot        = true

  tags = {
    Name        = "web-app-mysql"
    Environment = "dev"
  }
}

