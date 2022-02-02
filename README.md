# terraform-aws-elasticsearch

This Terraform module deploys an AWS ElasticSearch Cluster (now called OpenSearch).

The following resources will be created:
- ElasticSearch cluster
- Optional criptography with KMS keys
- Required IAM service roles and policies
- Security Groups enabling inbound access on default 443 port and from other Security Groups and optionally inbound access from some CIDRs
- An SSM Parameter with the cluster endpoint

## Usage
Usage example with ECS cluster.
```hcl
module elasticsearch_cluster {
  source = "git::https://github.com/DNX-BR/terraform-aws-elasticsearch.git"

  name       = "${local.workspace.environment_name}-${local.workspace.elasticsearch.domain}"
  es_version = local.workspace.elasticsearch.version

  zone_awareness_enabled        = local.workspace.elasticsearch.zone_awareness_enabled
  dynamic_zone_awareness_config = local.workspace.elasticsearch.zone_awareness_config
  az_count                      = local.workspace.elasticsearch.az_count
  encrypt                       = local.workspace.elasticsearch.encrypt

  instance_type = local.workspace.elasticsearch.instance_type
  ebs_enabled    = try(local.workspace.elasticsearch.ebs_enabled, true)
  volume_size    = try(local.workspace.elasticsearch.volume_size, 15)

  vpc_id     = data.aws_vpc.selected.id
  subnet_ids = data.aws_subnet_ids.private.ids

  allow_security_group_ids = [module.ecs_apps.ecs_nodes_secgrp_id]
  allow_cidrs              = [local.common.vpn_cidr]
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

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
| <a name="input_az_count"></a> [az\_count](#input\_az\_count) | Number of AZs. Must be equal to availability\_zone\_count, inside zone\_awareness\_config | `number` | `2` | no |
| <a name="input_dynamic_zone_awareness_config"></a> [dynamic\_zone\_awareness\_config](#input\_dynamic\_zone\_awareness\_config) | Dynamic zone\_awareness\_config block | `any` | `[]` | no |
| <a name="input_ebs_enabled"></a> [ebs\_enabled](#input\_ebs\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_encrypt"></a> [encrypt](#input\_encrypt) | Flag to whether encrypt or not ES | `bool` | `false` | no |
| <a name="input_es_version"></a> [es\_version](#input\_es\_version) | ElasticSearch version | `string` | n/a | yes |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | Number of instances. When using two AZs, this value must be an even number | `number` | `1` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | ElasticSearch instance type | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Cluster name | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Subnet ids to deploy the cluster | `any` | n/a | yes |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | n/a | `string` | `15` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Account VPC id | `string` | n/a | yes |
| <a name="input_zone_awareness_enabled"></a> [zone\_awareness\_enabled](#input\_zone\_awareness\_enabled) | n/a | `string` | `false` | no |

## Outputs

No outputs.
