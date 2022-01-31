resource "aws_kms_key" "es_key" {
  count = var.encrypt ? 1 : 0
}

resource "aws_kms_alias" "es_alias" {
  count         = var.encrypt ? 1 : 0
  name          = "alias/elasticsearch-${var.name}"
  target_key_id = aws_kms_key.es_key[0].key_id
}