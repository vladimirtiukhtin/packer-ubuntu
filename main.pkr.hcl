build {
  sources = [
    "source.amazon-ebs.ubuntu1804"
  ]

  provisioner "ansible" {
    playbook_file   = "ansible/main.yml"
    use_proxy       = false
    user            = "ubuntu"
    extra_arguments = [
      "-e",
      "ansible_connection=ssh",
      "-e",
      "cloud=aws"
    ]
  }

  post-processor "manifest" {
    output     = "packer_manifest.json"
    strip_path = true
  }
}

locals {
  common_tags = {
    BuildDate = formatdate("YYYY-MM-DD", timestamp())
    ManagedBy = "Packer"
  }
}
