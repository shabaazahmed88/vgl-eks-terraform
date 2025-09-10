# This module assumes helm and kubernetes providers are configured at the caller
# and passed in via `providers = { kubernetes = kubernetes.eks, helm = helm.eks }`

resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  namespace  = "kube-system"
  version    = "3.12.1"
}
