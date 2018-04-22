provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "dev_instance" {
  ami = "ami-ac442ac3"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.dev_key.key_name}"
  vpc_security_group_ids = ["${aws_security_group.dev_sg.id}"]

  tags {
    Name = "My dev instance"
  }
}

resource "aws_key_pair" "dev_key" {
  key_name = "dev-key"
  public_key = "${file("${var.ssh_dev_key_file}.pub")}"
}

resource "aws_security_group" "dev_sg" {
  name = "dev-sg"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "Dev security group"
  }

  egress {
    to_port = 0
    from_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}