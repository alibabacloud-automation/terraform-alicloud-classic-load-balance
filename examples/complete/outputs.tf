output "this_module_name" {
  value = module.load_balance.this_module_name
}

output "this_rds_master_database_id" {
  value = module.load_balance.this_rds_master_database_id
}

output "number_of_rds_instances" {
  value = module.load_balance.number_of_rds_instances
}

output "this_rds_master_id" {
  value = module.load_balance.this_rds_master_id
}

output "this_rds_master_database_connection" {
  value = module.load_balance.this_rds_master_database_connection
}

output "this_oss_bucket" {
  value = module.load_balance.this_oss_bucket
}

output "this_vpc_name" {
  value = module.load_balance.this_vpc_name
}

output "this_vpc_cidr" {
  value = module.load_balance.this_vpc_cidr
}

output "this_vswitch_cidrs" {
  value = module.load_balance.this_vswitch_cidrs
}

# Security Group outputs
output "this_security_group_name" {
  value = module.load_balance.this_security_group_name
}

# Ecs instance outputs
output "this_web_image_id" {
  value = module.load_balance.this_web_image_id
}

output "this_app_image_id" {
  value = module.load_balance.this_app_image_id
}

output "this_web_instance_type" {
  value = module.load_balance.this_web_instance_type
}

output "this_app_instance_type" {
  value = module.load_balance.this_app_instance_type
}

output "this_web_system_category" {
  value = module.load_balance.this_web_system_category
}

output "this_app_system_category" {
  value = module.load_balance.this_app_system_category
}

output "this_web_system_size" {
  value = module.load_balance.this_web_system_size
}

output "this_app_system_size" {
  value = module.load_balance.this_app_system_size
}

output "this_web_instance_name" {
  value = module.load_balance.this_web_instance_name
}

output "this_app_instance_name" {
  value = module.load_balance.this_app_instance_name
}

output "this_web_host_name" {
  value = module.load_balance.this_web_host_name
}

output "this_app_host_name" {
  value = module.load_balance.this_app_host_name
}