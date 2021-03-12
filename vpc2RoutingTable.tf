########################## Internet Gateway ####################
resource "aws_internet_gateway" "vpc2" {
	vpc_id = "${aws_vpc.vpc2.id}"

	tags 	= {
	Name = "Nat-instance's_internet_gateway"
	}
}

########################## VPC2 RouteTable ######################
resource "aws_route_table" "private-web-pub1" {
	vpc_id = "${aws_vpc.vpc2.id}"

	route {
	cidr_block = "0.0.0.0/0"
	gateway_id = "${aws_internet_gateway.vpc2.id}"
	}

	tags = {
	Name = "Private-web-pub1"
	}
}

resource "aws_route_table" "private-web-pub2" {
	vpc_id = "${aws_vpc.vpc2.id}"

	route {
	cidr_block = "0.0.0.0/0"
	gateway_id = "${aws_internet_gateway.vpc2.id}"
	}

	tags = {
	Name = "Private-web-pub2"
	}
}
	
resource "aws_route_table" "private-web-pri1" {
	vpc_id = "${aws_vpc.vpc2.id}"

	route {
	cidr_block = "${aws_vpc.vpc1.cidr_block}"
	gateway_id = "${aws_ec2_transit_gateway.allvpc.id}"
	}

	route {
	cidr_block = "${aws_vpc.vpc4.cidr_block}"
	gateway_id = "${aws_ec2_transit_gateway.allvpc.id}"
	}

	route {
	cidr_block = "0.0.0.0/0"
	instance_id = "${aws_instance.vpc2-nat.0.id}"
	}

	tags = {
	Name = "Private-web-Pri1"
	}
}

resource "aws_route_table" "private-web-pri2" {
	vpc_id = "${aws_vpc.vpc2.id}"

	route {
	cidr_block = "${aws_vpc.vpc1.cidr_block}"
	gateway_id = "${aws_ec2_transit_gateway.allvpc.id}"
	}

	route {
	cidr_block = "${aws_vpc.vpc4.cidr_block}"
	gateway_id = "${aws_ec2_transit_gateway.allvpc.id}"
	}
	
	route {
	cidr_block = "0.0.0.0/0"
	instance_id = "${aws_instance.vpc2-nat.1.id}"
	}

	tags = {
	Name = "Private-web-Pri2"
	}
}

resource "aws_route_table_association" "pub-web1" {
	subnet_id = "${aws_subnet.v2-public.0.id}"
	route_table_id = "${aws_route_table.private-web-pub1.id}"
}

resource "aws_route_table_association" "pub-web2" {
	subnet_id = "${aws_subnet.v2-public.1.id}"
	route_table_id = "${aws_route_table.private-web-pub2.id}"
}

resource "aws_route_table_association" "pri-web1" {
	subnet_id = "${aws_subnet.v2-private.0.id}"
	route_table_id = "${aws_route_table.private-web-pri1.id}"
}

resource "aws_route_table_association" "pri-web2" {
	subnet_id = "${aws_subnet.v2-private.1.id}"
	route_table_id = "${aws_route_table.private-web-pri2.id}"
}


