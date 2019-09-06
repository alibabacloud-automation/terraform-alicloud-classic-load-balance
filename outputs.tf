// Output VPC
output "vpc_id" {
  description = "The ID of the VPC."
  value       = var.vpc_id == "" ? join("", alicloud_vpc.vpc.*.id) : var.vpc_id
}

output "vswitch_ids" {
  description = "List ID of the VSwitches."
  value       = length(var.vswitch_ids) > 0 ? join(",", var.vswitch_ids) : join(",", alicloud_vswitch.vswitches.*.id)
}

// Output security group
output "security_group_id" {
  description = "The ID of the Security Group in the specified VPC."
  value       = alicloud_security_group.default.id
}

// Output the IDs of the ECS instances created
output "web_instance_ids" {
  description = "List ID of the web instances in the specified VPC."
  value       = join(",", alicloud_instance.web.*.id)
}

output "app_instance_ids" {
  description = "List ID of the application instances in the specified VPC."
  value       = join(",", alicloud_instance.app.*.id)
}

// SLB Instance
output "slb_intranet_id" {
  description = "The intranet SLB instance ID."
  value       = alicloud_slb.intranet.id
}

output "slb_internet_id" {
  description = "The internet SLB instance ID."
  value       = alicloud_slb.internet.id
}

// RDS Resource
output "rds_master_id" {
  description = "The RDS master instance ID."
  value       = join(",", alicloud_db_instance.default.*.id)
}

output "rds_account_id" {
  description = "The RDS account ID."
  value       = join(",", alicloud_db_account.default.*.id)
}

output "rds_database_id" {
  description = "The RDS database ID."
  value       = join(",", alicloud_db_database.default.*.id)
}

// OSS Resource
output "oss_bucket" {
  description = "The OSS bucket ID."
  value       = alicloud_oss_bucket.default.id
}

