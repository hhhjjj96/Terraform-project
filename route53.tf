resource "aws_route53_record" "www" {
	name = "www.2hjin.com"
	type = "A"
	zone_id ="${data.aws_route53_zone.twohjin.zone_id}"

	alias {
	evaluate_target_health = true
	name = "${aws_alb.vpc1-alb.dns_name}"
	zone_id = "${aws_alb.vpc1-alb.zone_id}"
	
	#name = "${aws_alb.vpc1-backupalb.dns_name}"
	#zone_id= "${aws_alb.vpc1-backupalb.zone_id}"
	}
}
