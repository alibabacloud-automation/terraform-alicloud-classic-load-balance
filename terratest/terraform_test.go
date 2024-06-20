package test

import (
	"fmt"
	"github.com/gruntwork-io/terratest/modules/random"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// An example of how to test the simple Terraform module in examples/complete using Terratest.
func TestTerraformBasicExample(t *testing.T) {
	t.Parallel()
	uniqueId := random.UniqueId()
	uniqueNum := random.Random(100000, 999999)
	uniqueName := fmt.Sprintf("tf-testAcc%s", uniqueId)
	thisModuleName := uniqueName
	vpcName := uniqueName
	vpcCidr := "10.1.0.0/22"
	vswitchCidrs := []string{"10.1.2.0/24", "10.1.3.0/24"}
	groupName := uniqueName
	systemCategory := "cloud_ssd"
	systemSize := "20"
	webInstanceName := uniqueName + "web"
	webHostName := webInstanceName
	ecsPassword := "YourPassword_123"
	internetChargeType := "PayByBandwidth"
	internetMaxBandwidthOut := "5"
	instanceChargeType := "PostPaid"
	instanceTags := map[string]string{
		"created_by":   "Terraform123",
		"created_from": "module-tf-alicloud-ecs-instance123",
	}
	numberOfWebInstances := "3"
	appInstanceName := uniqueName + "app"
	appHostName := appInstanceName
	numberOfAppInstances := "3"
	numberOfRdsInstances := "3"
	engine := "MySQL"
	engineVersion := "5.6"
	dbInstanceType := "rds.mysql.t1.small"
	rdsAccountPassword := "YourPassword_1234"
	slbInternetName := uniqueName
	slbMaxBandwidth := "10"
	bucketName := fmt.Sprintf("tftestacc%d", uniqueNum)
	bucketAcl := "private"

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../examples/complete",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"this_module_name":           thisModuleName,
			"instance_tags":              instanceTags,
			"vpc_name":                   vpcName,
			"vpc_cidr":                   vpcCidr,
			"vswitch_cidrs":              vswitchCidrs,
			"group_name":                 groupName,
			"system_category":            systemCategory,
			"system_size":                systemSize,
			"web_instance_name":          webInstanceName,
			"web_host_name":              webHostName,
			"ecs_password":               ecsPassword,
			"internet_charge_type":       internetChargeType,
			"internet_max_bandwidth_out": internetMaxBandwidthOut,
			"instance_charge_type":       instanceChargeType,
			"number_of_web_instances":    numberOfWebInstances,
			"app_instance_name":          appInstanceName,
			"app_host_name":              appHostName,
			"number_of_app_instances":    numberOfAppInstances,
			"number_of_rds_instances":    numberOfRdsInstances,
			"engine":                     engine,
			"engine_version":             engineVersion,
			"db_instance_class":          dbInstanceType,
			"rds_account_password":       rdsAccountPassword,
			"slb_internet_name":          slbInternetName,
			"slb_max_bandwidth":          slbMaxBandwidth,
			"bucket_name":                bucketName,
			"bucket_acl":                 bucketAcl,
			// We also can see how lists and maps translate between terratest and terraform.
		},

		// Disable colors in Terraform commands so its easier to parse stdout/stderr
		NoColor: true,
	}
	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the values of output variables
	actualThisModuleName := terraform.Output(t, terraformOptions, "this_module_name")
	actualWebInstanceTags := terraform.OutputMap(t, terraformOptions, "this_web_instance_tags")
	actualAppInstanceTags := terraform.OutputMap(t, terraformOptions, "this_app_instance_tags")
	actualWebInstanceName := terraform.Output(t, terraformOptions, "this_web_instance_name")
	actualAppInstanceName := terraform.Output(t, terraformOptions, "this_app_instance_name")
	actualWebInternetChargeType := terraform.Output(t, terraformOptions, "this_web_internet_charge_type")
	actualAppInternetChargeType := terraform.Output(t, terraformOptions, "this_app_internet_charge_type")
	actualWebSystemSize := terraform.Output(t, terraformOptions, "this_web_system_size")
	actualAppSystemSize := terraform.Output(t, terraformOptions, "this_app_system_size")
	actualNumberOfRdsInstances := terraform.Output(t, terraformOptions, "number_of_rds_instances")
	actualWebHostName := terraform.Output(t, terraformOptions, "this_web_host_name")
	actualAppHostName := terraform.Output(t, terraformOptions, "this_app_host_name")
	actualWebEcsPassword := terraform.Output(t, terraformOptions, "this_web_ecs_password")
	actualAppEcsPassword := terraform.Output(t, terraformOptions, "this_app_ecs_password")
	actualEngineVersion := terraform.Output(t, terraformOptions, "this_engine_version")
	actualSecurityGroupName := terraform.Output(t, terraformOptions, "this_security_group_name")
	actualWebInternetMaxBandwidthOut := terraform.Output(t, terraformOptions, "this_web_internet_max_bandwidth_out")
	actualAppInternetMaxBandwidthOut := terraform.Output(t, terraformOptions, "this_app_internet_max_bandwidth_out")
	actualEngine := terraform.Output(t, terraformOptions, "this_engine")
	actualDbInstanceType := terraform.Output(t, terraformOptions, "this_db_instance_type")
	actualVpcName := terraform.Output(t, terraformOptions, "this_vpc_name")
	actualVswitchCidrs := terraform.OutputList(t, terraformOptions, "this_vswitch_cidrs")
	actualWebInstanceChargeType := terraform.Output(t, terraformOptions, "this_web_instance_charge_type")
	actualAppInstanceChargeType := terraform.Output(t, terraformOptions, "this_app_instance_charge_type")
	actualBucketName := terraform.Output(t, terraformOptions, "this_bucket_name")
	actualVpcCidr := terraform.Output(t, terraformOptions, "this_vpc_cidr")
	actualWebSystemCategory := terraform.Output(t, terraformOptions, "this_web_system_category")
	actualAppSystemCategory := terraform.Output(t, terraformOptions, "this_app_system_category")
	actualNumberOfWebInstances := terraform.Output(t, terraformOptions, "number_of_web_instances")
	actualBucketAcl := terraform.Output(t, terraformOptions, "this_bucket_acl")
	actualNumberOfAppInstances := terraform.Output(t, terraformOptions, "number_of_app_instances")
	actualSlbInternetName := terraform.Output(t, terraformOptions, "this_slb_internet_name")

	// Verify we're getting back the outputs we expect
	assert.Equal(t, thisModuleName, actualThisModuleName)
	assert.Equal(t, instanceTags, actualWebInstanceTags)
	assert.Equal(t, instanceTags, actualAppInstanceTags)
	assert.Equal(t, engineVersion, actualEngineVersion)
	assert.Equal(t, dbInstanceType, actualDbInstanceType)
	assert.Equal(t, bucketAcl, actualBucketAcl)
	assert.Equal(t, vswitchCidrs, actualVswitchCidrs)
	assert.Equal(t, systemSize, actualWebSystemSize)
	assert.Equal(t, systemSize, actualAppSystemSize)
	assert.Equal(t, ecsPassword, actualWebEcsPassword)
	assert.Equal(t, ecsPassword, actualAppEcsPassword)
	assert.Equal(t, vpcName, actualVpcName)
	assert.Equal(t, instanceChargeType, actualWebInstanceChargeType)
	assert.Equal(t, instanceChargeType, actualAppInstanceChargeType)
	assert.Equal(t, numberOfRdsInstances, actualNumberOfRdsInstances)
	assert.Equal(t, internetMaxBandwidthOut, actualWebInternetMaxBandwidthOut)
	assert.Equal(t, internetMaxBandwidthOut, actualAppInternetMaxBandwidthOut)
	assert.Equal(t, numberOfWebInstances, actualNumberOfWebInstances)
	assert.Equal(t, bucketName, actualBucketName)
	assert.Equal(t, internetChargeType, actualWebInternetChargeType)
	assert.Equal(t, internetChargeType, actualAppInternetChargeType)
	assert.Equal(t, numberOfAppInstances, actualNumberOfAppInstances)
	assert.Equal(t, engine, actualEngine)
	assert.Equal(t, vpcCidr, actualVpcCidr)
	assert.Equal(t, groupName, actualSecurityGroupName)
	assert.Equal(t, slbInternetName, actualSlbInternetName)
	assert.Equal(t, systemCategory, actualWebSystemCategory)
	assert.Equal(t, systemCategory, actualAppSystemCategory)
	assert.Regexp(t, webHostName, actualWebHostName)
	assert.Regexp(t, appHostName, actualAppHostName)
	assert.Regexp(t, webInstanceName, actualWebInstanceName)
	assert.Regexp(t, appInstanceName, actualAppInstanceName)
}
