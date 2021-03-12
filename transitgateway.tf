############################### VPC1 - VPC2 - VPC3 - VPC4 #################################
resource "aws_ec2_transit_gateway" "allvpc" {
	tags = {
	name = "PublicWeb-PrivateWeb-PrivateDB"
	}
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc1" {
	vpc_id = "${aws_vpc.vpc1.id}"
	transit_gateway_id = "${aws_ec2_transit_gateway.allvpc.id}"
	subnet_ids = ["${aws_subnet.v1-private.0.id}","${aws_subnet.v1-private.1.id}"]
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc2" {
	vpc_id = "${aws_vpc.vpc2.id}"
	transit_gateway_id = "${aws_ec2_transit_gateway.allvpc.id}"
	subnet_ids = ["${aws_subnet.v2-private.0.id}","${aws_subnet.v2-private.1.id}"]
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc3" {
	vpc_id = "${aws_vpc.vpc3.id}"
	transit_gateway_id = "${aws_ec2_transit_gateway.allvpc.id}"
	subnet_ids = ["${aws_subnet.v3-private.0.id}","${aws_subnet.v3-private.1.id}"]
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc4" {
	vpc_id = "${aws_vpc.vpc4.id}"
	transit_gateway_id = "${aws_ec2_transit_gateway.allvpc.id}"
	subnet_ids = ["${aws_subnet.v4-private.0.id}","${aws_subnet.v4-private.1.id}"]
}


