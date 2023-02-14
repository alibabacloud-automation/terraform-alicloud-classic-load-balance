//# common variables
variable "region" {
  description = "(Deprecated from version 2.7.0) The region used to launch this module resources."
  type        = string
  default     = ""
}
variable "availability_zones" {
  description = "The available zone to launch ecs instance and other resources."
  type        = list(string)
  default     = []
}

variable "number_format" {
  description = "The number format used to output."
  type        = string
  default     = "%02d"
}

variable "this_module_name" {
  description = "The name of this module"
  type        = string
  default     = ""
}

# Image variables
variable "image_name_regex" {
  description = "The ECS image's name regex used to fetch specified image."
  type        = string
  default     = "^centos_6"
}

# Instance typs variables
variable "web_instance_cpu" {
  description = "CPU core count is used to fetch instance types for launching web instances."
  type        = number
  default     = 2
}

variable "web_instance_memory" {
  description = "Memory size used to fetch instance types for launching web instances."
  type        = number
  default     = 4
}

variable "app_instance_cpu" {
  description = "CPU core count is used to fetch instance types for launching app instances."
  type        = number
  default     = 2
}

variable "app_instance_memory" {
  description = "Memory size used to fetch instance types for launching app instances."
  type        = number
  default     = 4
}

# VPC variables
variable "vpc_name" {
  description = "The vpc name used to create a new vpc when 'vpc_id' is not specified. Default to variable `this_module_name`"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "A existing vpc id used to create several vswitches and other resources."
  type        = string
  default     = ""
}

variable "vpc_cidr" {
  description = "The cidr block used to launch a new vpc when 'vpc_id' is not specified."
  type        = string
  default     = "10.1.0.0/21"
}

# VSwitch variables
variable "vswitch_name_prefix" {
  description = "The vswitch name prefix used to create several new vswitches. Default to variable `this_module_name`"
  type        = string
  default     = ""
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
  type        = string
  default     = ""
}

# Ecs instance variables
variable "image_id" {
  description = "The image id used to launch one or more ecs instances. Default from images datasource."
  type        = string
  default     = ""
}

variable "web_instance_type" {
  description = "The instance type used to launch one or more web instances. Default from instance typs datasource."
  type        = string
  default     = ""
}

variable "app_instance_type" {
  description = "The instance type used to launch one or more web instances. Default from instance typs datasource."
  type        = string
  default     = ""
}

variable "system_category" {
  description = "The system disk category used to launch one or more ecs instances."
  type        = string
  default     = "cloud_efficiency"
}

variable "system_size" {
  description = "The system disk size used to launch one or more ecs instances."
  type        = string
  default     = "40"
}

variable "web_instance_name" {
  description = "The instance name used to mark web instances."
  type        = string
  default     = ""
}

variable "web_host_name" {
  description = "The instance host name used to configure web instances."
  type        = string
  default     = ""
}

variable "ecs_password" {
  description = "The password of instance."
  type        = string
  default     = ""
}

