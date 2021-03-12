resource "aws_alb" "vpc1-alb" {
	name = "VPC1-ALB" 
	subnets = ["${aws_subnet.v1-public.0.id}","${aws_subnet.v1-public.1.id}"]
	internal = false
	security_groups = ["${aws_security_group.elb.id}"]
	
	tags = {
	Name = "VPC1-WebServer-ALB"
	}

}

resource "aws_alb_listener" "alb_listener" {
	load_balancer_arn = "${aws_alb.vpc1-alb.arn}"
	port = 80
	protocol = "HTTP"

	default_action {
	type = "forward"
	target_group_arn = "${aws_alb_target_group.vpc1-autoscaling.id}"
	}
}

resource "aws_alb_target_group" "vpc1-autoscaling" {
	name = "ALB-to-Autoscaling"
	port = 80
	protocol = "HTTP"
	vpc_id = "${aws_vpc.vpc1.id}"
	
	health_check {
	interval = 30
	timeout = 25
	
	healthy_threshold = 3
	unhealthy_threshold = 3
	path = "/"
	}

	tags = {
	Name = "VPC1-WebServer-Autoscaling"
	}
}
