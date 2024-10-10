resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Security group to allow ssh connection"

  # SSH
  ingress {
    from_port   = 0
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH
  ingress {
    from_port   = 0
    to_port     = 2269
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "allow_outgoing" {
  name        = "allow_outgoing"
  description = "Security group to allow all outgoing"

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

resource "aws_security_group" "allow_wireguard" {
  name        = "allow_wireguard"
  description = "Security group to allow wireguard"


  # Wireguard UDP
  ingress {
    from_port   = 0
    to_port     = 123
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # # wg-easy Web
  # ingress {
  #   from_port   = 0
  #   to_port     = 51820
  #   protocol    = "udp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

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
    aws_security_group.allow_ssh.id,
    aws_security_group.allow_outgoing.id,
    aws_security_group.allow_wireguard.id
  ]
}
