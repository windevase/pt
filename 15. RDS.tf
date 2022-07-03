resource "aws_db_instance" "database" {
    allocated_storage      = 10
    engine                 = "mysql"
    engine_version         = "5.7"
    instance_class         = "db.t2.micro"
    multi_az               = true
    db_name                   = "db-a"
    username               = "root"
    password               = "It12345!"
    db_subnet_group_name   = aws_subnet.hjko_pridba.id
    vpc_security_group_ids = [aws_security_group.hjko_sg.id]
    availability_zone      = "ap-northeast-2a"
    identifier             = "hjko-dba"
    enabled_cloudwatch_logs_exports = ["error", "audit", "general", "slowquery"]
    skip_final_snapshot    = true
    backup_window          = "07:00-08:00"
    backup_retention_period = 4
    apply_immediately      = true
    tags = {
            Name = "hjko-dba"
    }
}