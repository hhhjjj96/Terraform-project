resource "aws_security_group" "db-user" {
	description = "VPC1-SSH-to-DBuser"
	vpc_id = "${aws_vpc.vpc3.id}"
	name = "Private_DB_User"

	ingress {
	from_port = 22
	to_port = 22
	protocol = "tcp"
	cidr_blocks = ["${aws_subnet.v1-public.0.cidr_block}","${aws_subnet.v1-public.1.cidr_block}"]
	}
	
	ingress {
	from_port = 2048
	to_port = 2048
	protocol = "tcp"
	cidr_blocks = ["${aws_vpc.vpc4.cidr_block}"]
	}

	egress {
	from_port = 0
	to_port = 0
	protocol = "-1"
	cidr_blocks = ["0.0.0.0/0"]
	}
	
	tags = {
	Name = "Private-DB-User"
	}
}

resource "aws_security_group" "db" {
	vpc_id = "${aws_vpc.vpc3.id}"
	name = "Private_DB"

	tags = {
	Name = "Private-DB"
	}
}

resource "aws_security_group_rule" "from_autoscaling" {
	type = "ingress"
	from_port = 3306
	to_port = 3306
	protocol = "tcp"
	security_group_id = "${aws_security_group.db.id}"
	cidr_blocks = ["${aws_subnet.v1-private.0.cidr_block}","${aws_subnet.v1-private.1.cidr_block}"]
}

resource "aws_security_group_rule" "from_db-user" {
	type = "ingress"
	from_port = 3306
	to_port = 3306
	protocol = "tcp"
	security_group_id = "${aws_security_group.db.id}"
	source_security_group_id = "${aws_security_group.db-user.id}"
}

resource "aws_security_group_rule" "dbuser-outbound" {
	type = "egress"
	from_port = 0
	to_port = 0
	protocol = "-1"
	security_group_id = "${aws_security_group.db.id}"
	cidr_blocks = ["0.0.0.0/0"]
}

