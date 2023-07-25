resource "aws_security_group" "default" {
  name   = "${var.name}-sg"
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "UDP"
      cidr_blocks = ["0.0.0.0/0"]
    }
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

resource "aws_eip" "default" {
  count             = var.public_ip ? 1 : 0
  network_interface = aws_instance.default.primary_network_interface_id

  tags = {
    "Name" = "${var.name}-eip"
  }
}

resource "aws_instance" "default" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.instance_size
  key_name        = aws_key_pair.default.key_name
  subnet_id       = var.subnet_id
  security_groups = [aws_security_group.default.id]
  user_data       = var.user_data
  lifecycle {
    ignore_changes = [security_groups]
  }
  tags = {
    Name = "${var.name}-srv"
  }
}

resource "aws_key_pair" "default" {
  key_name   = "${var.name}-key"
  public_key = var.ssh_key
}
