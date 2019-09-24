output "this_module_name" {
  value = var.this_module_name
}

// Output VPC
output "this_vpc_id" {
  description = "The ID of the VPC."
  value       = var.vpc_id == "" ? join("", alicloud_vpc.vpc.*.id) : var.vpc_id
}

output "this_vswitch_ids" {
  description = "List ID of the VSwitches."
  value       = length(var.vswitch_ids) > 0 ? join(",", var.vswitch_ids) : join(",", alicloud_vswitch.vswitches.*.id)
}

// Output security group
output "this_security_group_id" {
  description = "The ID of the Security Group in the specified VPC."
  value       = alicloud_security_group.default.id
}

// Output the IDs of the ECS instances created
output "this_web_instance_ids" {
  description = "List ID of the web instances in the specified VPC."
  value       = join(",", alicloud_instance.web.*.id)
}

output "this_app_instance_ids" {
  description = "List ID of the application instances in the specified VPC."
  value       = join(",", alicloud_instance.app.*.id)
}

// SLB Instance
output "this_slb_intranet_id" {
  description = "The intranet SLB instance ID."
  value       = alicloud_slb.intranet.id
}

output "this_slb_intranet_ip" {
  description = "The intranet SLB ip address."
  value       = alicloud_slb.intranet.address
}
output "this_slb_internet_id" {
  description = "The internet SLB instance ID."
  value       = alicloud_slb.internet.id
}

output "this_slb_internet_ip" {
  description = "The internet SLB ip address."
  value       = alicloud_slb.internet.address
}

// RDS Master Resource
output "this_rds_master_id" {
  description = "The RDS master instance ID."
  value       = alicloud_db_instance.default.0.id
}

output "this_rds_master_account_id" {
  description = "The RDS Master account ID."
  value       = alicloud_db_account.default.0.id
}

output "this_rds_master_account_name" {
  description = "The RDS master account name."
  value       = alicloud_db_account.default.0.name
}

output "this_rds_master_account_password" {
  description = "The RDS master account name."
  value       = alicloud_db_account.default.0.password
}
output "this_rds_master_database_id" {
  description = "The RDS master database id."
  value       = alicloud_db_database.default.0.id
}

output "this_rds_master_database_name" {
  description = "The RDS master database name."
  value       = alicloud_db_database.default.0.name
}

output "this_rds_master_database_connection" {
  description = "The RDS master database connection."
  value       = alicloud_db_instance.default.0.connection_string
}

// OSS Resource
output "this_oss_bucket" {
  description = "The OSS bucket ID."
  value       = alicloud_oss_bucket.default.id
}

# VPC outputs
output "this_vpc_name" {
  value = var.vpc_name == "" ? alicloud_vpc.vpc.0.name : var.vpc_name
}

output "this_vpc_cidr" {
  value = alicloud_vpc.vpc.0.cidr_block
}

output "this_vswitch_cidrs" {
  value = alicloud_vswitch.vswitches.*.cidr_block
}

# Security Group outputs
output "this_security_group_name" {
  value = alicloud_security_group.default.name
}

# Ecs instance outputs
output "this_web_image_id" {
  value = alicloud_instance.web.0.image_id
}

output "this_app_image_id" {
  value = alicloud_instance.app.0.image_id
}

output "this_web_instance_type" {
  value = alicloud_instance.web.0.instance_type
}

output "this_app_instance_type" {
  value = alicloud_instance.app.0.instance_type

}

output "this_web_system_category" {
  value = alicloud_instance.app.0.system_disk_category
}

output "this_app_system_category" {
  value = alicloud_instance.app.0.system_disk_category
}

output "this_web_system_size" {
  value = alicloud_instance.app.0.system_disk_size
}

output "this_app_system_size" {
  value = alicloud_instance.app.0.system_disk_size
}

output "this_web_instance_name" {
  value = alicloud_instance.web.0.instance_name
}

output "this_app_instance_name" {
  value = alicloud_instance.app.0.instance_name
}

output "this_web_host_name" {
  value = alicloud_instance.web.0.host_name
}

output "this_app_host_name" {
  value = alicloud_instance.app.0.host_name
}

output "this_web_ecs_password" {
  value = alicloud_instance.web.0.password
}

output "this_app_ecs_password" {
  value = alicloud_instance.web.0.password
}

output "this_web_internet_charge_type" {
  value = alicloud_instance.web.0.internet_charge_type
}

output "this_app_internet_charge_type" {
  value = alicloud_instance.web.0.internet_charge_type
}

output "this_web_internet_max_bandwidth_out" {
  value = alicloud_instance.web.0.internet_max_bandwidth_out
}

output "this_app_internet_max_bandwidth_out" {
  value = alicloud_instance.web.0.internet_max_bandwidth_out
}

output "this_web_instance_charge_type" {
  value = alicloud_instance.web.0.instance_charge_type
}

output "this_app_instance_charge_type" {
  value = alicloud_instance.web.0.instance_charge_type
}

output "this_web_instance_tags" {
  value = alicloud_instance.web.0.tags
}

output "this_app_instance_tags" {
  value = alicloud_instance.web.0.tags
}

output "number_of_web_instances" {
  value = length(alicloud_instance.web)
}

output "number_of_app_instances" {
  value = length(alicloud_instance.app)
}

// Rds outputs
output "number_of_rds_instances" {
  value = length(alicloud_db_instance.default)
}

output "this_engine" {
  value = alicloud_db_instance.default.0.engine
}

output "this_engine_version" {
  value = alicloud_db_instance.default.0.engine_version
}

output "this_db_instance_type" {
  value = alicloud_db_instance.default.0.instance_type
}

// SLB outputs
output "this_slb_intranet_name" {
  value = alicloud_slb.intranet.name
}

output "this_slb_internet_name" {
  value = alicloud_slb.internet.name
}

// OSS outputs
output "this_bucket_name" {
  value = alicloud_oss_bucket.default.id
}

output "this_bucket_acl" {
  value = alicloud_oss_bucket.default.acl
}

output "web_url" {
  description = "Output the welcome access url."
  value       = join("", [alicloud_slb.internet.address, "/welcome.html"])
}