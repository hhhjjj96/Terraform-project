######################### Nat Instance ##################################
resource "aws_instance" "vpc2-nat" {
	count = "${var.howmuch-vpc2nat}"
	ami = "${var.nat}"
	instance_type = "${var.type}"
	subnet_id = "${element(tolist(data.aws_subnet_ids.vpc2-nat.ids),count.index)}"
	vpc_security_group_ids = ["${aws_security_group.vpc2-nat.id}"]
	source_dest_check = "false"

	tags = {
	Name = "VPC2-Nat-instance.${count.index}"
	}
}

######################### User Host #######################################
resource "aws_instance" "vpc2-host1" {
	count = "${var.howmuch-vpc2private1-user}"
	key_name = "${aws_key_pair.privateweb.key_name}"
	ami  = "${data.aws_ami.webuser-ami.id}"
	instance_type = "${var.type}"
	vpc_security_group_ids = ["${aws_security_group.web-user.id}"]
	subnet_id = "${aws_subnet.v2-private.0.id}"
	private_ip = "10.1.100.${count.index+10}"
	tags = {
	Name = "VPC2-User-PrivateSubnet1.${count.index}"
	}
}
	
resource "aws_instance" "vpc2-host2" {
	count = "${var.howmuch-vpc2private2-user}"
	key_name = "${aws_key_pair.privateweb.key_name}"
	ami  = "${data.aws_ami.webuser-ami.id}"
	instance_type = "${var.type}"
	vpc_security_group_ids = ["${aws_security_group.web-user.id}"]
	subnet_id = "${aws_subnet.v2-private.1.id}"
	private_ip = "10.1.101.${count.index+10}"

	tags = {
	Name = "VPC2-User-PrivateSubnet2.${count.index}"
	}
}
