provider "alicloud" {
  region = "ap-southeast-1"
}

module "load_balance" {
  source = "../../"

  #data db_instance_classes
  db_instance_class = var.db_instance_class

  #data images
  most_recent      = true
  owners           = "system"
  image_name_regex = "^centos_6"

  #resource vpc
  vpc_cidr = "10.1.0.0/21"
  vpc_name = var.vpc_name

  #resource vswitch
  vswitch_cidrs       = ["10.1.2.0/24", "10.1.3.0/24"]
  vswitch_name_prefix = var.vswitch_name_prefix

  #resource security_group
  group_name = var.group_name

  #resource security_group_rule
  sgr_type        = "ingress"
  sgr_ip_protocol = "all"
  sgr_nic_type    = "intranet"
  sgr_policy      = "accept"
  sgr_port_range  = "-1/-1"
  sgr_priority    = 1
  sgr_cidr_ip     = "0.0.0.0/0"

  #resource alicloud_instance
  number_of_web_instances    = 2
  web_instance_name          = var.web_instance_name
  web_host_name              = var.web_host_name
  internet_charge_type       = "PayByTraffic"
  internet_max_bandwidth_out = var.internet_max_bandwidth_out
  instance_charge_type       = var.instance_charge_type
  system_category            = "cloud_efficiency"
  system_size                = var.system_size
  ecs_password               = var.ecs_password
  period                     = var.period
  period_unit                = var.period_unit
  instance_tags              = var.instance_tags

  #resource alicloud_instance
  number_of_app_instances = 2
  app_instance_name       = var.app_instance_name
  app_host_name           = var.app_host_name

  #resource "alicloud_slb" "intranet"
  slb_intranet_name         = var.slb_intranet_name
  slb_intranet_spec         = var.slb_intranet_spec
  slb_intranet_address_type = "intranet"

  #resource "alicloud_slb" "internet"
  slb_max_bandwidth         = var.slb_max_bandwidth
  slb_internet_name         = var.slb_internet_name
  slb_internet_spec         = var.slb_internet_spec
  slb_internet_address_type = "internet"

  #resource "alicloud_slb_listener"
  backend_port        = 8000
  frontend_port       = 80
  protocol            = "http"
  sticky_session      = "on"
  sticky_session_type = "insert"
  cookie_timeout      = 86400
  health_check        = "off"
  bandwidth           = 10

  #resource "db_instance"
  number_of_rds_instances = 2
  engine                  = "MySQL"
  engine_version          = "5.6"
  rds_name_prefix         = var.rds_name_prefix

  #resource "alicloud_db_account"
  rds_account_name_prefix = "tf_account_"
  rds_account_password    = var.rds_account_password

  #resource "alicloud_db_database" "default" {
  rds_database_name_prefix = "tf_testacc_db_"

  #resource "random_id" "default"
  this_module_name = "tf-terraform-alicloud-classic-load-balance"

  #resource "alicloud_oss_bucket" "default"
  bucket_name = "tf-testacc-bucket-220601-acl"
  bucket_acl  = "private"
}