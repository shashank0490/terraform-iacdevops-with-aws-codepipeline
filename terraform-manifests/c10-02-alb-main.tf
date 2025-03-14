module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.6.0"

  name = "${local.name}-alb"
  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.public_subnets
  load_balancer_type = "application"
  security_groups = [module.alb-sg.security_group_id]
  tags = local.common_tags

  enable_deletion_protection = false

  # listners
  listeners = {
    # port 80 listner
    my-http-https-redirect = {
      port     = 80
      protocol = "HTTP"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
    # port 443 listner
    my-https-listner = {
      port                        = 443
      protocol                    = "HTTPS"
      ssl_policy                  = "ELBSecurityPolicy-TLS13-1-2-Res-2021-06"
      certificate_arn             = module.acm.acm_certificate_arn

      # Fixed Response for Root Context 
      fixed_response = {
        content_type = "text/plain"
        message_body = "Fixed Static message - for Root Context"
        status_code  = "200"
      }

      rules = {
      # Rule-1: myapp1-rule
        myapp1-rule = {
          priority = 1
          actions = [{
            type = "weighted-forward"
            target_groups = [
              {
                target_group_key = "mytg1"
                weight           = 1
              }
            ]
            stickiness = {
              enabled  = true
              duration = 600
            }
          }]
          conditions = [{
            path_pattern = {
              values = ["/app1*"]
            }
          }]
        } # rule1 ends here
        # Rule-2: myapp2-rule
        myapp2-rule = {
          priority = 2
          actions = [{
            type = "weighted-forward"
            target_groups = [
              {
                target_group_key = "mytg2"
                weight           = 2
              }
            ]
            stickiness = {
              enabled  = true
              duration = 600
            }
          }]
          conditions = [{
            path_pattern = {
              values = ["/app2*"]
            }
          }]
        } # rule2 ends here
      } # rule block ends here
    } # https listener ends here
  }

  # Target Groups
  target_groups = {
    mytg1 = {
      create_attachment = false

      name_prefix                       = "mytg1"
      protocol                          = "HTTP"
      port                              = 80
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_algorithm_type     = "weighted_random"
      load_balancing_anomaly_mitigation = "on"
      load_balancing_cross_zone_enabled = false
      protocol_version = "HTTP1"
      tags = local.common_tags

      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app1/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
    } # Target Group1 ends here
    mytg2 = {
      create_attachment = false

      name_prefix                       = "mytg2"
      protocol                          = "HTTP"
      port                              = 80
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_algorithm_type     = "weighted_random"
      load_balancing_anomaly_mitigation = "on"
      load_balancing_cross_zone_enabled = false
      protocol_version = "HTTP1"
      tags = local.common_tags

      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app2/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
    }
  } 
}

resource "aws_lb_target_group_attachment" "mytg1" {
  for_each = { for k, v in module.ec2-private-app1: k => v}
  target_group_arn = module.alb.target_groups["mytg1"].arn
  target_id = each.value.id
  port = 80
}

resource "aws_lb_target_group_attachment" "mytg2" {
  for_each = { for k, v in module.ec2-private-app2: k => v}
  target_group_arn = module.alb.target_groups["mytg2"].arn
  target_id = each.value.id
  port = 80
}