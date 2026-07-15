data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_security_group" "ollama" {
  name        = "${var.project_name}-ollama-sg"
  description = "AI tier - Ollama, only reachable from the App EC2 security group"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_allowed_cidrs
  }

  # Ollama API port — only the App tier's SG can reach this, never 0.0.0.0/0
  ingress {
    description     = "Ollama API - restricted to App EC2 SG"
    from_port       = var.ollama_port
    to_port         = var.ollama_port
    protocol        = "tcp"
    security_groups = [var.app_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-ollama-sg"
  }
}

resource "aws_instance" "ollama" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.ollama.id]
  key_name                    = var.key_pair_name
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    # automated-ollama-setup.sh
    # Designed to run as AWS EC2 User Data for the AI Tier.

    export HOME=/root

    # 1. Install Ollama
    curl -fsSL https://ollama.com/install.sh | sh

    # 2. Wait for Ollama to be available
    sleep 10

    # 3. Configure Ollama to listen on all interfaces
    mkdir -p /etc/systemd/system/ollama.service.d
    cat <<'CONF' > /etc/systemd/system/ollama.service.d/override.conf
    [Service]
    Environment="OLLAMA_HOST=0.0.0.0"
    CONF
    systemctl daemon-reload
    systemctl restart ollama

    # 4. Pull the model
    ollama pull ${var.model_name}
  EOF

  tags = {
    Name = "${var.project_name}-ollama-ec2"
  }
}