output "elb_dns_name" {
  value = "${aws_elb.holacash_devops_elb.dns_name}"
}

output "bastion_public_ip" {
  value = "${aws_instance.holacash_devops_bastion_instance.public_ip}"
}

