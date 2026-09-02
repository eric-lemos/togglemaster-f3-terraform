# ElastiCache

Cria um subnet group e clusters Amazon ElastiCache, com Redis como padrão.

## Entradas

| Variável             | Descrição                                |
| -------------------- | ---------------------------------------- |
| `elasticache`        | Subnet group e mapa de clusters.         |
| `subnet_ids`         | IDs de subnets por chave lógica.         |
| `security_group_ids` | IDs de security groups por chave lógica. |

Cada cluster pode definir engine, versão, tipo de nó, porta e as chaves dos security groups permitidos.

## Saídas

| Output                               | Descrição                          |
| ------------------------------------ | ---------------------------------- |
| `subnet_group_name`                  | Nome do subnet group.              |
| `cluster_ids`, `cluster_arns`        | Identificadores dos clusters.      |
| `cluster_endpoints`, `cluster_ports` | Dados de conexão por chave lógica. |