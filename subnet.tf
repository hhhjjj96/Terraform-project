############################## VPC1 #################################
resource "aws_subnet" "v1-public" {
	count = "${length(var.vpc1-public-subnet-name)}"
	vpc_id = "${aws_vpc.vpc1.id}"
	cidr_block = "10.0.${count.index}.0/24"
	map_public_ip_on_launch = true
	availability_zone = "${var.az[count.index]}"
	tags = {
	Name = "${var.vpc1-public-subnet-name[count.index]}"
	}
}

resource "aws_subnet" "v1-private" {
	count = "${length(var.vpc1-private-subnet-name)}"
	vpc_id = "${aws_vpc.vpc1.id}"
	cidr_block = "10.0.${count.index+100}.0/24"
	map_public_ip_on_launch = false
	availability_zone = "${var.az[count.index]}"
	tags = {
	Name = "${var.vpc1-private-subnet-name[count.index]}"
	}
}

############################## VPC2 ###################################
resource "aws_subnet" "v2-public" {
	count = "${length(var.vpc2-public-subnet-name)}"
	vpc_id = "${aws_vpc.vpc2.id}"
	cidr_block = "10.1.${count.index}.0/24"
	map_public_ip_on_launch = true
	availability_zone = "${var.az[count.index]}"
	tags = {
	Name = "${var.vpc2-public-subnet-name[count.index]}"
	}
}

resource "aws_subnet" "v2-private" {
	count = "${length(var.vpc2-private-subnet-name)}"
	vpc_id = "${aws_vpc.vpc2.id}"
	cidr_block = "10.1.${count.index+100}.0/24"
	map_public_ip_on_launch = false
	availability_zone = "${var.az[count.index]}"
	tags = {
	Name = "${var.vpc2-private-subnet-name[count.index]}"
	}
}

############################## VPC3 ###################################
resource "aws_subnet" "v3-private" {
	count = "${length(var.vpc3-private-subnet-name)}"
	vpc_id = "${aws_vpc.vpc3.id}"
	cidr_block = "10.2.${count.index+100}.0/24"
	map_public_ip_on_launch = false
	availability_zone = "${var.az[count.index]}"
	tags = {
	Name = "${var.vpc3-private-subnet-name[count.index]}"
	}
}

############################## VPC4 ###################################
resource "aws_subnet" "v4-private" {
	count = "${length(var.vpc4-private-subnet-name)}"
	vpc_id = "${aws_vpc.vpc4.id}"
	cidr_block = "10.3.${count.index+100}.0/24"
	map_public_ip_on_launch = false
	availability_zone = "${var.az[count.index]}"
	tags = {
	Name = "${var.vpc4-private-subnet-name[count.index]}"
	}
}
