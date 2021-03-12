resource "aws_alb" "vpc1-backupalb" {
	name = "VPC1-BackupALB" 
	subnets = ["${aws_subnet.v1-public.0.id}","${aws_subnet.v1-public.1.id}"]
	internal = false
	security_groups = ["${aws_security_group.elb.id}"]
	
	tags = {
	Name = "VPC1-WebServer-BackupALB"
	}

}

resource "aws_alb_listener" "Backup-alb-listener" {
	load_balancer_arn = "${aws_alb.vpc1-backupalb.arn}"
	port = 80
	protocol = "HTTP"

	default_action {
	type = "forward"
	target_group_arn = "${aws_alb_target_group.to-vpc1-backup-autoscaling.id}"
	}
}

resource "aws_alb_target_group" "to-vpc1-backup-autoscaling" {
	name = "BackupALB-to-BackupAutoscaling"
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
	Name = "To-VPC1-WebServer-Backup-Autoscaling"
	}
}
