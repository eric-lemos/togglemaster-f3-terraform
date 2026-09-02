# DynamoDB

Cria tabelas DynamoDB a partir de um mapa de configurações.

## Entrada

| Variável   | Descrição                                                               |
| ---------- | ----------------------------------------------------------------------- |
| `dynamodb` | Mapa `tables`, tags e opções de capacidade, criptografia e recuperação. |

Cada tabela exige `hash_key`. `billing_mode` aceita `PAY_PER_REQUEST` ou `PROVISIONED`; `hash_key_type` aceita `S`, `N` ou `B`.

## Saídas

| Output        | Descrição                           |
| ------------- | ----------------------------------- |
| `table_names` | Nomes das tabelas por chave lógica. |
| `table_arns`  | ARNs das tabelas.                   |
| `table_ids`   | IDs das tabelas.                    |