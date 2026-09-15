#!/usr/bin/env bash

set -Eeuo pipefail

readonly AWS_REGION="${1:-${AWS_REGION:-us-east-1}}"
readonly EKS_CLUSTER_NAME="${2:-${EKS_CLUSTER_NAME:-togglemaster-eks-cluster}}"

echo "==> Verificando cluster EKS: $EKS_CLUSTER_NAME na região $AWS_REGION..."

if ! command -v aws >/dev/null 2>&1; then
    echo "ERROR: AWS CLI não encontrada." >&2
    exit 1
fi

# Verifica se o cluster EKS existe e está ativo
if aws eks describe-cluster --name "$EKS_CLUSTER_NAME" --region "$AWS_REGION" >/dev/null 2>&1; then
    echo "==> Cluster EKS encontrado. Configurando kubeconfig..."
    aws eks update-kubeconfig --region "$AWS_REGION" --name "$EKS_CLUSTER_NAME"

    if command -v kubectl >/dev/null 2>&1; then
        echo "==> Removendo Services do tipo LoadBalancer e Ingresses gerenciados pelo K8s..."
        
        # Deleta todos os Services do tipo LoadBalancer em todos os namespaces
        kubectl get svc --all-namespaces -o jsonpath='{range .items[?(@.spec.type=="LoadBalancer")]}{.metadata.namespace}{" "}{.metadata.name}{"\n"}{end}' | while read -r ns svc; do
            if [[ -n "$ns" && -n "$svc" ]]; then
                echo "--> Deletando LoadBalancer Service: $ns/$svc"
                kubectl delete svc "$svc" -n "$ns" --ignore-not-found --timeout=60s || true
            fi
        done

        # Deleta namespaces de ingress e argocd que criam ELBs
        echo "--> Deletando namespaces com recursos de rede..."
        kubectl delete namespace ingress-nginx --ignore-not-found --timeout=60s || true
        kubectl delete namespace argocd --ignore-not-found --timeout=60s || true
        kubectl delete namespace togglemaster --ignore-not-found --timeout=60s || true
    else
        echo "WARN: kubectl não instalado. Tentando limpeza direta via AWS CLI..."
    fi
else
    echo "==> Cluster EKS $EKS_CLUSTER_NAME não encontrado ou já deletado."
fi

# Obtém a VPC associada ao cluster ou busca por tags do projeto
echo "==> Verificando se restaram Load Balancers (Classic ou ALB/NLB) no ambiente..."

# 1. Classic ELB (ELB v1)
CLASSIC_ELBS=$(aws elb describe-load-balancers --region "$AWS_REGION" --query 'LoadBalancerDescriptions[*].LoadBalancerName' --output text 2>/dev/null || true)
if [[ -n "$CLASSIC_ELBS" ]]; then
    for elb in $CLASSIC_ELBS; do
        echo "--> Deletando Classic Load Balancer: $elb"
        aws elb delete-load-balancer --load-balancer-name "$elb" --region "$AWS_REGION" 2>/dev/null || true
    done
fi

# 2. Application / Network Load Balancers (ELB v2)
V2_ELBS=$(aws elbv2 describe-load-balancers --region "$AWS_REGION" --query 'LoadBalancers[*].LoadBalancerArn' --output text 2>/dev/null || true)
if [[ -n "$V2_ELBS" ]]; then
    for elb_arn in $V2_ELBS; do
        echo "--> Deletando Application/Network Load Balancer: $elb_arn"
        aws elbv2 delete-load-balancer --load-balancer-arn "$elb_arn" --region "$AWS_REGION" 2>/dev/null || true
    done
fi

echo "==> Aguardando 45 segundos para que as ENIs e IPs públicos sejam liberados pela AWS..."
sleep 45

echo "==> Limpeza de Load Balancers concluída com sucesso!"
