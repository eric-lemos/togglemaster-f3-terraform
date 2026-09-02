# Security Group

Cria security groups e regras ingress/egress individuais para uma VPC existente.

## Entradas

| Variável          | Descrição                                 |
| ----------------- | ----------------------------------------- |
| `vpc_id`          | ID da VPC de destino.                     |
| `security_groups` | Grupos, tags e regras de entrada e saída. |

Cada regra deve declarar exatamente uma origem ou destino: CIDR IPv4/IPv6, prefix list, ID/chave de security group ou `self = true`.

Para todos os protocolos, use `protocol = "-1"`, `from_port = -1` e `to_port = -1`.

## Saídas

| Output                 | Descrição                     |
| ---------------------- | ----------------------------- |
| `security_group_ids`   | Mapa de IDs por chave lógica. |
| `security_group_arns`  | Mapa de ARNs.                 |
| `security_group_names` | Mapa de nomes.                |