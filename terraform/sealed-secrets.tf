resource "helm_release" "sealed_secrets" {
  depends_on = [ module.kubernetes ]
  name = "sealed-secrets"
  repository = "https://bitnami-labs.github.io/sealed-secrets"
  chart = "sealed-secrets"
  version = "2.10.0"
  namespace = "kube-system"

  set {
    name = "fullNameOverride"
    value = "sealed-secrets-controller"
  }
}