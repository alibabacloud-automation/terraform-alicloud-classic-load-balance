output "this_module_name" {
  description = "The name of this module."
  value       = var.this_module_name
}

# Output VPC
output "this_vpc_id" {
  description = "The ID of the VPC."
  value       = var.vpc_id == "" ? join("", alicloud_vpc.vpc[*].id) : var.vpc_id
}

output "this_vswitch_ids" {
  description = "List ID of the VSwitches."
  value       = length(var.vswitch_ids) > 0 ? join(",", var.vswitch_ids) : join(",", alicloud_vswitch.vswitches[*].id)
}

# Output security group
output "this_security_group_id" {
  description = "The ID of the Security Group in the specified VPC."
  value       = alicloud_security_group.default.id
}

# Output the IDs of the ECS instances created
output "this_web_instance_ids" {
  description = "List ID of the web instances in the specified VPC."
  value       = join(",", alicloud_instance.web[*].id)
}

output "this_app_instance_ids" {
  description = "List ID of the application instances in the specified VPC."
  value       = join(",", alicloud_instance.app[*].id)
}

# SLB Instance
output "this_slb_intranet_id" {
  description = "The intranet SLB instance ID."
  value       = alicloud_slb_load_balancer.intranet.id
}

output "this_slb_intranet_ip" {
  description = "The intranet SLB ip address."
  value       = alicloud_slb_load_balancer.intranet.address
}
output "this_slb_internet_id" {
  description = "The internet SLB instance ID."
  value       = alicloud_slb_load_balancer.internet.id
}

output "this_slb_internet_ip" {
  description = "The internet SLB ip address."
  value       = alicloud_slb_load_balancer.internet.address
}

# RDS Master Resource
output "this_rds_master_id" {
  description = "The RDS master instance ID."
  value       = alicloud_db_instance.default[0].id
}

output "this_rds_master_account_id" {
  description = "The RDS Master account ID."
  value       = alicloud_rds_account.default[0].id
}

output "this_rds_master_account_name" {
  description = "The RDS master account name."
  value       = alicloud_rds_account.default[0].account_name
}

output "this_rds_master_account_password" {
  description = "The RDS master account name."
  value       = alicloud_rds_account.default[0].account_password
}
output "this_rds_master_database_id" {
  description = "The RDS master database id."
  value       = alicloud_db_database.default[0].id
}

output "this_rds_master_database_name" {
  description = "The RDS master database name."
  value       = alicloud_db_database.default[0].name
}

output "this_rds_master_database_connection" {
  description = "The RDS master database connection."
  value       = alicloud_db_instance.default[0].connection_string
}

# OSS Resource
output "this_oss_bucket" {
  description = "The OSS bucket ID."
  value       = alicloud_oss_bucket.default.id
}

# VPC outputs
output "this_vpc_name" {
  description = "The name of the VPC."
  value       = var.vpc_name == "" ? alicloud_vpc.vpc[0].vpc_name : var.vpc_name
}

output "this_vpc_cidr" {
  description = "The CIDR block of the VPC."
  value       = alicloud_vpc.vpc[0].cidr_block
}

output "this_vswitch_cidrs" {
  description = "The CIDR block of the VSwitches."
  value       = alicloud_vswitch.vswitches[*].cidr_block
}

# Security Group outputs
output "this_security_group_name" {
  description = "The name of the Security Group."
  value       = alicloud_security_group.default.name
}

# Ecs instance outputs
output "this_web_image_id" {
  description = "The image ID of the web instance."
  value       = alicloud_instance.web[0].image_id
}

output "this_app_image_id" {
  description = "The image ID of the application instance."
  value       = alicloud_instance.app[0].image_id
}

output "this_web_instance_type" {
  description = "The instance type of the web instance."
  value       = alicloud_instance.web[0].instance_type
}

output "this_app_instance_type" {
  description = "The instance type of the application instance."
  value       = alicloud_instance.app[0].instance_type

}

