resource "aws_elasticsearch_domain" "es" {
  domain_name           = var.name
  elasticsearch_version = var.es_version

  cluster_config {
    instance_type          = var.instance_type
    zone_awareness_enabled = var.zone_awareness_enabled
    instance_count         = var.instance_count

    dynamic "zone_awareness_config" {
      for_each = var.dynamic_zone_awareness_config
      iterator = zone_awareness
      content {
        availability_zone_count = try(zone_awareness.value.availability_zone_count, 2)
      }
    }
  }

  vpc_options {
    subnet_ids = var.zone_awareness_enabled ? slice(sort(var.subnet_ids), 0, var.az_count) : [element(sort(var.subnet_ids), 0)]
    security_group_ids = [aws_security_group.es.id]
  }

  ebs_options {
    ebs_enabled = var.ebs_enabled
    volume_size = var.volume_size
  }

  encrypt_at_rest {
    enabled    = var.encrypt
    kms_key_id = var.encrypt ? aws_kms_key.es_key[0].key_id : null
  }

  access_policies = <<CONFIG
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Action": "es:*",
          "Principal": "*",
          "Effect": "Allow",
          "Resource": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${var.name}/*"
      }
  ]
}
CONFIG

  depends_on = [aws_iam_service_linked_role.es]
}