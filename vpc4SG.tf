resource "aws_security_group" "vpc4" {
	vpc_id = "${aws_vpc.vpc4.id}"
	name = "Private_Storage"
	
	ingress {
	from_port = 2048
	to_port = 2048
	protocol = "tcp"
	cidr_blocks = ["${aws_vpc.vpc2.cidr_block}","${aws_vpc.vpc3.cidr_block}"]
	}

	egress {
	from_port = 0
	to_port = 0
	protocol = "-1"
	cidr_blocks = ["0.0.0.0/0"]
	}

	tags = {
	Name = "Private_Storage"
	}
}
