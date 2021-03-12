############################## Nat Instance ############################
resource "aws_instance" "vpc1-nat" {
	count = "${var.howmuch-vpc1nat}"
	ami = "${var.nat}"
	instance_type = "${var.type}"
	subnet_id = "${element(tolist(data.aws_subnet_ids.vpc1-pub.ids),count.index)}"
	source_dest_check = "false"
	vpc_security_group_ids = ["${aws_security_group.nat.id}"]

	tags = {
	Name = "VPC1-Nat-instance"
	}
}

############################## Bastion Host ##############################
resource "aws_instance" "web-bastion" {
	count 	= "${var.howmuch-webbastion}"
	key_name = "${aws_key_pair.publicweb.key_name}"
	ami	= "${data.aws_ami.web-bastion-ami.id}"
	instance_type = "${var.type}"
	subnet_id = "${element(tolist(data.aws_subnet_ids.vpc1-pub.ids),count.index)}"
	vpc_security_group_ids = ["${aws_security_group.web-bastion.id}"]

	tags = {
	Name = "Private-Web-BastionHost"
	}
}

resource "aws_instance" "db-bastion" {
	count 	= "${var.howmuch-dbbastion}"
	key_name = "${aws_key_pair.publicweb.key_name}"
	ami	= "${data.aws_ami.db-bastion-ami.id}"
	instance_type = "${var.type}"
	subnet_id = "${element(tolist(data.aws_subnet_ids.vpc1-pub.ids),count.index)}"
	vpc_security_group_ids = ["${aws_security_group.db-bastion.id}"]
	
	tags = {
	Name = "Private-DB-BastionHost"
	}
}
