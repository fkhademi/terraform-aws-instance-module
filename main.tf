resource "aws_security_group" "wan" {
  name   = "${var.name}-wan-sg"
  vpc_id = var.vpc_id

  dynamic "ingress" {
    #iterator    = port
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
    from_port   = "-1"
    to_port     = "-1"
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

resource "aws_security_group" "lan" {
  name   = "${var.name}-lan-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = "-1"
    to_port     = "-1"
    protocol    = "icmp"
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
  vpc               = true
  network_interface = aws_network_interface.wan.id

  tags = {
    "Name" = "${var.name}-eip"
  }
}

resource "aws_instance" "default" {
  ami               = data.aws_ami.ubuntu.id
  instance_type     = var.instance_size
  key_name          = aws_key_pair.default.key_name
  user_data         = var.user_data
  source_dest_check = false

  network_interface {
    network_interface_id = aws_network_interface.wan.id
    device_index         = 0
  }

  network_interface {
    network_interface_id = aws_network_interface.lan.id
    device_index         = 1
  }
  #subnet_id       = var.subnet_id
  #security_groups = [aws_security_group.wan.id]
  #lifecycle {
  #  ignore_changes = [security_groups]
  #}
  tags = {
    Name = "${var.name}-srv"
  }
}

resource "aws_key_pair" "default" {
  key_name   = "${var.name}-key"
  public_key = var.ssh_key
}

resource "aws_network_interface" "wan" {
  subnet_id       = var.wan_subnet_id
  security_groups = [aws_security_group.wan.id]

  # attachment {
  #   instance     = aws_instance.default.id
  #   device_index = 0
  # }
}

resource "aws_network_interface" "lan" {
  subnet_id       = var.lan_subnet_id
  security_groups = [aws_security_group.lan.id]

  # attachment {
  #   instance     = aws_instance.default.id
  #   device_index = 1
  # }
}
