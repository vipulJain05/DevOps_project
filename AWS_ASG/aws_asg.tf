module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"

  # Autoscaling group
  name = "cityMall_ASG_Group"

  min_size                  = var.ASG_MIN_SIZE
  max_size                  = var.ASG_MAX_SIZE
  desired_capacity          = var.ASG_DESIRED_CAPACITY
  health_check_type         = var.HEALTH_CHECK
  vpc_zone_identifier       = var.VPC_ZONE_IDENTIFIER

  # Launch template
  launch_template_name        = var.LAUNCH_TEMPLATE_NAME
  update_default_version      = true
  instance_type     = var.AWS_INSTANCE_TYPE
  ebs_optimized     = true
  enable_monitoring = true

  # IAM role & instance profile
  create_iam_instance_profile = true
  iam_role_name               = var.IAM_ROLE_NAME
  iam_role_path               = "/ec2/"
  iam_role_description        = "Autoscaling group role"
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  block_device_mappings = [
    {
      # Root volume
      device_name = "/dev/xvda"
      no_device   = 0
      ebs = {
        delete_on_termination = var.EBS_DELETE_ON_TERMINATION
        encrypted             = true
        volume_size           = var.EBS_VOLUME_SIZE
        volume_type           = "gp2"
      }
    }
  ]

  credit_specification = {
    cpu_credits = "standard"
  }

  network_interfaces = [
    {
      delete_on_termination = true
      description           = "eth0"
      device_index          = 0
      security_groups       = var.ENI_SECURITY_GROUPS
    }
  ]
}