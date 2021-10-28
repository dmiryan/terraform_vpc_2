provider "aws" {
  region = "eu-north-1"
}

resource "aws_vpc" "vpc-1" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name  = "vpc-1"
    vpc-1 = "vpc-1"
  }

}

resource "aws_instance" "ubuntu-vpc-1" {
  ami           = "ami-003773449898844f8"
  instance_type = "t3.micro"
  tags = {
    Name = "ubuntu-vpc-1"
  }
  iam_instance_profile = "AdminAccessFullEC2"
  subnet_id            = aws_subnet.subnet-1.id
}

resource "aws_subnet" "subnet-1" {
  vpc_id                  = aws_vpc.vpc-1.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true" //it makes this a public subnet
  availability_zone       = "eu-north-1a"
  tags = {
    Name     = "subnet-1"
    subnet-1 = "subnet-1"
  }
}

resource "aws_internet_gateway" "igw-vpc-1" {
  vpc_id = aws_vpc.vpc-1.id
  tags = {
    igw-vpc-1 = "igw-vpc-1"
  }
}
resource "aws_route_table" "PublicRoute-vpc-1" {
  vpc_id = aws_vpc.vpc-1.id
  route = [
    {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw-vpc-1.id
                carrier_gateway_id = null
                destination_prefix_list_id = null
                egress_only_gateway_id = null
                instance_id = null
                ipv6_cidr_block  = null
                local_gateway_id = null
                nat_gateway_id = null
                network_interface_id = null
                transit_gateway_id = null
                vpc_endpoint_id = null
                vpc_peering_connection_id = null

    }

  ]



}


/*
resource "aws_instance" "vm" {
  ami           = "ami-0ac0e2fead9b45d6d"
  instance_type = "t3.micro"
  tags = {
    Name = "ubuntu-tf-1"
  }
}
*/
//
