// Images data source for image_id
data "alicloud_images" "default" {
  most_recent = true
  owners      = "system"
  name_regex  = var.image_name_regex
}

// Instance_types data source for instance_type
data "alicloud_instance_types" "default" {
  cpu_core_count = var.cpu_core_count
  memory_size    = var.memory_size
}

// Zones data source for availability_zone
data "alicloud_zones" "default" {
  available_instance_type     = data.alicloud_instance_types.default.instance_types[0].id
  available_resource_creation = "Rds"
}

// If there is not specifying vpc_id, the module will launch a new vpc
resource "alicloud_vpc" "vpc" {
  count      = var.vpc_id == "" ? 1 : 0
  cidr_block = var.vpc_cidr
  name       = var.vpc_name == "" ? var.resource_group_name : var.vpc_name
}

// According to the vswitch cidr blocks to launch several vswitches
resource "alicloud_vswitch" "vswitches" {
  count             = length(var.vswitch_ids) > 0 ? 0 : length(var.vswitch_cidrs)
  vpc_id            = var.vpc_id == "" ? join("", alicloud_vpc.vpc.*.id) : var.vpc_id
  cidr_block        = var.vswitch_cidrs[count.index]
  availability_zone = data.alicloud_zones.default.zones[count.index]["id"]
  name = var.vswitch_name_prefix == "" ? format(
    "%s-%s",
    var.resource_group_name,
    format(var.number_format, count.index + 1),
    ) : format(
    "%s-%s",
    var.vswitch_name_prefix,
    format(var.number_format, count.index + 1),
  )
}

// Security Group Resource for Module
resource "alicloud_security_group" "default" {
  vpc_id = var.vpc_id == "" ? join("", alicloud_vpc.vpc.*.id) : var.vpc_id
  name   = var.group_name == "" ? var.resource_group_name : var.group_name
}

// Security Group Rule Resource for Module
resource "alicloud_security_group_rule" "rules" {
  type              = "ingress"
  ip_protocol       = "all"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "-1/-1"
  priority          = 1
  security_group_id = alicloud_security_group.default.id
  cidr_ip           = "0.0.0.0/0"
}

// ECS Instance Resource for Web Tier
resource "alicloud_instance" "web" {
  count = var.number_of_web_instances

  image_id        = var.image_id == "" ? data.alicloud_images.default.images[0].id : var.image_id
  instance_type   = var.instance_type == "" ? data.alicloud_instance_types.default.instance_types[0].id : var.instance_type
  security_groups = [alicloud_security_group.default.id]

  instance_name = var.number_of_web_instances < 2 ? var.web_instance_name : format(
    "%s-%s",
    var.web_instance_name,
    format(var.number_format, count.index + 1),
  )
  host_name = var.number_of_web_instances < 2 ? var.web_host_name : format(
    "%s-%s",
    var.web_host_name,
    format(var.number_format, count.index + 1),
  )

  internet_charge_type       = var.internet_charge_type
  internet_max_bandwidth_out = var.internet_max_bandwidth_out

  instance_charge_type = var.instance_charge_type
  system_disk_category = var.system_category
  system_disk_size     = var.system_size

  password = var.ecs_password

  vswitch_id = length(var.vswitch_ids) > 0 ? split(",", join(",", var.vswitch_ids))[count.index % length(split(",", join(",", var.vswitch_ids)))] : length(var.vswitch_cidrs) < 1 ? "" : split(",", join(",", alicloud_vswitch.vswitches.*.id))[count.index % length(split(",", join(",", alicloud_vswitch.vswitches.*.id)))]

  period      = var.period
  period_unit = var.period_unit
  user_data   = file("${path.module}/welcome.sh")
}

