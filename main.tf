
resource "aws_key_pair" "jenkins_key" {
  key_name   = "ec2keypair-mac"
  public_key = var.public_key
}


data "aws_ami_ids" "jenkins_ami" {
  sort_ascending = false

  owners = ["aws-marketplace"]

  filter {
    name   = "name"
    values = ["bitnami-jenkins*"]
  }
}

resource "aws_security_group" "jenkins_security_group" {
  name        = "Jenkins Security Group"
  description = "Allow traffic to access Jenkins instrance"

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress_rules
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    iterator = port
    for_each = var.egress_rules
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}


resource "aws_instance" "jenkins_instance" {
  ami             = data.aws_ami_ids.jenkins_ami.ids[0]
  instance_type   = var.instance_type
  security_groups = [aws_security_group.jenkins_security_group.name]
  key_name        = aws_key_pair.jenkins_key.key_name
  tags = {
    Name = var.jenkinsInstanceName
  }

  depends_on = [aws_security_group.jenkins_security_group]
}