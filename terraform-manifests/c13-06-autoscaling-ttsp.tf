resource "aws_autoscaling_policy" "avg_cpu" {

  name = "${local.name}-avg_cpu_utilization"
  autoscaling_group_name = aws_autoscaling_group.asg.name
  policy_type = "TargetTrackingScaling"
  estimated_instance_warmup = 180
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 50.0
  }

}

resource "aws_autoscaling_policy" "alb_request" {

  name = "${local.name}-alb_request"
  autoscaling_group_name = aws_autoscaling_group.asg.name
  policy_type = "TargetTrackingScaling"
  estimated_instance_warmup = 180
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label = "${module.alb.arn_suffix}/${module.alb.target_groups["mytg1"].arn_suffix}"
    }

    target_value = 10
  }

}