variable "internet_charge_type" {
  description = "The internet charge type of instance. Choices are 'PayByTraffic' and 'PayByBandwidth'."
  type        = string
  default     = "PayByTraffic"
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

variable "number_of_web_instances" {
  description = "The number of launching web instances one time."
  type        = number
  default     = 2
}

variable "app_instance_name" {
  description = "The instance name used to mark app instances."
  type        = string
  default     = ""
}

variable "app_host_name" {
  description = "The instance host name used to configure app instances."
  type        = string
  default     = ""
}

variable "number_of_app_instances" {
  description = "The number of launching app instances one time."
  type        = number
  default     = 2
}

// Rds variables
variable "number_of_rds_instances" {
  description = "The number of launching rds instances one time."
  type        = number
  default     = 2
}

variable "rds_name_prefix" {
  description = "The rds instance name prefix."
  type        = string
  default     = ""
}

variable "engine" {
  description = "The rds instance engine."
  type        = string
  default     = "MySQL"
}

variable "engine_version" {
  description = "The rds instance engine version."
  type        = string
  default     = "5.6"
}

variable "db_instance_class" {
  description = "The rds instance type. If not set, the data source `alicloud_db_instance_classes` will return random class."
  type        = string
  default     = ""
}

variable "db_instance_storage" {
  description = "The rds instance storage. If not set, the data source `alicloud_db_instance_classes` will return a min storage."
  type        = number
  default     = 10
}

variable "rds_account_name_prefix" {
  description = "The rds account name prefix used to create two new account in the RDS instance."
  type        = string
  default     = ""
}

variable "rds_account_password" {
  description = "The rds account password."
  type        = string
  default     = ""
}

variable "rds_database_name_prefix" {
  description = "The rds database name prefix used to create two new database in the RDS instance."
  type        = string
  default     = ""
}

// SLB variables
variable "slb_intranet_name" {
  description = "The SLB intranet instance name used to create a new Intraner SLB instance. Default to `this_module_name`"
  type        = string
  default     = ""
}

variable "slb_intranet_address_type" {
  description = "The network type of the SLB instance"
  type        = string
  default     = "intranet"
}

variable "slb_internet_name" {
  description = "The SLB internet instance name used to create a new Internet SLB instance. Default to `this_module_name`"
  type        = string
  default     = ""
}

variable "slb_internet_address_type" {
  description = "The network type of the SLB instance"
  type        = string
  default     = "internet"
}

variable "slb_max_bandwidth" {
  description = "The maximum internet out bandwidth of slb instance."
  type        = number
  default     = 10
}
variable "slb_intranet_spec" {
  description = "The SLB intranet instance specification used to create a new Intraner SLB instance. Default to `slb.s1.small`"
  type        = string
  default     = "slb.s1.small"
}
variable "slb_internet_spec" {
  description = "The SLB internet instance specification used to create a new Intraner SLB instance. Default to `slb.s1.small`"
  type        = string
  default     = "slb.s1.small"
}

// OSS variables
variable "bucket_name" {
  description = "The OSS bucket name. If not set, this module will generate a random name with prefix `this_module_name`"
  type        = string
  default     = ""
}

variable "bucket_acl" {
  description = "The OSS bucket ACL."
  type        = string
  default     = "private"
}

// alicloud_security_group_rule variables
variable "sgr_type" {
  description = "The type of rule being created"
  type        = string
  default     = "ingress"
}

variable "sgr_ip_protocol" {
  description = "The protocol. Can be tcp, udp, icmp, gre or all"
  type        = string
  default     = "all"
}

variable "sgr_nic_type" {
  description = "Network type, can be either internet or intranet, the default value is internet"
  type        = string
  default     = "intranet"
}

variable "sgr_policy" {
  description = "Authorization policy, can be either accept or drop, the default value is accept"
  type        = string
  default     = "accept"
}
variable "sgr_port_range" {
  description = "The range of port numbers relevant to the IP protocol"
  type        = string
  default     = "-1/-1"
}
variable "sgr_priority" {
  description = "Authorization policy priority, with parameter values: 1-100, default value: 1"
  type        = number
  default     = 1
}

variable "sgr_cidr_ip" {
  description = "The target IP address range. The default value is 0.0.0.0/0"
  type        = string
  default     = ""
}

// alicloud_slb_listener variables
variable "backend_port" {
  description = "Port used by the Server Load Balancer instance backend"
  type        = number
  default     = 8000
}

variable "frontend_port" {
  description = "Port used by the Server Load Balancer instance frontend"
  type        = number
  default     = 1
}

variable "protocol" {
  description = "The protocol to listen on. Valid values are [http, https, tcp, udp]"
  type        = string
  default     = "http"
}

variable "sticky_session" {
  description = "Whether to enable session persistence, Valid values are on and off"
  type        = string
  default     = "on"
}

variable "sticky_session_type" {
  description = "Mode for handling the cookie"
  type        = string
  default     = "insert"
}

variable "cookie_timeout" {
  description = "Cookie timeout"
  type        = number
  default     = 86400
}

variable "health_check" {
  description = "Whether to enable health check."
  type        = string
  default     = "off"
}

variable "bandwidth" {
  description = "Bandwidth peak of Listener. For the public network instance charged per traffic consumed"
  type        = number
  default     = 10
}

// alicloud_images variables
variable "owners" {
  description = "Filter results by a specific image owner"
  type        = string
  default     = "system"
}

variable "most_recent" {
  description = "If more than one result are returned, select the most recent one."
  type        = bool
  default     = true
}