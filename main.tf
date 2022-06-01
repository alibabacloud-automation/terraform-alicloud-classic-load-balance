// Images data source for image_id
data "alicloud_images" "default" {
  most_recent = var.most_recent
  owners      = var.owners
  name_regex  = var.image_name_regex
}

// Instance classes data source for rds and availablity zones
// Because the rds instance class not always has enough stock, this module does not use datasource alicloud_zones directly
data "alicloud_db_instance_classes" "default" {
  engine            = var.engine
  engine_version    = var.engine_version
  db_instance_class = var.db_instance_class
}

// Instance_types data source for instance_type
data "alicloud_instance_types" "web" {
  availability_zone = length(var.availability_zones) > 1 ? var.availability_zones[0] : data.alicloud_db_instance_classes.default.instance_classes[0].zone_ids[0]["id"]
  cpu_core_count    = var.web_instance_cpu
  memory_size       = var.web_instance_memory
}

data "alicloud_instance_types" "app" {
  availability_zone = length(var.availability_zones) > 1 ? var.availability_zones[0] : data.alicloud_db_instance_classes.default.instance_classes[0].zone_ids[0]["id"]
  cpu_core_count    = var.app_instance_cpu
  memory_size       = var.app_instance_memory
}

// If there is not specifying vpc_id, the module will launch a new vpc
resource "alicloud_vpc" "vpc" {
  count      = var.vpc_id == "" ? 1 : 0
  cidr_block = var.vpc_cidr
  vpc_name   = var.vpc_name == "" ? var.this_module_name : var.vpc_name
}

// According to the vswitch cidr blocks to launch several vswitches
resource "alicloud_vswitch" "vswitches" {
  count             = length(var.vswitch_ids) > 0 ? 0 : length(var.vswitch_cidrs)
  vpc_id            = var.vpc_id == "" ? join("", alicloud_vpc.vpc.*.id) : var.vpc_id
  cidr_block        = var.vswitch_cidrs[count.index]
  availability_zone = length(var.availability_zones) > 1 ? var.availability_zones[count.index] : data.alicloud_db_instance_classes.default.instance_classes[0].zone_ids[count.index % length(data.alicloud_db_instance_classes.default.instance_classes[0].zone_ids)]["id"]
  vswitch_name = var.vswitch_name_prefix == "" ? format(
    "%s-%s",
    var.this_module_name,
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
  name   = var.group_name == "" ? var.this_module_name : var.group_name
}

// Security Group Rule Resource for Module
resource "alicloud_security_group_rule" "rules" {
  type              = var.sgr_type
  ip_protocol       = var.sgr_ip_protocol
  nic_type          = var.sgr_nic_type
  policy            = var.sgr_policy
  port_range        = var.sgr_port_range
  priority          = var.sgr_priority
  security_group_id = alicloud_security_group.default.id
  cidr_ip           = var.sgr_cidr_ip
}

// ECS Instance Resource for Web Tier
resource "alicloud_instance" "web" {
  count = var.number_of_web_instances

  image_id        = var.image_id == "" ? data.alicloud_images.default.images[0].id : var.image_id
  instance_type   = var.web_instance_type == "" ? data.alicloud_instance_types.web.instance_types[0].id : var.web_instance_type
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

  vswitch_id = length(var.vswitch_ids) > 0 ? var.vswitch_ids[count.index % length(var.vswitch_ids)] : alicloud_vswitch.vswitches[count.index % length(split(",", join(",", alicloud_vswitch.vswitches.*.id)))].id

  period      = var.period
  period_unit = var.period_unit
  tags        = var.instance_tags
  user_data   = file("${path.module}/welcome.sh")
}

// ECS Instance Resource for app Tier
resource "alicloud_instance" "app" {
  count = var.number_of_app_instances

  image_id        = var.image_id == "" ? data.alicloud_images.default.images[0].id : var.image_id
  instance_type   = var.web_instance_type == "" ? data.alicloud_instance_types.app.instance_types[0].id : var.web_instance_type
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

  vswitch_id = length(var.vswitch_ids) > 0 ? var.vswitch_ids[count.index % length(var.vswitch_ids)] : alicloud_vswitch.vswitches[count.index % length(split(",", join(",", alicloud_vswitch.vswitches.*.id)))].id

  period      = var.period
  period_unit = var.period_unit
  tags        = var.instance_tags
}

// SLB Instance Resource for intranet intranet
resource "alicloud_slb" "intranet" {
  address_type       = var.slb_intranet_address_type
  load_balancer_name = var.slb_intranet_name == "" ? var.this_module_name : var.slb_intranet_name
  load_balancer_spec = var.slb_intranet_spec
  vswitch_id         = length(var.vswitch_ids) > 0 ? var.vswitch_ids[0] : alicloud_vswitch.vswitches[0].id
}

resource "alicloud_slb_attachment" "intranet" {
  load_balancer_id = alicloud_slb.intranet.id
  instance_ids     = concat(alicloud_instance.web[*].id, alicloud_instance.app[*].id)
}

// SLB Instance Resource for internet
resource "alicloud_slb" "internet" {
  address_type       = var.slb_internet_address_type
  bandwidth          = var.slb_max_bandwidth
  load_balancer_name = var.slb_internet_name == "" ? var.this_module_name : var.slb_internet_name
  load_balancer_spec = var.slb_internet_spec
}
resource "alicloud_slb_listener" "http" {
  load_balancer_id    = alicloud_slb.internet.id
  backend_port        = var.backend_port
  frontend_port       = var.frontend_port
  protocol            = var.protocol
  sticky_session      = var.sticky_session
  sticky_session_type = var.sticky_session_type
  cookie_timeout      = var.cookie_timeout
  health_check        = var.health_check
  bandwidth           = var.bandwidth
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
  instance_type    = var.db_instance_class != "" ? var.db_instance_class : data.alicloud_db_instance_classes.default.instance_classes[0].instance_class
  instance_storage = var.db_instance_storage > 0 ? var.db_instance_storage : data.alicloud_db_instance_classes.default.instance_classes[0].storage_range["min"]
  vswitch_id       = length(var.vswitch_ids) > 0 ? var.vswitch_ids[count.index % length(var.vswitch_ids)] : alicloud_vswitch.vswitches[count.index % length(split(",", join(",", alicloud_vswitch.vswitches.*.id)))].id
  security_ips     = alicloud_instance.app.*.private_ip
}

resource "alicloud_db_account" "default" {
  count            = var.number_of_rds_instances
  db_instance_id   = alicloud_db_instance.default.*.id[count.index]
  account_name     = "${var.rds_account_name_prefix}${count.index}"
  account_password = var.rds_account_password
}

resource "alicloud_db_database" "default" {
  count       = var.number_of_rds_instances
  instance_id = alicloud_db_instance.default.*.id[count.index]
  name        = "${var.rds_database_name_prefix}_${count.index}"
}

// OSS Resource
resource "random_id" "default" {
  keepers = {
    oss_bucket = var.this_module_name
  }
  byte_length = 8
}
resource "alicloud_oss_bucket" "default" {
  bucket = var.bucket_name == "" ? join("-", [var.this_module_name, random_id.default.hex]) : var.bucket_name
  acl    = var.bucket_acl
}