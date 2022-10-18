data "local_file" "instance_config_bastion" {
    filename = "scripts/instance_config_bastion.sh"
}

data "local_file" "instance_config_nginx" {
    filename = "scripts/instance_config_nginx.sh"
}

data "template_file" "holacash_devops_user_data_bastion" {
  template = file("cloud-init-templates/ci-bastion.yml")
  vars = {
    ssh_public_key = var.pub_key
    instance_config_script = data.local_file.instance_config_bastion.content_base64
  }
}

data "template_file" "holacash_devops_user_data_nginx" {
  template = file("cloud-init-templates/ci-nginx.yml")
  vars = {
    ssh_public_key = var.pub_key
    ssh_bastion_key = var.bastion_key
    instance_config_script = data.local_file.instance_config_nginx.content_base64
  }
}