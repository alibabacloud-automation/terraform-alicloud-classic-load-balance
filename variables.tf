variable "availability_zones" {
  description = "The available zone to launch ecs instance and other resources."
  type        = list(string)
  default     = []
}

variable "number_format" {
  description = "The number format used to output."
  default     = "%02d"
  type        = string
}

variable "this_module_name" {
  default     = "terraform-alicloud-classic-load-balance"
  description = "The name of this module."
  type        = string
}

# Image variables
variable "image_name_regex" {
  description = "The ECS image's name regex used to fetch specified image."
  default     = "^ubuntu_18.*64"
  type        = string
}

# Instance typs variables
variable "web_instance_cpu" {
  description = "CPU core count is used to fetch instance types for launching web instances."
  default     = 2
  type        = number
}

variable "web_instance_memory" {
  description = "Memory size used to fetch instance types for launching web instances."
  default     = 4
  type        = number
}

variable "app_instance_cpu" {
  description = "CPU core count is used to fetch instance types for launching app instances."
  default     = 2
  type        = number
}

variable "app_instance_memory" {
  description = "Memory size used to fetch instance types for launching app instances."
  default     = 4
  type        = number
}

# VPC variables
variable "vpc_name" {
  description = "The vpc name used to create a new vpc when 'vpc_id' is not specified. Default to variable `this_module_name`"
  default     = ""
  type        = string
}

variable "vpc_id" {
  description = "A existing vpc id used to create several vswitches and other resources."
  default     = ""
  type        = string
}

variable "vpc_cidr" {
  description = "The cidr block used to launch a new vpc when 'vpc_id' is not specified."
  default     = "10.1.0.0/21"
  type        = string
}

# VSwitch variables
variable "vswitch_name_prefix" {
  description = "The vswitch name prefix used to create several new vswitches. Default to variable `this_module_name`"
  default     = ""
  type        = string
}

variable "vswitch_ids" {
  description = "List existing vswitches id used to create ECS and RDS instance."
  type        = list(string)
  default     = []
}

variable "vswitch_cidrs" {
  description = "List of cidr blocks used to create several new vswitches when variable `vswitch_ids` is not specified."
  type        = list(string)
  default     = ["10.1.2.0/24", "10.1.3.0/24"]
}

# Security Group variables
variable "group_name" {
  description = "The security group name. Default to variable `this_module_name`."
  default     = ""
  type        = string
}

# Ecs instance variables
variable "image_id" {
  description = "The image id used to launch one or more ecs instances. Default from images datasource."
  default     = ""
  type        = string
}

variable "web_instance_type" {
  description = "The instance type used to launch one or more web instances. Default from instance typs datasource."
  default     = ""
  type        = string
}

variable "system_category" {
  description = "The system disk category used to launch one or more ecs instances."
  default     = "cloud_efficiency"
  type        = string
}

variable "system_size" {
  description = "The system disk size used to launch one or more ecs instances."
  default     = "40"
  type        = string
}

variable "web_instance_name" {
  description = "The instance name used to mark web instances."
  default     = "tf-web-tier"
  type        = string
}

variable "web_host_name" {
  description = "The instance host name used to configure web instances."
  default     = "tf-web-tier"
  type        = string
}

variable "ecs_password" {
  description = "The password of instance."
  default     = "Abc12345"
  type        = string
}

variable "internet_charge_type" {
  description = "The internet charge type of instance. Choices are 'PayByTraffic' and 'PayByBandwidth'."
  default     = "PayByTraffic"
  type        = string
}

variable "internet_max_bandwidth_out" {
  description = "The maximum internet out bandwidth of instance."
  default     = 0
  type        = number
}

variable "instance_charge_type" {
  description = "The charge type of instance. Choices are 'PostPaid' and 'PrePaid'."
  default     = "PostPaid"
  type        = string
}

variable "period" {
  description = "The period of instance when instance charge type is 'PrePaid'."
  default     = 1
  type        = number
}

variable "period_unit" {
  description = "The period unit of instance when instance charge type is 'PrePaid'."
  default     = "Month"
  type        = string
}

variable "instance_tags" {
  description = "Used to mark specified ecs instance."
  type        = map(string)

  default = {
    created_by   = "Terraform"
    created_from = "module-tf-alicloud-ecs-instance"
  }
}

variable "number_of_web_instances" {
  description = "The number of launching web instances one time."
  default     = 2
  type        = number
}

variable "app_instance_name" {
  description = "The instance name used to mark app instances."
  default     = "tf-app-tier"
  type        = string
}

variable "app_host_name" {
  description = "The instance host name used to configure app instances."
  default     = "tf-app-tier"
  type        = string
}

variable "number_of_app_instances" {
  description = "The number of launching app instances one time."
  default     = 2
  type        = number
}

# Rds variables
variable "number_of_rds_instances" {
  description = "The number of launching rds instances one time."
  default     = 2
  type        = number
}

variable "rds_name_prefix" {
  description = "The rds instance name prefix."
  default     = "tf_rds"
  type        = string
}

variable "engine" {
  description = "The rds instance engine."
  default     = "MySQL"
  type        = string
}

variable "engine_version" {
  description = "The rds instance engine version."
  default     = "5.6"
  type        = string
}

variable "db_instance_class" {
  description = "The rds instance type. If not set, the data source `alicloud_db_instance_classes` will return random class."
  default     = ""
  type        = string
}

variable "db_instance_storage" {
  description = "The rds instance storage. If not set, the data source `alicloud_db_instance_classes` will return a min storage."
  default     = 10
  type        = number
}

variable "rds_account_name_prefix" {
  description = "The rds account name prefix used to create two new account in the RDS instance."
  default     = "tf_account_"
  type        = string
}

variable "rds_account_password" {
  description = "The rds account password."
  default     = "Abc12345"
  type        = string
}

variable "rds_database_name_prefix" {
  description = "The rds database name prefix used to create two new database in the RDS instance."
  default     = "tf_db_"
  type        = string
}

# SLB variables
variable "slb_intranet_name" {
  description = "The SLB intranet instance name used to create a new Intraner SLB instance. Default to `this_module_name`"
  default     = ""
  type        = string
}

variable "slb_internet_name" {
  description = "The SLB internet instance name used to create a new Internet SLB instance. Default to `this_module_name`"
  default     = ""
  type        = string
}

variable "slb_max_bandwidth" {
  description = "The maximum internet out bandwidth of slb instance."
  default     = 10
  type        = number
}
variable "slb_intranet_spec" {
  description = "The SLB intranet instance specification used to create a new Intraner SLB instance. Default to `slb.s1.small`"
  default     = "slb.s1.small"
  type        = string
}
variable "slb_internet_spec" {
  description = "The SLB internet instance specification used to create a new Intraner SLB instance. Default to `slb.s1.small`"
  default     = "slb.s1.small"
  type        = string
}

# OSS variables
variable "bucket_name" {
  description = "The OSS bucket name. If not set, this module will generate a random name with prefix `this_module_name`"
  default     = ""
  type        = string
}

variable "bucket_acl" {
  description = "The OSS bucket ACL."
  default     = "private"
  type        = string
}

