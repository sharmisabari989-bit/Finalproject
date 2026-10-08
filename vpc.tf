 #vpc
 resource "aws_vpc" "projectvpc" {
  cidr_block       = "11.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "finalvpc"
  }
}
#pubsub1
resource "aws_subnet" "pub-sub1" {
  vpc_id     = aws_vpc.projectvpc.id
  cidr_block = "11.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "pubsub1"
  }
}
#pubsub2
resource "aws_subnet" "pub-sub2" {
  vpc_id     = aws_vpc.projectvpc.id
  cidr_block = "11.0.2.0/24"
  availability_zone =  "us-east-1b"

  tags = {
    Name = "pubsub2"
  }
}
#internet gateway
resource "aws_internet_gateway" "gw1"{
  vpc_id = aws_vpc.projectvpc.id

  tags = {
    Name = "finalprojectgw"
  }
}
#routetable
resource "aws_route_table" "finalroute" {
  vpc_id = aws_vpc.projectvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw1.id
  }
  tags = {
    Name = "finalroutetable"
  }
}
# association
resource "aws_route_table_association" "rt-asso1" {
  subnet_id      = aws_subnet.pub-sub1.id
  route_table_id = aws_route_table.finalroute.id
}
resource "aws_route_table_association" "rt-asso2" {
  subnet_id      = aws_subnet.pub-sub2.id
  route_table_id = aws_route_table.finalroute.id
}
