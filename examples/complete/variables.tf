# variables for alicloud_vpc
variable "vpc_name" {
  description = "The vpc name used to create a new vpc when 'vpc_id' is not specified. Default to variable `this_module_name`"
  type        = string
  default     = "tf-testacc-vpc-name"
}

# variables for alicloud_vswitch
variable "vswitch_name_prefix" {
  description = "The vswitch name prefix used to create several new vswitches. Default to variable `this_module_name`"
  type        = string
  default     = "tf-testacc-accvswitch-name-prefixt"
}

# variables for alicloud_security_group
variable "group_name" {
  description = "The security group name"
  type        = string
  default     = "tf-testacc-group-name"
}

# variables for alicloud_instance
variable "web_instance_name" {
  description = "The instance name used to mark web instances."
  type        = string
  default     = "tf-testacc-web-tier"
}

variable "web_host_name" {
  description = "The instance host name used to configure web instances."
  type        = string
  default     = "tf-testacc-web-tier"
}

variable "internet_max_bandwidth_out" {
  description = "The maximum internet out bandwidth of instance."
  type        = number
  default     = 0
}

variable "instance_charge_type" {
  description = "The charge type of instance. Choices are 'PostPaid' and 'PrePaid'."
  type        = string
  default     = "PostPaid"
}

variable "ecs_password" {
  description = "The password of instance."
  type        = string
  default     = "YourPassword123!"
}

variable "period" {
  description = "The period of instance when instance charge type is 'PrePaid'."
  type        = number
  default     = 1
}

variable "period_unit" {
  description = "The period unit of instance when instance charge type is 'PrePaid'."
  type        = string
  default     = "Month"
}

variable "instance_tags" {
  description = "Used to mark specified ecs instance."
  type        = map(string)

  default = {
    created_by   = "Terraform"
    created_from = "module-tf-alicloud-ecs-instance"
  }
}

variable "app_instance_name" {
  description = "The instance name used to mark app instances."
  type        = string
  default     = "tf-testacc-app-tier"
}

variable "app_host_name" {
  description = "The instance host name used to configure app instances."
  type        = string
  default     = "tf-testacc-app-tier"
}

variable "system_size" {
  description = "The system disk size used to launch one or more ecs instances."
  type        = string
  default     = "40"
}

# variables for alicloud_db_instance_classes
variable "db_instance_class" {
  description = "The rds instance type. If not set, the data source `alicloud_db_instance_classes` will return random class."
  type        = string
  default     = ""
}

# variables for alicloud_slb
variable "slb_intranet_name" {
  description = "The SLB intranet instance name used to create a new Intraner SLB instance. Default to `this_module_name`"
  type        = string
  default     = "tf_testacc_slb_name"
}

variable "slb_intranet_spec" {
  description = "The SLB intranet instance specification used to create a new Intraner SLB instance. Default to `slb.s1.small`"
  type        = string
  default     = "slb.s1.small"
}

variable "slb_max_bandwidth" {
  description = "The maximum internet out bandwidth of slb instance."
  type        = number
  default     = 10
}

variable "slb_internet_name" {
  description = "The SLB internet instance name used to create a new Internet SLB instance. Default to `this_module_name`"
  type        = string
  default     = "tf_acctest_internet"
}

variable "slb_internet_spec" {
  description = "The SLB internet instance specification used to create a new Intraner SLB instance. Default to `slb.s1.small`"
  type        = string
  default     = "slb.s1.small"
}

# variables for alicloud_db_instance
variable "rds_name_prefix" {
  description = "The rds instance name prefix."
  type        = string
  default     = "tf_testacc_rds"
}

variable "rds_account_password" {
  description = "The rds account password."
  type        = string
  default     = "YourPassword123!"
}