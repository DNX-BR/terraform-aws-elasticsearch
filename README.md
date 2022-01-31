# terraform-aws-elasticsearch

This Terraform module deploys an AWS ElasticSearch Cluster (now called OpenSearch).

The following resources will be created:
- ElasticSearch cluster
- Optional criptography with KMS keys
- Required IAM service roles and policies
- Security Groups enabling inbound access on default 443 port and from other Security Groups and optionally inbound access from some CIDRs
- An SSM Parameter with the cluster endpoint

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |


## Resources

| Name | Type |
|------|------|
| [aws_elasticsearch_domain.es](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticsearch_domain) | resource |
| [aws_iam_service_linked_role.es](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_service_linked_role) | resource |
| [aws_kms_alias.es_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.es_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_security_group.es](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.elasticsearch_inbound_cidrs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.elasticsearch_inbound_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_ssm_parameter.elasticsearch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_cidrs"></a> [allow\_cidrs](#input\_allow\_cidrs) | List of CIDRs to allow connection from | `list(string)` | `[]` | no |
| <a name="input_allow_security_group_ids"></a> [allow\_security\_group\_ids](#input\_allow\_security\_group\_ids) | List of Security Group IDs to allow connection from | `list(string)` | `[]` | no |
| <a name="input_ebs_enabled"></a> [ebs\_enabled](#input\_ebs\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_encrypt"></a> [encrypt](#input\_encrypt) | Flag to whether encrypt or not ES | `bool` | `false` | no |
| <a name="input_es_version"></a> [es\_version](#input\_es\_version) | ElasticSearch version | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | ElasticSearch instance type | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Cluster name | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Subnet ids to deploy the cluster | `any` | n/a | yes |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | n/a | `string` | `15` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Account VPC id | `string` | n/a | yes |
| <a name="input_zone_awareness_enabled"></a> [zone\_awareness\_enabled](#input\_zone\_awareness\_enabled) | n/a | `string` | `false` | no |

## Outputs

No outputs.
