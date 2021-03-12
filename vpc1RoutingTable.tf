########################### Internet Gateway #####################################
resource "aws_internet_gateway" "public-web" {
	vpc_id = "${aws_vpc.vpc1.id}"
	tags = {
	Name = "Public-Web's-gateway"
	}
}

########################### VPC1 Route Table ######################################

resource "aws_route_table" "pubweb-pub1" {
	vpc_id = "${aws_vpc.vpc1.id}"
	
	route {
	cidr_block = "0.0.0.0/0"
	gateway_id = "${aws_internet_gateway.public-web.id}"
	}
	
	route {
	cidr_block = "${aws_vpc.vpc2.cidr_block}"
	gateway_id = "${aws_ec2_transit_gateway.allvpc.id}"
	}

	route {
	cidr_block = "${aws_vpc.vpc3.cidr_block}"
	gateway_id = "${aws_ec2_transit_gateway.allvpc.id}"
	}

	tags = {
	Name = "PublicWeb-PublicSubnet1"
	}
}

resource "aws_route_table" "pubweb-pub2" {
	vpc_id = "${aws_vpc.vpc1.id}"

	route {
	cidr_block = "0.0.0.0/0"
	gateway_id = "${aws_internet_gateway.public-web.id}"
	}

	route {
	cidr_block = "${aws_vpc.vpc2.cidr_block}"
	gateway_id = "${aws_ec2_transit_gateway.allvpc.id}"
	}

	route {
	cidr_block = "${aws_vpc.vpc3.cidr_block}"
	gateway_id = "${aws_ec2_transit_gateway.allvpc.id}"
	}

	tags = {
	Name = "PublicWeb-PublicSubnet2"
	}
}

resource "aws_route_table" "pubweb-pri1" {
	vpc_id = "${aws_vpc.vpc1.id}"

	route {
	cidr_block = "${aws_vpc.vpc2.cidr_block}"
	gateway_id = "${aws_ec2_transit_gateway.allvpc.id}"
	}
	
	route {
	cidr_block = "${aws_vpc.vpc3.cidr_block}"
	gateway_id = "${aws_ec2_transit_gateway.allvpc.id}"
	}

	route {
	cidr_block = "0.0.0.0/0"
	instance_id = "${aws_instance.vpc1-nat.0.id}"
	}

	tags = {
	Name = "PublicWeb-PrivateSubnet1"
	}
}

resource "aws_route_table" "pubweb-pri2" {
	vpc_id = "${aws_vpc.vpc1.id}"

	route {
	cidr_block = "${aws_vpc.vpc2.cidr_block}"
	gateway_id = "${aws_ec2_transit_gateway.allvpc.id}"
	}
	
	route {
	cidr_block = "${aws_vpc.vpc3.cidr_block}"
	gateway_id = "${aws_ec2_transit_gateway.allvpc.id}"
	}

	route {
	cidr_block = "0.0.0.0/0"
	instance_id = "${aws_instance.vpc1-nat.1.id}"
	}

	tags = {
	Name = "PublicWeb-PrivateSubnet2"
	}
}

resource "aws_route_table_association" "pubweb-pub1" {
	subnet_id = "${aws_subnet.v1-public.0.id}"
	route_table_id = "${aws_route_table.pubweb-pub1.id}"
}

resource "aws_route_table_association" "pubweb-pub2" {
	subnet_id = "${aws_subnet.v1-public.1.id}"
	route_table_id = "${aws_route_table.pubweb-pub2.id}"
}

resource "aws_route_table_association" "pubweb-pri1" {
	subnet_id = "${aws_subnet.v1-private.0.id}"
	route_table_id = "${aws_route_table.pubweb-pri1.id}"
}

resource "aws_route_table_association" "pubweb-pri2" {
	subnet_id = "${aws_subnet.v1-private.1.id}"
	route_table_id = "${aws_route_table.pubweb-pri2.id}"
}

