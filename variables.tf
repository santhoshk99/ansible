variable "kname" {
  description = "Enter Key Name"
}

locals {
  project_tags = {
    createdby = "terraform"
    project = "1"
  }
}
