provider "helmfile" {}

resource "helmfile_release_set" "mystack" {
    content = file("./helmfile.yaml")
}
