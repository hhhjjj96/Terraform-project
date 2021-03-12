resource "aws_db_subnet_group" "db" {
	name = "db"
	subnet_ids = ["${aws_subnet.v3-private.0.id}","${aws_subnet.v3-private.1.id}"]
}

resource "aws_db_instance" "web" {
	identifier = "admin"
	allocated_storage = 10
	engine = "mariadb"
	engine_version = "10.4.13"
	instance_class = "db.t2.micro"
	username = "admin"		#database_user
	name = "redpocket" 		#database_name
	password = "password"		#database_password

	db_subnet_group_name = "${aws_db_subnet_group.db.id}"
	vpc_security_group_ids = ["${aws_security_group.db.id}"]
	skip_final_snapshot = true
}
