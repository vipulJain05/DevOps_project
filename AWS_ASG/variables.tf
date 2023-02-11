variable "ASG_MIN_SIZE" {
    description = "The minimum size of the autoscaling group"
    type        = number
    default     = 1
}

variable "ASG_MAX_SIZE" {
    description = "The maximum size of the autoscaling group"
    type        = number
    default     = 5
}

variable "ASG_DESIRED_CAPACITY" {
    description = "The number of Amazon EC2 instances that should be running in the autoscaling group"
    type        = number
    default     = 2
}

variable "HEALTH_CHECK" {
    description = "EC2 or ELB. Controls how health checking is done"
    type        = string
    default     = "EC2"  
}

variable "VPC_ZONE_IDENTIFIER" {
    description = "A list of subnet IDs to launch resources in"
    type        = list(string)
}

variable "LAUNCH_TEMPLATE_NAME" {
    description = "The name of the launch template" 
    type        = string
    default     = "citymall_asg"
}

variable "AWS_INSTANCE_TYPE" {
    description = "The type of the instance"
    type        = string
    default     = "t3.micro"
}

variable "IAM_ROLE_NAME" {
    description = "Name to use on IAM role created"
    type        = string
    default     = "CITYMALL_ASG_ROLE"
}

variable "EBS_DELETE_ON_TERMINATION" {
    description = "delete EBS storage on instance termination or not"
    type        = bool
    default     = true
}

variable "EBS_VOLUME_SIZE" {
    description = "Size of EBS volume"
    type        = number
    default     = 8
}

variable "ENI_SECURITY_GROUPS" {
    description = "ENI security group"
    type        = list(string)
}