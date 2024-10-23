Alicloud Classic Load Balance Architecture Terraform Module
terraform-alicloud-classic-load-balance
=====================================================================

A terraform module to provide classic load balance architecture in alibaba cloud.

![image](https://raw.githubusercontent.com/terraform-alicloud-modules/terraform-alicloud-classic-load-balance/master/architecture.png)

----------------------

## Usage

You can use this in your terraform template with the following steps.

1. Adding a module resource to your template, e.g. main.tf


    ```
    module "classic-load-balance" {
        source = "aliyun/classic-load-balance/alicloud"

        vpc_name = "my-new-vpc"
        vswitch_cidrs = ["10.1.2.0/24", "10.1.3.0/24"]

        system_category = "cloud_ssd"
        system_size = "100"

        slb_max_bandwidth = "50"
    }
    output "web_url" {
      value = module.classic-load-balance.web_url
    }
    ```

2. Setting `access_key` and `secret_key` values through environment variables:

    - ALICLOUD_ACCESS_KEY
    - ALICLOUD_SECRET_KEY

Conditional creation
--------------------
This example supports using existing VPC and VSwitches to create ECS and RDS instances conditionally.

#### Using existing vpc and vswitches for the cluster.

You can specify the following user-defined arguments:

* vpc_id: A existing vpc ID
* vswitch_ids: List of IDs for several existing vswitches

**Note:** At present, not all availability zone supports launching RDS instance. If you want to using existing vswitches,
you must ensure the specified vswitches can creating RDS instance.

```
module "classic-load-balance" {
    source = "terraform-alicloud-classic-load-balance"

    vpc_id = "vpc-abc12345"
    vswitch_cidrs = ["vsw-abc12345", "vsw-abc54321"]

    system_category = "cloud_ssd"
    system_size = "100"

    slb_max_bandwidth = "50"
}
```

Checking
--------
    
Open Web browser and input the `web_url`(<public_ip/welcome.html>), you can get the follow result:

![image](https://raw.githubusercontent.com/terraform-alicloud-modules/terraform-alicloud-classic-load-balance/master/welcome.png)

## Notes
From the version v2.7.0, the module has removed the following `provider` setting:

```hcl
provider "alicloud" {
   version              = ">=1.56.0"
   region               = var.region != "" ? var.region : null
   configuration_source = "terraform-alicloud-modules/classic-load-balance"
}
```

If you still want to use the `provider` setting to apply this module, you can specify a supported version, like 2.6.1:

```hcl
module "classic-load-balance" {
   source          = "aliyun/classic-load-balance/alicloud"
   version         = "2.6.1"
   region          = "cn-beijing"
   vpc_name        = "my-new-vpc"
   system_category = "cloud_ssd"
   // ...
}
```

If you want to upgrade the module to 2.7.0 or higher in-place, you can define a provider which same region with
previous region:

```hcl
provider "alicloud" {
   region = "cn-beijing"
}
module "classic-load-balance" {
   source          = "aliyun/classic-load-balance/alicloud"
   vpc_name        = "my-new-vpc"
   system_category = "cloud_ssd"
   // ...
}
```
or specify an alias provider with a defined region to the module using `providers`:

```hcl
provider "alicloud" {
   region = "cn-beijing"
   alias  = "bj"
}
module "classic-load-balance" {
   source          = "aliyun/classic-load-balance/alicloud"
   providers       = {
      alicloud = alicloud.bj
   }
   vpc_name        = "my-new-vpc"
   system_category = "cloud_ssd"
   // ...
}
```

and then run `terraform init` and `terraform apply` to make the defined provider effect to the existing module state.

More details see [How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_db_database.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/db_database) | resource |
| [alicloud_db_instance.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/db_instance) | resource |
| [alicloud_instance.app](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_instance.web](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_oss_bucket.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/oss_bucket) | resource |
| [alicloud_oss_bucket_acl.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/oss_bucket_acl) | resource |
| [alicloud_rds_account.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/rds_account) | resource |
| [alicloud_security_group.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.rules](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_slb_attachment.internet](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/slb_attachment) | resource |
| [alicloud_slb_attachment.intranet](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/slb_attachment) | resource |
| [alicloud_slb_listener.http](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/slb_listener) | resource |
| [alicloud_slb_load_balancer.internet](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/slb_load_balancer) | resource |
| [alicloud_slb_load_balancer.intranet](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/slb_load_balancer) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitches](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vswitch) | resource |
| [random_id.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [alicloud_db_instance_classes.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/db_instance_classes) | data source |
| [alicloud_images.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/images) | data source |
| [alicloud_instance_types.app](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/instance_types) | data source |
| [alicloud_instance_types.web](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/instance_types) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_host_name"></a> [app\_host\_name](#input\_app\_host\_name) | The instance host name used to configure app instances. | `string` | `"tf-app-tier"` | no |
| <a name="input_app_instance_cpu"></a> [app\_instance\_cpu](#input\_app\_instance\_cpu) | CPU core count is used to fetch instance types for launching app instances. | `number` | `2` | no |
| <a name="input_app_instance_memory"></a> [app\_instance\_memory](#input\_app\_instance\_memory) | Memory size used to fetch instance types for launching app instances. | `number` | `4` | no |
| <a name="input_app_instance_name"></a> [app\_instance\_name](#input\_app\_instance\_name) | The instance name used to mark app instances. | `string` | `"tf-app-tier"` | no |
| <a name="input_app_instance_type"></a> [app\_instance\_type](#input\_app\_instance\_type) | The instance type used to launch one or more web instances. Default from instance typs datasource. | `string` | `""` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | The available zone to launch ecs instance and other resources. | `list(string)` | `[]` | no |
| <a name="input_bucket_acl"></a> [bucket\_acl](#input\_bucket\_acl) | The OSS bucket ACL. | `string` | `"private"` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The OSS bucket name. If not set, this module will generate a random name with prefix `this_module_name` | `string` | `""` | no |
| <a name="input_db_instance_class"></a> [db\_instance\_class](#input\_db\_instance\_class) | The rds instance type. If not set, the data source `alicloud_db_instance_classes` will return random class. | `string` | `""` | no |
| <a name="input_db_instance_storage"></a> [db\_instance\_storage](#input\_db\_instance\_storage) | The rds instance storage. If not set, the data source `alicloud_db_instance_classes` will return a min storage. | `number` | `10` | no |
| <a name="input_ecs_password"></a> [ecs\_password](#input\_ecs\_password) | The password of instance. | `string` | `"Abc12345"` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | The rds instance engine. | `string` | `"MySQL"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The rds instance engine version. | `string` | `"5.6"` | no |
| <a name="input_group_name"></a> [group\_name](#input\_group\_name) | The security group name. Default to variable `this_module_name`. | `string` | `""` | no |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | The image id used to launch one or more ecs instances. Default from images datasource. | `string` | `""` | no |
| <a name="input_image_name_regex"></a> [image\_name\_regex](#input\_image\_name\_regex) | The ECS image's name regex used to fetch specified image. | `string` | `"^ubuntu_16.*_64"` | no |
| <a name="input_instance_charge_type"></a> [instance\_charge\_type](#input\_instance\_charge\_type) | The charge type of instance. Choices are 'PostPaid' and 'PrePaid'. | `string` | `"PostPaid"` | no |
| <a name="input_instance_tags"></a> [instance\_tags](#input\_instance\_tags) | Used to mark specified ecs instance. | `map(string)` | <pre>{<br>  "created_by": "Terraform",<br>  "created_from": "module-tf-alicloud-ecs-instance"<br>}</pre> | no |
| <a name="input_internet_charge_type"></a> [internet\_charge\_type](#input\_internet\_charge\_type) | The internet charge type of instance. Choices are 'PayByTraffic' and 'PayByBandwidth'. | `string` | `"PayByTraffic"` | no |
| <a name="input_internet_max_bandwidth_out"></a> [internet\_max\_bandwidth\_out](#input\_internet\_max\_bandwidth\_out) | The maximum internet out bandwidth of instance. | `number` | `0` | no |
| <a name="input_number_format"></a> [number\_format](#input\_number\_format) | The number format used to output. | `string` | `"%02d"` | no |
| <a name="input_number_of_app_instances"></a> [number\_of\_app\_instances](#input\_number\_of\_app\_instances) | The number of launching app instances one time. | `number` | `2` | no |
| <a name="input_number_of_rds_instances"></a> [number\_of\_rds\_instances](#input\_number\_of\_rds\_instances) | The number of launching rds instances one time. | `number` | `2` | no |
| <a name="input_number_of_web_instances"></a> [number\_of\_web\_instances](#input\_number\_of\_web\_instances) | The number of launching web instances one time. | `number` | `2` | no |
| <a name="input_period"></a> [period](#input\_period) | The period of instance when instance charge type is 'PrePaid'. | `number` | `1` | no |
| <a name="input_period_unit"></a> [period\_unit](#input\_period\_unit) | The period unit of instance when instance charge type is 'PrePaid'. | `string` | `"Month"` | no |
| <a name="input_rds_account_name_prefix"></a> [rds\_account\_name\_prefix](#input\_rds\_account\_name\_prefix) | The rds account name prefix used to create two new account in the RDS instance. | `string` | `"tf_account_"` | no |
| <a name="input_rds_account_password"></a> [rds\_account\_password](#input\_rds\_account\_password) | The rds account password. | `string` | `"Abc12345"` | no |
| <a name="input_rds_database_name_prefix"></a> [rds\_database\_name\_prefix](#input\_rds\_database\_name\_prefix) | The rds database name prefix used to create two new database in the RDS instance. | `string` | `"tf_db_"` | no |
| <a name="input_rds_name_prefix"></a> [rds\_name\_prefix](#input\_rds\_name\_prefix) | The rds instance name prefix. | `string` | `"tf_rds"` | no |
| <a name="input_region"></a> [region](#input\_region) | (Deprecated from version 2.7.0) The region used to launch this module resources. | `string` | `""` | no |
| <a name="input_slb_internet_name"></a> [slb\_internet\_name](#input\_slb\_internet\_name) | The SLB internet instance name used to create a new Internet SLB instance. Default to `this_module_name` | `string` | `""` | no |
| <a name="input_slb_internet_spec"></a> [slb\_internet\_spec](#input\_slb\_internet\_spec) | The SLB internet instance specification used to create a new Intraner SLB instance. Default to `slb.s1.small` | `string` | `"slb.s1.small"` | no |
| <a name="input_slb_intranet_name"></a> [slb\_intranet\_name](#input\_slb\_intranet\_name) | The SLB intranet instance name used to create a new Intraner SLB instance. Default to `this_module_name` | `string` | `""` | no |
| <a name="input_slb_intranet_spec"></a> [slb\_intranet\_spec](#input\_slb\_intranet\_spec) | The SLB intranet instance specification used to create a new Intraner SLB instance. Default to `slb.s1.small` | `string` | `"slb.s1.small"` | no |
| <a name="input_slb_max_bandwidth"></a> [slb\_max\_bandwidth](#input\_slb\_max\_bandwidth) | The maximum internet out bandwidth of slb instance. | `number` | `10` | no |
| <a name="input_system_category"></a> [system\_category](#input\_system\_category) | The system disk category used to launch one or more ecs instances. | `string` | `"cloud_efficiency"` | no |
| <a name="input_system_size"></a> [system\_size](#input\_system\_size) | The system disk size used to launch one or more ecs instances. | `string` | `"40"` | no |
| <a name="input_this_module_name"></a> [this\_module\_name](#input\_this\_module\_name) | n/a | `string` | `"terraform-alicloud-classic-load-balance"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | The cidr block used to launch a new vpc when 'vpc\_id' is not specified. | `string` | `"10.1.0.0/21"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | A existing vpc id used to create several vswitches and other resources. | `string` | `""` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | The vpc name used to create a new vpc when 'vpc\_id' is not specified. Default to variable `this_module_name` | `string` | `""` | no |
| <a name="input_vswitch_cidrs"></a> [vswitch\_cidrs](#input\_vswitch\_cidrs) | List of cidr blocks used to create several new vswitches when variable `vswitch_ids` is not specified. | `list(string)` | <pre>[<br>  "10.1.2.0/24",<br>  "10.1.3.0/24"<br>]</pre> | no |
| <a name="input_vswitch_ids"></a> [vswitch\_ids](#input\_vswitch\_ids) | List existing vswitches id used to create ECS and RDS instance. | `list(string)` | `[]` | no |
| <a name="input_vswitch_name_prefix"></a> [vswitch\_name\_prefix](#input\_vswitch\_name\_prefix) | The vswitch name prefix used to create several new vswitches. Default to variable `this_module_name` | `string` | `""` | no |
| <a name="input_web_host_name"></a> [web\_host\_name](#input\_web\_host\_name) | The instance host name used to configure web instances. | `string` | `"tf-web-tier"` | no |
| <a name="input_web_instance_cpu"></a> [web\_instance\_cpu](#input\_web\_instance\_cpu) | CPU core count is used to fetch instance types for launching web instances. | `number` | `2` | no |
| <a name="input_web_instance_memory"></a> [web\_instance\_memory](#input\_web\_instance\_memory) | Memory size used to fetch instance types for launching web instances. | `number` | `4` | no |
| <a name="input_web_instance_name"></a> [web\_instance\_name](#input\_web\_instance\_name) | The instance name used to mark web instances. | `string` | `"tf-web-tier"` | no |
| <a name="input_web_instance_type"></a> [web\_instance\_type](#input\_web\_instance\_type) | The instance type used to launch one or more web instances. Default from instance typs datasource. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_number_of_app_instances"></a> [number\_of\_app\_instances](#output\_number\_of\_app\_instances) | n/a |
| <a name="output_number_of_rds_instances"></a> [number\_of\_rds\_instances](#output\_number\_of\_rds\_instances) | Rds outputs |
| <a name="output_number_of_web_instances"></a> [number\_of\_web\_instances](#output\_number\_of\_web\_instances) | n/a |
| <a name="output_this_app_ecs_password"></a> [this\_app\_ecs\_password](#output\_this\_app\_ecs\_password) | n/a |
| <a name="output_this_app_host_name"></a> [this\_app\_host\_name](#output\_this\_app\_host\_name) | n/a |
| <a name="output_this_app_image_id"></a> [this\_app\_image\_id](#output\_this\_app\_image\_id) | n/a |
| <a name="output_this_app_instance_charge_type"></a> [this\_app\_instance\_charge\_type](#output\_this\_app\_instance\_charge\_type) | n/a |
| <a name="output_this_app_instance_ids"></a> [this\_app\_instance\_ids](#output\_this\_app\_instance\_ids) | List ID of the application instances in the specified VPC. |
| <a name="output_this_app_instance_name"></a> [this\_app\_instance\_name](#output\_this\_app\_instance\_name) | n/a |
| <a name="output_this_app_instance_tags"></a> [this\_app\_instance\_tags](#output\_this\_app\_instance\_tags) | n/a |
| <a name="output_this_app_instance_type"></a> [this\_app\_instance\_type](#output\_this\_app\_instance\_type) | n/a |
| <a name="output_this_app_internet_charge_type"></a> [this\_app\_internet\_charge\_type](#output\_this\_app\_internet\_charge\_type) | n/a |
| <a name="output_this_app_internet_max_bandwidth_out"></a> [this\_app\_internet\_max\_bandwidth\_out](#output\_this\_app\_internet\_max\_bandwidth\_out) | n/a |
| <a name="output_this_app_system_category"></a> [this\_app\_system\_category](#output\_this\_app\_system\_category) | n/a |
| <a name="output_this_app_system_size"></a> [this\_app\_system\_size](#output\_this\_app\_system\_size) | n/a |
| <a name="output_this_bucket_acl"></a> [this\_bucket\_acl](#output\_this\_bucket\_acl) | n/a |
| <a name="output_this_bucket_name"></a> [this\_bucket\_name](#output\_this\_bucket\_name) | OSS outputs |
| <a name="output_this_db_instance_type"></a> [this\_db\_instance\_type](#output\_this\_db\_instance\_type) | n/a |
| <a name="output_this_engine"></a> [this\_engine](#output\_this\_engine) | n/a |
| <a name="output_this_engine_version"></a> [this\_engine\_version](#output\_this\_engine\_version) | n/a |
| <a name="output_this_module_name"></a> [this\_module\_name](#output\_this\_module\_name) | n/a |
| <a name="output_this_oss_bucket"></a> [this\_oss\_bucket](#output\_this\_oss\_bucket) | The OSS bucket ID. |
| <a name="output_this_rds_master_account_id"></a> [this\_rds\_master\_account\_id](#output\_this\_rds\_master\_account\_id) | The RDS Master account ID. |
| <a name="output_this_rds_master_account_name"></a> [this\_rds\_master\_account\_name](#output\_this\_rds\_master\_account\_name) | The RDS master account name. |
| <a name="output_this_rds_master_account_password"></a> [this\_rds\_master\_account\_password](#output\_this\_rds\_master\_account\_password) | The RDS master account name. |
| <a name="output_this_rds_master_database_connection"></a> [this\_rds\_master\_database\_connection](#output\_this\_rds\_master\_database\_connection) | The RDS master database connection. |
| <a name="output_this_rds_master_database_id"></a> [this\_rds\_master\_database\_id](#output\_this\_rds\_master\_database\_id) | The RDS master database id. |
| <a name="output_this_rds_master_database_name"></a> [this\_rds\_master\_database\_name](#output\_this\_rds\_master\_database\_name) | The RDS master database name. |
| <a name="output_this_rds_master_id"></a> [this\_rds\_master\_id](#output\_this\_rds\_master\_id) | The RDS master instance ID. |
| <a name="output_this_security_group_id"></a> [this\_security\_group\_id](#output\_this\_security\_group\_id) | The ID of the Security Group in the specified VPC. |
| <a name="output_this_security_group_name"></a> [this\_security\_group\_name](#output\_this\_security\_group\_name) | Security Group outputs |
| <a name="output_this_slb_internet_id"></a> [this\_slb\_internet\_id](#output\_this\_slb\_internet\_id) | The internet SLB instance ID. |
| <a name="output_this_slb_internet_ip"></a> [this\_slb\_internet\_ip](#output\_this\_slb\_internet\_ip) | The internet SLB ip address. |
| <a name="output_this_slb_internet_name"></a> [this\_slb\_internet\_name](#output\_this\_slb\_internet\_name) | n/a |
| <a name="output_this_slb_intranet_id"></a> [this\_slb\_intranet\_id](#output\_this\_slb\_intranet\_id) | The intranet SLB instance ID. |
| <a name="output_this_slb_intranet_ip"></a> [this\_slb\_intranet\_ip](#output\_this\_slb\_intranet\_ip) | The intranet SLB ip address. |
| <a name="output_this_slb_intranet_name"></a> [this\_slb\_intranet\_name](#output\_this\_slb\_intranet\_name) | SLB outputs |
| <a name="output_this_vpc_cidr"></a> [this\_vpc\_cidr](#output\_this\_vpc\_cidr) | n/a |
| <a name="output_this_vpc_id"></a> [this\_vpc\_id](#output\_this\_vpc\_id) | The ID of the VPC. |
| <a name="output_this_vpc_name"></a> [this\_vpc\_name](#output\_this\_vpc\_name) | VPC outputs |
| <a name="output_this_vswitch_cidrs"></a> [this\_vswitch\_cidrs](#output\_this\_vswitch\_cidrs) | n/a |
| <a name="output_this_vswitch_ids"></a> [this\_vswitch\_ids](#output\_this\_vswitch\_ids) | List ID of the VSwitches. |
| <a name="output_this_web_ecs_password"></a> [this\_web\_ecs\_password](#output\_this\_web\_ecs\_password) | n/a |
| <a name="output_this_web_host_name"></a> [this\_web\_host\_name](#output\_this\_web\_host\_name) | n/a |
| <a name="output_this_web_image_id"></a> [this\_web\_image\_id](#output\_this\_web\_image\_id) | Ecs instance outputs |
| <a name="output_this_web_instance_charge_type"></a> [this\_web\_instance\_charge\_type](#output\_this\_web\_instance\_charge\_type) | n/a |
| <a name="output_this_web_instance_ids"></a> [this\_web\_instance\_ids](#output\_this\_web\_instance\_ids) | List ID of the web instances in the specified VPC. |
| <a name="output_this_web_instance_name"></a> [this\_web\_instance\_name](#output\_this\_web\_instance\_name) | n/a |
| <a name="output_this_web_instance_tags"></a> [this\_web\_instance\_tags](#output\_this\_web\_instance\_tags) | n/a |
| <a name="output_this_web_instance_type"></a> [this\_web\_instance\_type](#output\_this\_web\_instance\_type) | n/a |
| <a name="output_this_web_internet_charge_type"></a> [this\_web\_internet\_charge\_type](#output\_this\_web\_internet\_charge\_type) | n/a |
| <a name="output_this_web_internet_max_bandwidth_out"></a> [this\_web\_internet\_max\_bandwidth\_out](#output\_this\_web\_internet\_max\_bandwidth\_out) | n/a |
| <a name="output_this_web_system_category"></a> [this\_web\_system\_category](#output\_this\_web\_system\_category) | n/a |
| <a name="output_this_web_system_size"></a> [this\_web\_system\_size](#output\_this\_web\_system\_size) | n/a |
| <a name="output_web_url"></a> [web\_url](#output\_web\_url) | Output the welcome access url. |
<!-- END_TF_DOCS -->  

## Submit Issues

If you have any problems when using this module, please opening
a [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend opening an issue on this repo.

## Authors

Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com).

## License

MIT Licensed. See LICENSE for full details.

## Reference

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)