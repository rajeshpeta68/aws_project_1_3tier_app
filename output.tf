
output "rds_endpoint" {
  description = "RDS MySQL connection endpoint"
  value       = aws_db_instance.web_app_mysql.endpoint
}

output "rds_port" {
  description = "RDS MySQL port"
  value       = aws_db_instance.web_app_mysql.port
}
