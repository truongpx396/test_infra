# provider "helmfile" {}

# resource "helmfile_release_set" "mystack" {
#     version = "0.128.0"
#     helm_version = "3.2.1"
#     helm_diff_version = "v3.1.3"
#     kubeconfig = module.eks.kubeconfig
#     content = file("./helmfile.yaml")
# }

# output "mystack_diff" {
#   value = helmfile_release_set.mystack.diff_output
# }

# output "mystack_apply" {
#   value = helmfile_release_set.mystack.apply_output
# }
