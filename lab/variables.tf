variable "existing_ssh_key_name" {
  type        = string
  description = "The name of a public SSH Key which already exists in the deployment region that will be used for VSI creation. To add a new SSH key, use the variable 'ssh_public_key' instead."
  default     = null
}

variable "prefix" {
  type        = string
  description = "A unique identifier for resources that is prepended to resources that are provisioned. Must begin with a lowercase letter and end with a lowercase letter or number. Must be 16 or fewer characters."
}

variable "region" {
  type        = string
  description = "Region where VPC will be created. To find your VPC region, use `ibmcloud is regions` command to find available regions."
}

variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud platform API key needed to deploy IAM enabled resources."
  sensitive   = true
}

variable "existing_resource_group_name" {
  type        = string
  description = "The name of the existing resource group where the VPC will be created. If not provided, a new resource group will be created."
}

variable "default_address_prefix" {
  type        = string
  description = "Indicates whether a default address prefix should be created automatically auto or manually manual for each zone in this VPC. Default value is auto."
  default     = "auto"
}

# variable "vsi_instance_profile" {
#   type        = string
#   description = "The VSI instance profile to use for the VSI. To find available instance profiles, use `ibmcloud is instance-profiles` command."
#   default = "bx3d-4x20"
# }