#S3 Bucket to capture RabbitMQ ALB access logs
resource "aws_s3_bucket" "s3_bucket_rabbitmq" {
  count = var.s3_bucket_exists == false ? 1 : 0
  bucket = var.access_log_bucket
  
  force_destroy = true

  tags = {
    Environment = var.env
  }
}

#S3 Bucket Server Side Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "s3bucket_encryption_rabbitmq" {
  count = var.s3_bucket_exists == false ? 1 : 0
  bucket = aws_s3_bucket.s3_bucket_rabbitmq[0].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

#Apply Bucket Policy to S3 Bucket
resource "aws_s3_bucket_policy" "s3bucket_policy_rabbitmq" {
  count = var.s3_bucket_exists == false ? 1 : 0
  bucket = aws_s3_bucket.s3_bucket_rabbitmq[0].id
  policy = file("bucket-policy.json")
  
  depends_on = [aws_s3_bucket_server_side_encryption_configuration.s3bucket_encryption_rabbitmq]
}

#################################################### RabbitMQ ALB #####################################################################

# Security Group for RabbitMQ ALB
resource "aws_security_group" "rabbitmq_alb" {
  name        = "RabbitMQ-ALB-SecurityGroup"
  description = "Security Group for RabbitMQ ALB"
  vpc_id      = aws_vpc.test_vpc.id

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = var.cidr_blocks
  }

  ingress {
    protocol   = "tcp"
    cidr_blocks = var.cidr_blocks
    from_port  = 80
    to_port    = 80
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "RabbitMQ-ALB-sg"
  }
}

#RabbitMQ Application Loadbalancer
resource "aws_lb" "rabbitmq-application-loadbalancer" {
  name               = var.application_loadbalancer_name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = [aws_security_group.rabbitmq_alb.id]           ###var.security_groups
  subnets            = aws_subnet.public_subnet.*.id                  ###var.subnets

  enable_deletion_protection = var.enable_deletion_protection
  idle_timeout = var.idle_timeout
  access_logs {
    bucket  = var.access_log_bucket
    prefix  = var.prefix
    enabled = var.enabled
  }

  tags = {
    Environment = var.env
  }

  depends_on = [aws_s3_bucket_policy.s3bucket_policy_rabbitmq]
}

#Target Group of RabbitMQ Application Loadbalancer
resource "aws_lb_target_group" "rabbitmq_target_group" {
  name     = var.target_group_name
  port     = var.instance_port      ##### Don't use protocol when target type is lambda
  protocol = var.instance_protocol  ##### Don't use protocol when target type is lambda
  vpc_id   = aws_vpc.test_vpc.id    #####var.vpc_id
  target_type = var.target_type_alb
  load_balancing_algorithm_type = var.load_balancing_algorithm_type
  health_check {
    enabled = true ## Indicates whether health checks are enabled. Defaults to true.
    path = var.healthcheck_path     ###"/index.html"
    port = "traffic-port"
    protocol = "HTTP"
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.timeout
    interval            = var.interval
  }
}

##RabbitMQ Application Loadbalancer listener for HTTP
resource "aws_lb_listener" "rabbitmq_alb_listener_front_end_HTTP" {
  load_balancer_arn = aws_lb.rabbitmq-application-loadbalancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = var.type[1]
    target_group_arn = aws_lb_target_group.rabbitmq_target_group.arn
     redirect {    ### Redirect HTTP to HTTPS
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

##RabbitMQ Application Loadbalancer listener for HTTPS
resource "aws_lb_listener" "rabbitmq_alb_listener_front_end_HTTPS" {
  load_balancer_arn = aws_lb.rabbitmq-application-loadbalancer.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = var.type[0]
    target_group_arn = aws_lb_target_group.rabbitmq_target_group.arn
  }
}

## EC2 Instance1 attachment to RabbitMQ Target Group
resource "aws_lb_target_group_attachment" "rabbitmq_ec2_instance1_attachment_to_tg" {
  target_group_arn = aws_lb_target_group.rabbitmq_target_group.arn
  target_id        = aws_instance.rabbitmq[0].id               #var.ec2_instance_id[0]
  port             = var.instance_port
}

## EC2 Instance2 attachment to RabbitMQ Target Group
resource "aws_lb_target_group_attachment" "rabbitmq_ec2_instance2_attachment_to_tg" {
  target_group_arn = aws_lb_target_group.rabbitmq_target_group.arn
  target_id        = aws_instance.rabbitmq[1].id
  port             = var.instance_port
}

## EC2 Instance3 attachment to RabbitMQ Target Group
resource "aws_lb_target_group_attachment" "rabbitmq_ec3_instance2_attachment_to_tg" {
  target_group_arn = aws_lb_target_group.rabbitmq_target_group.arn
  target_id        = aws_instance.rabbitmq[2].id
  port             = var.instance_port
}
