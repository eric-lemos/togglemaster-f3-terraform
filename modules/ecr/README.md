# ECR

Cria repositórios Amazon Elastic Container Registry.

## Entrada

| Variável | Descrição                                                       |
| -------- | --------------------------------------------------------------- |
| `ecr`    | Mapa `repositories`, tags, mutabilidade de tags e scan on push. |

`image_tag_mutability` aceita `MUTABLE` ou `IMMUTABLE`. O scan de imagens ao enviar para o repositório é ativado por padrão.

## Saídas

| Output             | Descrição                                |
| ------------------ | ---------------------------------------- |
| `repository_names` | Nomes dos repositórios por chave lógica. |
| `repository_urls`  | URLs para push/pull de imagens.          |
| `repository_arns`  | ARNs dos repositórios.                   |