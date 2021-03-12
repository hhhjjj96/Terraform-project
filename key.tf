resource "aws_key_pair" "privatestorage" {
	key_name = "PrivateStorage"
	public_key = file("/home/test/.ssh/PrivateStorage.pub")
}

resource "aws_key_pair" "privatedb" {
	key_name = "PrivateDB"
	public_key = file("/home/test/.ssh/PrivateDB.pub")
}

resource "aws_key_pair" "privateweb" {
	key_name = "PrivateWeb"
	public_key = file("/home/test/.ssh/PrivateWeb.pub")
}

resource "aws_key_pair" "publicweb" {
	key_name = "PublicWeb"
	public_key = file("/home/test/.ssh/PublicWeb.pub")
}