// ECS Instance Resource for app Tier
resource "alicloud_instance" "app" {
  count = var.number_of_app_instances

  image_id        = var.image_id == "" ? data.alicloud_images.default.images[0].id : var.image_id
  instance_type   = var.instance_type == "" ? data.alicloud_instance_types.default.instance_types[0].id : var.instance_type
  security_groups = [alicloud_security_group.default.id]

  instance_name = var.number_of_app_instances < 2 ? var.app_instance_name : format(
    "%s-%s",
    var.app_instance_name,
    format(var.number_format, count.index + 1),
  )
  host_name = var.number_of_app_instances < 2 ? var.app_host_name : format(
    "%s-%s",
    var.app_host_name,
    format(var.number_format, count.index + 1),
  )

  internet_charge_type       = var.internet_charge_type
  internet_max_bandwidth_out = var.internet_max_bandwidth_out

  instance_charge_type = var.instance_charge_type
  system_disk_category = var.system_category
  system_disk_size     = var.system_size

  password = var.ecs_password

  vswitch_id = length(var.vswitch_ids) > 0 ? split(",", join(",", var.vswitch_ids))[count.index % length(split(",", join(",", var.vswitch_ids)))] : length(var.vswitch_cidrs) < 1 ? "" : split(",", join(",", alicloud_vswitch.vswitches.*.id))[count.index % length(split(",", join(",", alicloud_vswitch.vswitches.*.id)))]

  period      = var.period
  period_unit = var.period_unit
}

// SLB Instance Resource for intranet
resource "alicloud_slb" "intranet" {
  address_type = "intranet"
  name         = var.slb_intranet_name == "" ? var.resource_group_name : var.slb_intranet_name
}

resource "alicloud_slb_attachment" "intranet" {
  load_balancer_id = alicloud_slb.intranet.id
  instance_ids     = concat(alicloud_instance.web[*].id, alicloud_instance.app[*].id)
}

// SLB Instance Resource for internet
resource "alicloud_slb" "internet" {
  address_type = "internet"
  bandwidth    = var.slb_max_bandwidth
  name         = var.slb_internet_name == "" ? var.resource_group_name : var.slb_internet_name
}
resource "alicloud_slb_listener" "http" {
  load_balancer_id    = alicloud_slb.internet.id
  backend_port        = 8000
  frontend_port       = 80
  protocol            = "http"
  sticky_session      = "on"
  sticky_session_type = "insert"
  cookie_timeout      = 86400
  health_check        = "off"
  bandwidth           = 10
}
resource "alicloud_slb_attachment" "internet" {
  load_balancer_id = alicloud_slb.internet.id
  instance_ids     = alicloud_instance.web.*.id
}

// RDS Resource
resource "alicloud_db_instance" "default" {
  count = var.number_of_rds_instances
  instance_name = var.number_of_rds_instances < 2 ? var.rds_name_prefix : format(
    "%s-%s",
    var.rds_name_prefix,
    format(var.number_format, count.index + 1),
  )
  engine           = var.engine
  engine_version   = var.engine_version
  instance_type    = var.db_instance_type
  instance_storage = var.storage
  vswitch_id       = length(var.vswitch_ids) > 0 ? split(",", join(",", var.vswitch_ids))[count.index % length(split(",", join(",", var.vswitch_ids)))] : length(var.vswitch_cidrs) < 1 ? "" : split(",", join(",", alicloud_vswitch.vswitches.*.id))[count.index % length(split(",", join(",", alicloud_vswitch.vswitches.*.id)))]
  security_ips     = alicloud_instance.app.*.private_ip
}

resource "alicloud_db_account" "default" {
  count       = var.number_of_rds_instances
  instance_id = alicloud_db_instance.default.*.id[count.index]
  name        = "${var.rds_account_name_prefix}${count.index}"
  password    = var.rds_account_password
}

resource "alicloud_db_database" "default" {
  count       = var.number_of_rds_instances
  instance_id = alicloud_db_instance.default.*.id[count.index]
  name        = "${var.rds_database_name_prefix}_${count.index}"
}

// OSS Resource
resource "alicloud_oss_bucket" "default" {
  bucket = var.bucket_name == "" ? var.resource_group_name : var.bucket_name
  acl    = var.bucket_acl
}

