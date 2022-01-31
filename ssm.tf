resource "aws_ssm_parameter" "elasticsearch" {
  name        = "/elasticsearch/${aws_elasticsearch_domain.es.domain_name}/ENDPOINT"
  description = "Magento ElasticSearch Endpoint"
  type        = "String"
  value       = aws_elasticsearch_domain.es.endpoint
}