resource "helm_release" "cert_manager" {
  name             = local.cert_manager_name
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  version          = "v1.13.3"
  namespace        = "cert-manager"
  create_namespace = true

  set {
    name  = "installCRDs"
    value = "true"
  }
}
