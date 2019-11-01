output "k8s-master-publicip" {
  value = "${aws_instance.k8s-master.public_ip}"
}