resource "aws_security_group" "nat" {
	vpc_id = "${aws_vpc.vpc1.id}"
	name = "NAT"

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
	Name = "Nat"
	}
}
	
resource "aws_security_group" "web-bastion" {
	vpc_id = "${aws_vpc.vpc1.id}"
	name = "Web-Bastion"

	ingress {
	from_port = 22
	to_port = 22
	protocol = "tcp"
	cidr_blocks = ["0.0.0.0/0"]
	}

	egress {
	from_port = 22
	to_port = 22
	protocol = "tcp"
	cidr_blocks = ["${aws_vpc.vpc2.cidr_block}"]
	}
	

	tags = {
	Name = "Web-Bastion"
	}
}
	
resource "aws_security_group" "db-bastion" {
	vpc_id = "${aws_vpc.vpc1.id}"
	name = "DB-Bastion"

	ingress {
	from_port = 22
	to_port = 22
	protocol = "tcp"
	cidr_blocks = ["0.0.0.0/0"]
	}
	
	egress {
	from_port = 22
	to_port = 22
	protocol = "tcp"
	cidr_blocks = ["${aws_vpc.vpc3.cidr_block}"]
	}

	tags = {
	Name = "DB-Bastion"
	}
}

resource "aws_security_group" "elb" {
	name = "ELB"
	vpc_id = "${aws_vpc.vpc1.id}"

	ingress {
	from_port = 80
	to_port = 80
	protocol = "tcp"
	cidr_blocks = ["0.0.0.0/0"]
	}
	
	egress {
	from_port = 80
	to_port = 80
	protocol = "tcp"
	cidr_blocks = ["${aws_subnet.v1-private.0.cidr_block}","${aws_subnet.v1-private.1.cidr_block}"]
	}

	tags = {
	Name = "ELB"
	}
}

resource "aws_security_group" "autoscaling" {
	vpc_id = "${aws_vpc.vpc1.id}"
	name = "autoscaling"

	tags = {
	Name = "AutoScaling"
	}
}

resource "aws_security_group_rule" "from-elb" {
	type = "ingress"
	from_port = 80
	to_port = 80
	protocol = "tcp"
	security_group_id = "${aws_security_group.autoscaling.id}"
	source_security_group_id = "${aws_security_group.elb.id}"
}

resource "aws_security_group_rule" "every" {
	type = "egress"
	from_port = 0
	to_port = 0
	protocol = "-1"
	security_group_id = "${aws_security_group.autoscaling.id}"
	cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "vpc1nat_to_webserver" {
	type = "ingress"
	from_port = 0
	to_port = 0
	protocol = "-1"
	security_group_id = "${aws_security_group.autoscaling.id}"
	source_security_group_id = "${aws_security_group.nat.id}"
}

resource "aws_security_group_rule" "vpc3-to-autoscaling" {
	type = "ingress"
	from_port = 0
	to_port = 0
	protocol = "-1"
	security_group_id = "${aws_security_group.autoscaling.id}"
	cidr_blocks = ["${aws_vpc.vpc3.cidr_block}"]
}

resource "aws_security_group_rule" "a" {
	type = "ingress"
	from_port = 0
	to_port = 0
	protocol = "-1"
	security_group_id = "${aws_security_group.autoscaling.id}"
	cidr_blocks = ["0.0.0.0/0"]
}
