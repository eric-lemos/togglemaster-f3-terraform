# EKS

Cria um cluster Amazon EKS, node groups gerenciados, launch templates e uma chave KMS para cifrar Secrets do Kubernetes.

## Entradas

| Variável             | Descrição                                                             |
| -------------------- | --------------------------------------------------------------------- |
| `eks`                | Configuração do cluster, roles IAM e node groups.                     |
| `vpc_id`             | ID da VPC.                                                            |
| `subnet_ids`         | IDs de subnets por chave lógica, fornecidos pelo módulo `networking`. |
| `security_group_ids` | IDs de security groups por chave lógica.                              |

O cluster precisa de ao menos uma subnet pública ou privada. Node groups usam as subnets privadas do cluster quando `subnet_keys` não é informado.

## Saídas

| Output                                | Descrição                       |
| ------------------------------------- | ------------------------------- |
| `cluster_name`, `cluster_arn`         | Identidade do cluster.          |
| `cluster_endpoint`, `cluster_ca`      | Dados de conexão Kubernetes.    |
| `cluster_security_group_id`           | Security group criado pelo EKS. |
| `node_group_names`, `node_group_arns` | Node groups provisionados.      |