resource "aws_autoscaling_group" "asg" {

  name = "${local.name}-asg"
  max_size = 5
  min_size = 2
  vpc_zone_identifier =  module.vpc.private_subnets 
  target_group_arns = [module.alb.target_groups["mytg1"].arn, module.alb.target_groups["mytg2"].arn]
  health_check_type = "EC2"

  launch_template {
    id      = aws_launch_template.asg-lt.id
    version = aws_launch_template.asg-lt.latest_version
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["desired_capacity","launch_template"] 
  }

  tag {
    key                 = "owner"
    value               = "devops-team"
    propagate_at_launch = true
  }

}