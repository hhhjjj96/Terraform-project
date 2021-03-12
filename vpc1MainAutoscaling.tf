resource "aws_launch_template" "webserver" {
	key_name = "${aws_key_pair.publicweb.key_name}"
	name = "VPC1-WebServer"
	description = "WebServer's template"
	image_id = "${data.aws_ami.webserver-ami.id}"
	instance_type = "${var.type}"
	vpc_security_group_ids = ["${aws_security_group.autoscaling.id}"]

	user_data = filebase64("shellscript/docker.sh")
}

resource "aws_autoscaling_group" "main-auto" {
	name = "WebServer-Autoscaling"
	launch_template {
	id	= "${aws_launch_template.webserver.id}"
	version = "$Latest"
	}

	min_size = 1
	desired_capacity = 1
	max_size = 4

	health_check_type = "EC2"
	vpc_zone_identifier = ["${aws_subnet.v1-private.0.id}","${aws_subnet.v1-private.1.id}"]
	protect_from_scale_in = true
	
	tag {	
	key = "Name"
	value = "VPC1-Autoscaling-Group"
	propagate_at_launch = true
	}
}

resource "aws_autoscaling_policy" "main-auto-policy" {
	name = "main-auto-policy"
	policy_type = "TargetTrackingScaling"
	autoscaling_group_name = "${aws_autoscaling_group.main-auto.name}"
	estimated_instance_warmup = 180
	
	target_tracking_configuration {

		predefined_metric_specification {
			predefined_metric_type = "ASGAverageCPUUtilization"
			}

		target_value = "60"
		}
}
	

resource "aws_autoscaling_attachment" "to-vpc1ALB" {
	autoscaling_group_name = "${aws_autoscaling_group.main-auto.id}"
	alb_target_group_arn = "${aws_alb_target_group.vpc1-autoscaling.arn}"
}	
	
