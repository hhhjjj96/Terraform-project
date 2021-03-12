resource "aws_vpc_endpoint" "vpc1-s3" {
	vpc_id = "${aws_vpc.vpc1.id}"
	service_name = "com.amazonaws.ap-northeast-2.s3"

	vpc_endpoint_type = "Gateway"

	tags = {
	Name = "VPC1's S3 Gateway"
	}
}

resource "aws_vpc_endpoint_route_table_association" "vpc1-pri1" {
  route_table_id  = "${aws_route_table.pubweb-pri1.id}"
  vpc_endpoint_id = "${aws_vpc_endpoint.vpc1-s3.id}"
}

resource "aws_vpc_endpoint_route_table_association" "vpc1-pri2" {
  route_table_id  = "${aws_route_table.pubweb-pri2.id}"
  vpc_endpoint_id = "${aws_vpc_endpoint.vpc1-s3.id}"
}
