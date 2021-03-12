resource "aws_route_table" "pri-db1" {
	vpc_id = "${aws_vpc.vpc3.id}"

	route {
	cidr_block = "${aws_vpc.vpc1.cidr_block}"
	gateway_id = "${aws_ec2_transit_gateway.allvpc.id}"
	}
	
	route {
	cidr_block = "${aws_vpc.vpc4.cidr_block}"
	gateway_id = "${aws_ec2_transit_gateway.allvpc.id}"
	}
	
	tags = {
	Name = "Private-DB-Pri1"
	}
}

resource "aws_route_table" "pri-db2" {
	vpc_id = "${aws_vpc.vpc3.id}"

	route {
	cidr_block = "${aws_vpc.vpc1.cidr_block}"
	gateway_id = "${aws_ec2_transit_gateway.allvpc.id}"
	}
	
	route {
	cidr_block = "${aws_vpc.vpc4.cidr_block}"
	gateway_id = "${aws_ec2_transit_gateway.allvpc.id}"
	}
	
	tags = {
	Name = "Private-DB-Pri2"
	}
}

resource "aws_route_table_association" "pri-db1" {
	subnet_id = "${aws_subnet.v3-private.0.id}"
	route_table_id = "${aws_route_table.pri-db1.id}"
}

resource "aws_route_table_association" "pri-db2" {
	subnet_id = "${aws_subnet.v3-private.1.id}"
	route_table_id = "${aws_route_table.pri-db2.id}"
}


