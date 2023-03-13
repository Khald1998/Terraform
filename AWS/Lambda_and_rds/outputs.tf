output "rds_hostname" {
    description = "RDS instance hostname"
    value       = aws_db_instance.main.address
    sensitive   = false
}
output "rds_port" {
    description = "RDS instance port"
    value       = aws_db_instance.main.port
    sensitive   = false
}

output "rds_username" {
    description = "RDS instance root username"
    value       = aws_db_instance.main.username
    sensitive   = false
}
output "rds_password" {
    description = "RDS instance root username"
    value       = nonsensitive(aws_db_instance.main.password)
    sensitive   = false

}
output "rds_link" {
    description = "rds_link"
    value       = "${aws_db_instance.main.username}:${nonsensitive(aws_db_instance.main.password)}@tcp(${aws_db_instance.main.address}:${aws_db_instance.main.port})/${aws_db_instance.main.db_name}" //"%s:%s@tcp(%s:%s)/%s", username, password, endpoint, port, db_name
    sensitive   = false
}
