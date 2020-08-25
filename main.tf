resource "aws_security_group" "app1_sg" {
  name   = "${var.name}-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "ICMP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "srv1" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_size
  key_name                    = aws_key_pair.key.key_name
  subnet_id                   = var.subnet_id
  associate_public_ip_address = false
  security_groups             = [aws_security_group.app1_sg.id]
  lifecycle {
    ignore_changes = [security_groups]
  }
      tags = {
    name = "${var.name}-srv"
  }
}

resource "aws_key_pair" "key" {
  key_name   = "${var.name}-key"
  public_key = var.ssh_key
}