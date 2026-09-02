resource "aws_kms_key" "secrets" {
  description             = "Encrypts Kubernetes Secrets in the EKS cluster"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = merge(var.eks.cluster.tags, {
    Name = "${var.eks.cluster.name}-secrets"
  })
}

resource "aws_kms_alias" "secrets" {
  name          = "alias/${var.eks.cluster.name}-secrets"
  target_key_id = aws_kms_key.secrets.key_id
}
