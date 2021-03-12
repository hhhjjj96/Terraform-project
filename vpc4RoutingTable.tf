resource "aws_route_table" "pri-storage1" {
	vpc_id = "${aws_vpc.vpc4.id}"

	route {
	cidr_block = "${aws_vpc.vpc2.cidr_block}"
	gateway_id = "${aws_ec2_transit_gateway.allvpc.id}"
	}

	route {
	cidr_block = "${aws_vpc.vpc3.cidr_block}"
	gateway_id = "${aws_ec2_transit_gateway.allvpc.id}"
	}

	tags = {
	Name = "Private-Storage-Pri-1"
	}
}

resource "aws_route_table" "pri-storage2" {
	vpc_id = "${aws_vpc.vpc4.id}"

	route {
	cidr_block = "${aws_vpc.vpc2.cidr_block}"
	gateway_id = "${aws_ec2_transit_gateway.allvpc.id}"
	}

	route {
	cidr_block = "${aws_vpc.vpc3.cidr_block}"
	gateway_id = "${aws_ec2_transit_gateway.allvpc.id}"
	}

	tags = {
	Name = "Private-Storage-Pri-2"
	}
}

resource "aws_route_table_association" "pri-storage1" {
	subnet_id = "${aws_subnet.v4-private.0.id}"
	route_table_id = "${aws_route_table.pri-storage1.id}"
}

resource "aws_route_table_association" "pri-storage2" {
	subnet_id = "${aws_subnet.v4-private.1.id}"
	route_table_id = "${aws_route_table.pri-storage2.id}"
}


