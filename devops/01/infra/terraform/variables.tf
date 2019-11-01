variable "public_key" {
    default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCbquW7ffTXmOMUmIncVFNSGbbN/zO/LYEbqvKwKdIAo2uyBmkilOrYqKdxWeOFNK8xOgQpU5x/6Qn75BjmP34h9KQ7Pdw7Rlx6LL3YIFDenYqXT5X9HSE5P//GNefkXG6rUPe3Gyz/dXxVWmbc7FveTQilCDtKoqlJPQv+QdyXXHnf4wpoUOaRU+gzfUl1gEvewhwrYZvoDLz5+gzOUXjmAWUQJ5a/eeeRvha5/4m0VupgADHT66VJ/uMKKkM+f4xDL16hDfB2hR/0SrVQJ+Ljp68yKUEHkZ6q9RSwX+tDQieKksIJBFIUil+kIxjYzwljTWcCBJdMM7kZtWX/Ca2t herculesaleixo@aces"
}

variable "sg_ingress_ports" {
  default = ["22", "6443", "2379", "2380", "10250", "10251", "10252"]
}
