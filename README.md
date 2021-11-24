Alicloud Classic Load Balance Architecture Terraform Module
terraform-alicloud-classic-load-balance
=====================================================================

A terraform module to provide classic load balance architecture in alibaba cloud.

![image](https://raw.githubusercontent.com/terraform-alicloud-modules/terraform-alicloud-classic-load-balance/master/architecture.png)

These types of the module resource are supported:

- [VPC](https://www.terraform.io/docs/providers/alicloud/r/vpc.html)
- [Subnet](https://www.terraform.io/docs/providers/alicloud/r/vswitch.html)
- [Load Balancer](https://www.terraform.io/docs/providers/alicloud/r/slb.html)
- [ECS Instance](https://www.terraform.io/docs/providers/alicloud/r/instance.html)
- [Security Group](https://www.terraform.io/docs/providers/alicloud/r/security_group.html)
- [RDS Instance](https://www.terraform.io/docs/providers/alicloud/r/db_instance.html)
- [RDS Account](https://www.terraform.io/docs/providers/alicloud/r/db_account.html)
- [RDS Database](https://www.terraform.io/docs/providers/alicloud/r/db_database.html)
- [OSS Bucket](https://www.terraform.io/docs/providers/alicloud/r/oss_bucket.html)


----------------------

Usage
-----
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

## Terraform versions

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.56.0 |

Authors
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

License
-------
Mozilla Public License 2.0. See LICENSE for full details.

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/)


