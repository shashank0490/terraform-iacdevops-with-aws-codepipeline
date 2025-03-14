resource "aws_launch_template" "asg-lt" {
  
  name = "${local.name}-asg-lt"
  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 20
      delete_on_termination = true
      volume_type = "gp3"
    }
  }
  monitoring {
    enabled = true
  }
  image_id = data.aws_ami.amznlinux2023.id
  instance_type = var.instance_type
  vpc_security_group_ids = [module.private-sg.security_group_id]
  key_name = var.instance_keypair
  user_data = filebase64("${path.module}/scripts/app1-install.sh")
  ebs_optimized = true
  update_default_version = true

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${local.name}-asg-lt"
    }
  }

}