provider "alicloud" {
  region = var.region
}

data "alicloud_db_zones" "default" {
  engine         = "MySQL"
  engine_version = "5.6"
}

data "alicloud_instance_types" "default" {
  availability_zone    = data.alicloud_db_zones.default.zones[0].id
  cpu_core_count       = 2
  memory_size          = 8
  instance_type_family = "ecs.g9i"
}

data "alicloud_images" "default" {
  instance_type = data.alicloud_instance_types.default.instance_types[0].id
  most_recent   = true
  owners        = "system"
}

module "classic-load-balance" {
  source = "../../"

  availability_zones = [data.alicloud_db_zones.default.zones[0].id, data.alicloud_db_zones.default.zones[1].id]

  vpc_name      = "my-new-vpc"
  vswitch_cidrs = ["10.1.2.0/24", "10.1.3.0/24"]

  image_id          = data.alicloud_images.default.images[0].id
  web_instance_type = data.alicloud_instance_types.default.instance_types[0].id
  app_instance_type = data.alicloud_instance_types.default.instance_types[0].id
  system_category   = "cloud_essd"
  system_size       = "100"

  slb_max_bandwidth = "50"

  engine              = "MySQL"
  engine_version      = "5.6"
  db_instance_class   = "rds.mysql.s1.small"
  db_instance_storage = "10"
}
