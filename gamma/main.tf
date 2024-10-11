resource "aws_security_group" "allow_outgoing" {
  name        = "allow_outgoing"
  description = "Security group to allow all outgoing traffic"

  # Allow all outgoing traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # All protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_incoming" {
  name        = "allow_incoming"
  description = "Security group to allow various incoming connections"

  # SSH (both ports 22 and 2269)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 2269
    to_port     = 2269
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP, HTTPS, HTTP/3
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # WireGuard UDP
  ingress {
    from_port   = 123
    to_port     = 123
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "gamma" {
  ami = "ami-047126e50991d067b"
  tags = {
    "Name" = "gamma"
  }
  tags_all = {
    "Name" = "gamma"
  }

  instance_type = "t2.micro"

  vpc_security_group_ids = [
    aws_security_group.allow_incoming.id,
    aws_security_group.allow_outgoing.id
  ]
}
