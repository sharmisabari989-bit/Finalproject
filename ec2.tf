#instance1
resource "aws_instance" "ins1" {
  ami           = "ami-0d27e0fb3bac4d724"
  associate_public_ip_address = "true"
  instance_type = "t3.micro"
  key_name = "shartest"
  subnet_id = aws_subnet.pub-sub1.id

  vpc_security_group_ids = [aws_security_group.projectsecurity.id]


  tags = {
    Name = "finalins1"
    name = "projectins1"
    team = "finalproject"
  }
}
#instance2
resource "aws_instance" "ins2" {
  ami           = "ami-0d27e0fb3bac4d724"
  associate_public_ip_address = "true"
  instance_type = "t3.micro"
  key_name = "shartest"
  subnet_id = aws_subnet.pub-sub2.id

  vpc_security_group_ids = [aws_security_group.projectsecurity.id]


  tags = {
    Name = "finalins2"
    name = "projectins2"
    team = "finalproject"
  }
}
#sec grp
resource "aws_security_group" "projectsecurity" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.projectvpc.id

  tags = {
    Name = "pro-security"
  }
}
#rules
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.projectsecurity.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}
resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.projectsecurity.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.projectsecurity.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}
resource "aws_vpc_security_group_egress_rule" "allow_outbound" {
  security_group_id = aws_security_group.projectsecurity.id
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}
