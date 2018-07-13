data "aws_ami" "infoblox" {
  most_recent = true

  filter {
    name   = "description"
    values = ["Infoblox DDI for AWS *"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners   = ["057670693668"]

}

resource "aws_instance" "web" {
  ami                                  = "${data.aws_ami.infoblox.id}"
  instance_type                        = "${var.instance_type}"
  disable_api_termination              = "${var.disable_api_termination}"
  instance_initiated_shutdown_behavior = "${var.instance_initiated_shutdown_behavior}"
  key_name                             = "${var.key_name}"
  monitoring                           = "${var.monitoring}"
  subnet_id                            = "${var.subnet_id}"
  associate_public_ip_address          = "${var.associate_public_ip_address}"
  
  tags {
    Name      = "infoblox-ami"
    ManagedBy = "Terraform"
  }
}

