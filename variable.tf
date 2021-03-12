###################### Subnet ##############################
variable "vpc1-public-subnet-name" {
        type = list
        default = ["VPC1's Public1","VPC1's Public2"]
}

variable "vpc1-private-subnet-name" {
        type = list
        default = ["VPC1's Private1","VPC1's Private2"]
}

variable "vpc2-public-subnet-name" {
        type = list
        default = ["VPC2's Public1","VPC2's Public2"]
}

variable "vpc2-private-subnet-name" {
        type = list
        default = ["VPC2's Private1","VPC2's Private2"]
}

variable "vpc3-private-subnet-name" {
        type = list
        default = ["VPC3's Private1","VPC3's Private2"]
}

variable "vpc4-private-subnet-name" {
        type = list
        default = ["VPC4's Private1","VPC4's Private2"]
}



######################## VPC1 EC2 #############################
variable "howmuch-vpc1nat" {
	default = 2
}

variable "howmuch-webbastion" {
	default = 2
}

variable "howmuch-dbbastion" {
	default = 2
}

############################# VPC2 #################################
variable "howmuch-vpc2private1-user" {
	default = 2
}

variable "howmuch-vpc2private2-user" {
	default = 2
}

variable "howmuch-vpc2nat" {
	default = 2
}

############################# VPC3 #################################
variable "howmuch-vpc3private1-user" {
	default = 2
}

variable "howmuch-vpc3private2-user" {
	default = 2
}

####################################################################
variable "az" {
        type = list
        default = ["ap-northeast-2a","ap-northeast-2c"]
}

variable "ami" {
	default = "ami-006e2f9fa7597680a"
}

variable "type" {
	default = "t2.micro"
}

variable "nat" {
	default = "ami-00550ccc38e992b78"
}
