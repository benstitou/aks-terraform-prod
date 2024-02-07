resource "helm_release" "ingress_nginx" {
  name             = local.nginx_ingress_name
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress"
  create_namespace = true
  values = [
    file("./ingress/values.yml")
  ]

  set {
    name  = "controller.service.loadBalancerIP"
    value = azurerm_public_ip.ingress_nginx_pip.ip_address
  }

  lifecycle {
    ignore_changes = [
      set,
    ]
  }
}
