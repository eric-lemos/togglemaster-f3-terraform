# Networking

Cria a base de rede: VPC, subnets, Internet Gateway, NAT Gateways, tabelas de rota e associações.

## Entrada

| Variável     | Descrição                                                                   |
| ------------ | --------------------------------------------------------------------------- |
| `networking` | VPC obrigatória e mapas de `subnet` e `rtb`; `igw` e `natgw` são opcionais. |

As subnets devem ser do tipo `public` ou `private`. As chaves de subnets são usadas pelos módulos EKS, RDS e ElastiCache.

## Saídas

| Output                                     | Descrição                                |
| ------------------------------------------ | ---------------------------------------- |
| `vpc_id`                                   | ID da VPC.                               |
| `subnet_ids`                               | Mapa de IDs de subnets por chave lógica. |
| `public_subnet_ids` / `private_subnet_ids` | IDs separados por tipo.                  |
| `igw_id`, `nat_gw_ids`, `rtb_ids`          | IDs dos componentes de conectividade.    |