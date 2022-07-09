module "test" {
    source                   = "./pt"
    name                     = "fox"
    key = {
        name                 = "hjko-key"
        public               = file("./hjko.pub")
        private              = file("./hjko")
    }
    domain                   = "bespin.link"
    region = {
        region               = "ap-northeast-2"
        az                   = ["a", "c"]
    }
    cidr = {
        vpc                  = "192.168.0.0/16"
        pub                  = ["192.168.0.0/24", "192.168.1.0/24"]
        web                  = ["192.168.2.0/24", "192.168.3.0/24"]
        was                  = ["192.168.4.0/24", "192.168.5.0/24"]
        db                   = ["192.168.100.0/24", "192.168.101.0/24"]
        ansible              = "192.168.6.0/24"
    }
    sg_bastion = {
            description      = "SSH"
            from_port        = 10022
            to_port          = 10022
            protocol         = "tcp"
            cidr_blocks      = ["0.0.0.0/0"]
            ipv6_cidr_blocks = ["::/0"]
    }
    sg_web = [
        {
            description      = "SSH-bastion"
            from_port        = 10022
            to_port          = 10022
            protocol         = "tcp"
        },
        {
            description      = "SSH-ansible"
            from_port        = 10022
            to_port          = 10022
            protocol         = "tcp"
        },
        {
            description      = "HTTP"
            from_port        = 80
            to_port          = 80
            protocol         = "tcp"
        }
    ]
    sg_was = [
        {
            description      = "SSH-bastion"
            from_port        = 10022
            to_port          = 10022
            protocol         = "tcp"
        },
        {
            description      = "SSH-ansible"
            from_port        = 10022
            to_port          = 10022
            protocol         = "tcp"
        },
        {
            description      = "Tomcat"
            from_port        = 8080
            to_port          = 8080
            protocol         = "tcp"
        }
    ]
    sg_db = {
            description      = "MySQL"
            from_port        = 3306
            to_port          = 3306
            protocol         = "tcp"
    }
    sg_ansible = {
            description      = "SSH"
            from_port        = 10022
            to_port          = 10022
            protocol         = "tcp"
    }
    bastion = {
        ami                  = "ami-0e1d09d8b7c751816"
        instance_type        = "t2.micro"
    }
    web = {
        count                = 2
        ami                  = "ami-0e1d09d8b7c751816"
        instance_type        = "t2.micro"
    }
    was = {
        count                = 2
        ami                  = "ami-0e1d09d8b7c751816"
        instance_type        = "t3.medium"
    }
    ASGlc = {
        instance_type = "t2.micro"
    }
    atsg = {
      desired_capacity = 2
      max_size = 10
      min_size = 2
    }
    database = {
        allocated_storage    = 10
        engine               = "mysql"
        engine_version       = "8.0.23"
        instance_class       = "db.t3.micro"
        multi_az             = "true"
        db_name              = "petclinic"
        username             = "root"
        password             = "petclinic"
        backup_window        = "08:10-08:40"
    }
    backup = {
        interval             = 8
        interval_unit        = "HOURS"
        times                = ["12:00"]
        count                = 10
    }
    ansible = {
        ami                  = "ami-0252a84eb1d66c2a0"
        instance_type        = "t2.micro"
    }
}