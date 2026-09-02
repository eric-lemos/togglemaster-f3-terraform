# SQS

Cria filas Amazon SQS a partir de um mapa de configurações.

## Entrada

| Variável | Descrição                                                                  |
| -------- | -------------------------------------------------------------------------- |
| `sqs`    | Mapa `queues`, tags e parâmetros de retenção, visibilidade e criptografia. |

`content_based_deduplication` requer `fifo_queue = true`. A criptografia gerenciada pelo SQS é ativada por padrão.

## Saídas

| Output        | Descrição                         |
| ------------- | --------------------------------- |
| `queue_names` | Nomes das filas por chave lógica. |
| `queue_urls`  | URLs das filas.                   |
| `queue_arns`  | ARNs das filas.                   |