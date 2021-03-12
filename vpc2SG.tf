resource "aws_security_group" "vpc2-nat" {
	vpc_id = "${aws_vpc.vpc2.id}"
	name = "VPC2-NAT"
	
	ingress {
	from_port = 0
	to_port = 0
	protocol = "-1"
	cidr_blocks = ["0.0.0.0/0"]
	}

	egress {
	from_port = 0
	to_port = 0
	protocol = "-1"
	cidr_blocks = ["0.0.0.0/0"]
	}
	
	tags = {
	Name = "VPC2-NAT"
	}
}

resource "aws_security_group" "web-user" {
	vpc_id = "${aws_vpc.vpc2.id}"
	name = "Private_Web_User"

	tags = {
	Name = "Private-Web-User"
	}
}

resource "aws_security_group_rule" "from-vpc4-storage" {
	type = "ingress"
	from_port = 2048
	to_port = 2048
	protocol = "tcp"
	security_group_id = "${aws_security_group.web-user.id}"
	cidr_blocks = ["${aws_vpc.vpc4.cidr_block}"]
}

resource "aws_security_group_rule" "from-vpc1-bastaion" {
	type = "ingress"
	from_port = 22
	to_port = 22
	protocol = "tcp"
	security_group_id = "${aws_security_group.web-user.id}"
	cidr_blocks = ["${aws_subnet.v1-public.0.cidr_block}","${aws_subnet.v1-public.1.cidr_block}"]
}


resource "aws_security_group_rule" "from-nat" {
	type = "ingress"
	from_port = 0
	to_port = 0
	protocol = "-1"
	security_group_id = "${aws_security_group.web-user.id}"
	source_security_group_id = "${aws_security_group.vpc2-nat.id}"
}

resource "aws_security_group_rule" "to-nat" {
	type = "egress"
	from_port = 0
	to_port = 0
	protocol = "-1"
	security_group_id = "${aws_security_group.web-user.id}"
	cidr_blocks = ["0.0.0.0/0"]
} 

