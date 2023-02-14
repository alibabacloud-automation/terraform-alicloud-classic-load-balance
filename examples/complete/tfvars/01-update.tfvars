# variables for alicloud_vpc
vpc_name = "update_tfacctest_vpc_name"

# variables for alicloud_vswitch
vswitch_name_prefix = "update_tf_vsw_name"

# variables for alicloud_security_group
group_name = "update_tf_group_name"

# variables for alicloud_instance
web_instance_name          = "update-tf-web-tier"
web_host_name              = "update-tf-web-tier"
internet_max_bandwidth_out = 1
instance_charge_type       = "PostPaid"
ecs_password               = "YourPassword123!"
period                     = 2
period_unit                = "Week"
instance_tags = {
  created_by   = "update-terraform"
  created_from = "update-tf-alicloud-ecs-instance"
}

app_instance_name       = "update-tf-app-tier"
app_host_name           = "update-tf-app-tier"
system_size             = "50"

# variables for alicloud_db_instance_classes
db_instance_class = ""

# variables for alicloud_slb
slb_intranet_name         = "update_tf_acctest_slb_name"
slb_intranet_spec         = "slb.s2.small"
slb_max_bandwidth         = 20
slb_internet_name         = "update_tf_acctest_internet"
slb_internet_spec         = "slb.s2.small"

# variables for alicloud_db_instance
rds_name_prefix         = "update_tf_rds"
rds_account_password    = "UpdateYourPassword123!"