data "aws_availability_zones" "az" {}

data "aws_route53_zone" "twohjin" {
	name = "2hjin.com"
	private_zone = false
}

###################### AMI ############################
data "aws_ami" "db-bastion-ami" {
        most_recent = "true"

        filter {
        name = "name"
        values = ["db-bastion"]
        }
        owners = ["759163759774"]
}

data "aws_ami" "web-bastion-ami" {
        most_recent = "true"

        filter {
        name = "name"
        values = ["web-bastion"]
        }
        owners = ["759163759774"]
}

data "aws_ami" "dbuser-ami" {
        most_recent = "true"

        filter {
        name = "name"
        values = ["dbuser"]
        }
        owners = ["759163759774"]
}

data "aws_ami" "webserver-ami" {
        most_recent = "true"

        filter {
        name = "name"
        values = ["webserver"]
        }
        owners = ["759163759774"]
}

data "aws_ami" "webuser-ami" {
        most_recent = "true"

        filter {
        name = "name"
        values = ["webuser"]
        }
        owners = ["759163759774"]
}

data "aws_ami" "storage-ami" {
        most_recent = "true"

        filter {
        name = "name"
        values = ["Storage"]
        }
        owners = ["759163759774"]
}
########################## Subnet_Ids ##########################
data "aws_subnet_ids" "vpc1-pub" {
	vpc_id = "${aws_vpc.vpc1.id}"

	filter {
    	name   = "tag:Name"
    	values = ["VPC1's Public*"]
  	}
}

data "aws_subnet_ids" "vpc1-pri" {
	vpc_id = "${aws_vpc.vpc1.id}"
	
	filter {
	name	= "tag:Name"
	values 	= ["VPC1's Private*"]
	}
}

data "aws_subnet_ids" "vpc2-nat" {
	vpc_id = "${aws_vpc.vpc2.id}"

	filter {
	name   = "tag:Name"
	values = ["VPC2's Public*"]
	}
}

data "aws_subnet_ids" "vpc2-pri" {
	vpc_id = "${aws_vpc.vpc2.id}"

	filter {
	name   = "tag:Name"
	values = ["VPC2's Private*"]
	}
}

data "aws_subnet_ids" "vpc3-pri" {
	vpc_id = "${aws_vpc.vpc3.id}"

	filter {
	name   = "tag:Name"
	values = ["VPC3's Private*"]
	}
}

data "aws_subnet_ids" "vpc4-pri" {
	vpc_id = "${aws_vpc.vpc4.id}"

	filter {
	name   = "tag:Name"
	values = ["VPC4's Private*"]
	}
}

