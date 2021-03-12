######################### User Host #######################################
resource "aws_instance" "vpc3-private1-user" {
	count = "${var.howmuch-vpc3private1-user}"
	key_name = "${aws_key_pair.privatedb.key_name}"
	ami  = "${data.aws_ami.dbuser-ami.id}"
	instance_type = "${var.type}"
	subnet_id = "${aws_subnet.v3-private.0.id}"
	private_ip = "10.2.100.${count.index+10}"
	vpc_security_group_ids = ["${aws_security_group.db-user.id}"]
	
	tags = {
	Name = "VPC3-PrivateSubnet1.${count.index}"
	}
}
	
resource "aws_instance" "vpc3-private2-user" {
	count = "${var.howmuch-vpc3private2-user}"
	key_name = "${aws_key_pair.privatedb.key_name}"
	ami  = "${data.aws_ami.dbuser-ami.id}"
	instance_type = "${var.type}"
	subnet_id = "${aws_subnet.v3-private.1.id}"
	private_ip = "10.2.101.${count.index+10}"
	vpc_security_group_ids = ["${aws_security_group.db-user.id}"]
	
	tags = {
	Name = "VPC3-PrivateSubnet2.${count.index}"
	}
}
