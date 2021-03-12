resource "aws_vpc_endpoint" "vpc4-s3" {
        vpc_id = "${aws_vpc.vpc4.id}"
        service_name = "com.amazonaws.ap-northeast-2.s3"

        vpc_endpoint_type = "Gateway"

        tags = {
        Name = "VPC4's S3 Gateway"
        }
}

resource "aws_vpc_endpoint_route_table_association" "vpc4-pri1" {
  route_table_id  = "${aws_route_table.pri-storage1.id}"
  vpc_endpoint_id = "${aws_vpc_endpoint.vpc4-s3.id}"
}

resource "aws_vpc_endpoint_route_table_association" "vpc4-pri2" {
  route_table_id  = "${aws_route_table.pri-storage2.id}"
  vpc_endpoint_id = "${aws_vpc_endpoint.vpc4-s3.id}"
}
