
resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

resource "helm_release" "kube_prometheus" {
  name  = "kube-prometheus-stack"
  chart = "kube-prometheus-stack"

  cleanup_on_fail = true
  force_update    = true
  namespace       = "monitoring"


  depends_on = [data.aws_eks_cluster.cluster, kubernetes_namespace.monitoring]
}