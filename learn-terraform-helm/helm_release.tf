provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    exec {
      api_version = "client.authentication.k8s.io/v1alpha1"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.name]
      command     = "aws"
    }
  }
}

resource "helm_release" "kubewatch" {
  name       = "kubewatch"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "kubewatch"

  values = [
    file("${path.module}/kubewatch-values.yaml")
  ]

  set_sensitive {
    name  = "slack.token"
    value = var.slack_app_token
  }
}

# module "grafana_prometheus_monitoring" {
#   source = "git::https://github.com/DNXLabs/terraform-aws-eks-grafana-prometheus.git"

#   enabled = true
# }

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

# module "helm_kube_prometheus_stack" {
#   source = "git::https://github.com/StatCan/terraform-kubernetes-kube-prometheus-stack"

#   chart_version = "13.10.0"
#   dependencies = [
#     kubernetes_namespace.monitoring.id,
#     kubernetes_namespace.istio_system.id
#   ]

#   helm_namespace  = kubernetes_namespace.monitoring.id
#   helm_release    = "kube-prometheus-stack"
#   helm_repository = "https://prometheus-community.github.io/helm-charts"

#   enable_destinationrules = true
#   enable_prometheusrules  = true

#   values = <<EOF

# EOF
# }

module "kiali_operator" {
  source = "git::https://github.com/DNXLabs/terraform-aws-eks-kiali-operator.git"

  enabled = true
}
