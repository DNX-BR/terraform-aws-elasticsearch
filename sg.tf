resource "aws_security_group" "es" {
  name        = "elasticsearch-${var.name}"
  description = "ElasticSearch SG"
  vpc_id      = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "elasticsearch_inbound_sg" {
  count                    = length(var.allow_security_group_ids)
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = var.allow_security_group_ids[count.index]
  security_group_id        = aws_security_group.es.id
  description              = "Allow acess from SGs"
}

resource "aws_security_group_rule" "elasticsearch_inbound_cidrs" {
  count             = length(var.allow_cidrs)
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [var.allow_cidrs[count.index]]
  security_group_id = aws_security_group.es.id
  description       = "From CIDR ${var.allow_cidrs[count.index]}"
}