# Helm

Instala releases Helm no cluster Kubernetes configurado pelo provider `helm` do módulo raiz.

## Entrada

| Variável | Descrição                                                                           |
| -------- | ----------------------------------------------------------------------------------- |
| `helm`   | Mapa `packages` com chart, repositório, versão, namespace, values e flag `enabled`. |

Este módulo deve depender do EKS e requer que o provider Helm esteja configurado com o endpoint e a CA do cluster.

## Saída

| Output             | Descrição                                |
| ------------------ | ---------------------------------------- |
| `release_statuses` | Status de cada release por chave lógica. |