output "this_web_system_category" {
  description = "The system category of the web instance."
  value       = alicloud_instance.app[0].system_disk_category
}

output "this_app_system_category" {
  description = "The system category of the application instance."
  value       = alicloud_instance.app[0].system_disk_category
}

output "this_web_system_size" {
  description = "The system size of the web instance."
  value       = alicloud_instance.app[0].system_disk_size
}

output "this_app_system_size" {
  description = "The system size of the application instance."
  value       = alicloud_instance.app[0].system_disk_size
}

output "this_web_instance_name" {
  description = "The instance name of the web instance."
  value       = alicloud_instance.web[0].instance_name
}

output "this_app_instance_name" {
  description = "The instance name of the application instance."
  value       = alicloud_instance.app[0].instance_name
}

output "this_web_host_name" {
  description = "The host name of the web instance."
  value       = alicloud_instance.web[0].host_name
}

output "this_app_host_name" {
  description = "The host name of the application instance."
  value       = alicloud_instance.app[0].host_name
}

output "this_web_ecs_password" {
  description = "The password of the web instance."
  value       = alicloud_instance.web[0].password
}

output "this_app_ecs_password" {
  description = "The password of the application instance."
  value       = alicloud_instance.web[0].password
}

output "this_web_internet_charge_type" {
  description = "The internet charge type of the web instance."
  value       = alicloud_instance.web[0].internet_charge_type
}

output "this_app_internet_charge_type" {
  description = "The internet charge type of the application instance."
  value       = alicloud_instance.web[0].internet_charge_type
}

output "this_web_internet_max_bandwidth_out" {
  description = "The internet max bandwidth out of the web instance."
  value       = alicloud_instance.web[0].internet_max_bandwidth_out
}

output "this_app_internet_max_bandwidth_out" {
  description = "The internet max bandwidth out of the application instance."
  value       = alicloud_instance.web[0].internet_max_bandwidth_out
}

output "this_web_instance_charge_type" {
  description = "The instance charge type of the web instance."
  value       = alicloud_instance.web[0].instance_charge_type
}

output "this_app_instance_charge_type" {
  description = "The instance charge type of the application instance."
  value       = alicloud_instance.web[0].instance_charge_type
}

output "this_web_instance_tags" {
  description = "The instance tags of the web instance."
  value       = alicloud_instance.web[0].tags
}

output "this_app_instance_tags" {
  description = "The instance tags of the application instance."
  value       = alicloud_instance.web[0].tags
}

output "number_of_web_instances" {
  description = "The number of web instances."
  value       = length(alicloud_instance.web)
}

output "number_of_app_instances" {
  description = "The number of application instances."
  value       = length(alicloud_instance.app)
}

# Rds outputs
output "number_of_rds_instances" {
  description = "The number of RDS instances."
  value       = length(alicloud_db_instance.default)
}

output "this_engine" {
  description = "The engine of the RDS instance."
  value       = alicloud_db_instance.default[0].engine
}

output "this_engine_version" {
  description = "The engine version of the RDS instance."
  value       = alicloud_db_instance.default[0].engine_version
}

output "this_db_instance_type" {
  description = "The instance type of the RDS instance."
  value       = alicloud_db_instance.default[0].instance_type
}

# SLB outputs
output "this_slb_intranet_name" {
  description = "The intranet SLB instance name."
  value       = alicloud_slb_load_balancer.intranet.load_balancer_name
}

output "this_slb_internet_name" {
  description = "The internet SLB instance name."
  value       = alicloud_slb_load_balancer.internet.load_balancer_name
}

# OSS outputs
output "this_bucket_name" {
  description = "The OSS bucket name."
  value       = alicloud_oss_bucket.default.id
}

output "this_bucket_acl" {
  description = "The OSS bucket ACL."
  value       = alicloud_oss_bucket_acl.default.acl
}

output "web_url" {
  description = "Output the welcome access url."
  value       = join("", [alicloud_slb_load_balancer.internet.address, "/welcome.html"])
}
