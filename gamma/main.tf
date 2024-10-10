resource "aws_security_group" "allow_all" {
  name        = "allow_all_ports"
  description = "Security group to allow all ports"

  # Allow all TCP traffic
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all UDP traffic
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outgoing TCP traffic
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outgoing UDP traffic
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "existing" {
  ami = "ami-047126e50991d067b"
  tags = {
    "Name" = "gamma"
  }
  tags_all = {
    "Name" = "gamma"
  }

  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.allow_all.id]
}
