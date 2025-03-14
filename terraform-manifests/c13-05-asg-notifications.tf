resource "aws_sns_topic" "asg_sns_topic" {
  name = "asg-sns-topic-${random_pet.this.id}"
}

resource "aws_sns_topic_subscription" "asg_sns_subscription" {
  topic_arn = aws_sns_topic.asg_sns_topic.arn
  protocol = "email"
  endpoint = "shashank.mobifly@gmail.com"
}

resource "aws_autoscaling_notification" "asg_notification" {
  group_names = [aws_autoscaling_group.asg.name]
  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]
  topic_arn = aws_sns_topic.asg_sns_topic.arn
}