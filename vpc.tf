provider "aws" {
        region = "ap-northeast-2"
}

resource "aws_vpc" "vpc1" {
####### vpc1 = Public Web's VPC
	cidr_block = "10.0.0.0/16"
	enable_dns_hostnames = true
	enable_dns_support = true
	instance_tenancy = "default"

	tags = {
	Name = "VPC1-PublicWeb"
	}
}

resource "aws_vpc" "vpc2" {
####### vpc2 = Private Web's VPC
	cidr_block = "10.1.0.0/16"
	enable_dns_hostnames = true
	enable_dns_support = true
	instance_tenancy = "default"
	
	tags = {
	Name = "VPC2-PrivateWeb"
	}
}

resource "aws_vpc" "vpc3" {
####### vpc3 = Private DB's VPC
	cidr_block = "10.2.0.0/16"
	enable_dns_hostnames = true
	enable_dns_support = true
	instance_tenancy = "default"
	
	tags = {
	Name= "VPC3-PrivateDB"
	}
}

resource "aws_vpc" "vpc4" {
####### vpc4 = Private Storage's VPC
	cidr_block = "10.3.0.0/16"
	enable_dns_hostnames = true
	enable_dns_support = true
	instance_tenancy = "default"
	
	tags = {
	Name= "VPC4-PrivateStorage"
	}
}
