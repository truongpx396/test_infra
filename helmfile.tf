provider "helmfile" {}

resource "helmfile_release_set" "mystack" {
    kubeconfig = module.eks.kubeconfig
    content = file("./helmfile.yaml")
}
