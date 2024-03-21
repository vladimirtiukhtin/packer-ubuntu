source "amazon-ebs" "ubuntu1804" {
  ami_name      = "ubuntu-18.04-${formatdate("YYYY-MM-DD-hhmmss", timestamp())}"
  region        = var.region
  instance_type = var.instance_type
  ssh_interface = "public_ip"
  communicator  = "ssh"
  ssh_username  = "ubuntu"
  max_retries   = 10

  associate_public_ip_address = true

  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-bionic*"
      virtualization-type = "hvm"
      architecture        = "x86_64"
      root-device-type    = "ebs"
    }
    owners = [
      "099720109477"
    ]
    most_recent = true
  }

  launch_block_device_mappings {
    device_name           = "/dev/sda1"
    volume_size           = 8
    volume_type           = "gp2"
    delete_on_termination = true
  }

  subnet_filter {
    filters = {
      "tag:Packer": "shared"
    }
    random = true
  }

  temporary_iam_instance_profile_policy_document {
    Version = "2012-10-17"

    Statement {
      Action  = [
        "s3:GetObject"
      ]
      Effect = "Allow"
      Resource = ["*"]
    }
  }

  tags = merge(local.common_tags, var.extra_tags)
}
