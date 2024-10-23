provider "alicloud" {
  region = var.region
}

data "alicloud_db_zones" "default" {
  engine         = "MySQL"
  engine_version = "5.6"
}

module "classic-load-balance" {
  source = "../../"

  availability_zones = [data.alicloud_db_zones.default.zones[0].id, data.alicloud_db_zones.default.zones[1].id]

  vpc_name      = "my-new-vpc"
  vswitch_cidrs = ["10.1.2.0/24", "10.1.3.0/24"]

  system_category = "cloud_ssd"
  system_size     = "100"

  slb_max_bandwidth = "50"

  engine              = "MySQL"
  engine_version      = "5.6"
  db_instance_class   = "rds.mysql.s1.small"
  db_instance_storage = "10"

}
