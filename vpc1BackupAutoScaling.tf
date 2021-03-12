resource "aws_launch_template" "backup-webserver" {
	name = "VPC1-BackupWebServer"
	description = "Backup WebServer's template"
	image_id = "${data.aws_ami.webserver-ami.id}"
	instance_type = "${var.type}"
	vpc_security_group_ids = ["${aws_security_group.autoscaling.id}"]

	user_data = filebase64("shellscript/docker.sh")
}

resource "aws_autoscaling_group" "backup-auto" {
	name = "WebServer-BackupAutoscaling"
	launch_template {
	id	= "${aws_launch_template.backup-webserver.id}"
	version = "$Latest"
	}

	min_size = 0
	desired_capacity = 0
	max_size = 4

	health_check_type = "ELB"
	vpc_zone_identifier = ["${aws_subnet.v1-private.0.id}","${aws_subnet.v1-private.1.id}"]
	
	tag {	
	key = "Name"
	value = "VPC1-Backup-Autoscaling-Group"
	propagate_at_launch = true
	}
}

resource "aws_autoscaling_policy" "backup-auto-policy" {
        name = "main-auto-policy"
        policy_type = "TargetTrackingScaling"
        autoscaling_group_name = "${aws_autoscaling_group.backup-auto.name}"
        estimated_instance_warmup = 180

        target_tracking_configuration {

                predefined_metric_specification {
                        predefined_metric_type = "ASGAverageCPUUtilization"
                        }

                target_value = "60"
                }
}

resource "aws_autoscaling_attachment" "to-vpc1BackupALB" {
	autoscaling_group_name = "${aws_autoscaling_group.backup-auto.id}"
	alb_target_group_arn = "${aws_alb_target_group.to-vpc1-backup-autoscaling.arn}"
}	
	
