######################### User Host #######################################
resource "aws_instance" "vpc4-private-user" {
	key_name = "${aws_key_pair.privatestorage.key_name}"
	ami  = "${data.aws_ami.storage-ami.id}"
	instance_type = "${var.type}"
	subnet_id = "${aws_subnet.v4-private.0.id}"
	private_ip = "10.3.100.10"
	vpc_security_group_ids = ["${aws_security_group.vpc4.id}"]

	tags = {
	Name = "VPC4-PrivateUser-FirstStorage"
	}
}
	
