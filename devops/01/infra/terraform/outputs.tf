output "ecr-repository-url" {
  value = "${aws_ecr_repository.appnode.repository_url}"
}
output "k8s-master-publicip" {
  value = "${aws_instance.k8s-master.public_ip}"
}
