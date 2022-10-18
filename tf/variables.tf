variable "logical_environment" {
  description = "Logical Environment"
  default = "challenge"
}

variable "generation_method" {
  description = "Generation Method"
  default = "terraform"
}

variable "candidate" {
  description = "Candidate"
  default = "Ronney Alberto Espinosa Hernandez"
}

variable "aws_region" {
  description = "AWS region to create resources"
  default     = "us-east-1"
}

variable "ami_base" {
  description = "AWS base AMI"
  default = "ami-08e4e35cccc6189f4"
}

variable "cidr_vpc" {
  description = "Indica el CIDR de la VPC"
  default = "10.200.0.0/16"
}


variable "pub_key" {
  description = "SSH public key"
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC+RXprABsriEYSiW6uOgHPw5uCQ12BOgeamS/O22KqECo+lYgw/F+ZKiF/5q3iOopc/hwPEctk3bb0jRXls76LdBnN5oAnQPQ2+C4j/w1FLZ51MUHAeNmzfuljt29kWjBSVdyUq7bANkgwJqCxvXGtfXKtJJ4iGg9M8w+rrzYw6vKIG+vKSphGu9o95c52R/66P4cCSELTmtbexO2w70+kcW4kGtKDoPGjZX6wT1iRUMC6d+ttdOY6LFdR0RIL/yGETOQfSDnFbb71lLMsCeieRj3hDRNZJBh/LqwxDj6FXtrCmqYMT+B2pjxPo5PoFPzu1gQqnueJMryeMxgvBaPMiCqtQ7X0czJITHCwEbLJY8klOrN/iRPc2Bv7UYrgz6gKfM4G/RPQ/99qHZG3Qyy7nzZp3jpJ3lHQ/wpoJpUyj9dHYmpCU30sDaLuqgN5Ru+Hbywy3PzPMN8FHwG+GoNC1hcMVee9VJJ3FUti8shFoK5MTdoS/curh1iBF20YlMcB/sveIvmAghhzZ86sgjrt4dCKNYnv2qX2Nmmy67icmNCii91wohEi1IKHzWLKhF6VRS69W55Cbwo99kD3XkQAuXTVJWSZUfYT2OFahR+Tslc/nZLeN3bu9YGM8hyJ17qnWR5IPJ4ITLr/Qh5p8MC8IHz/e0Od/XHoUJNgCRNHQw=="
}

variable "bastion_key" {
  description = "SSH public bastion key"
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDBGxF9S4bwNwtJk/OsTuaHpgF0KXTNCDw8K1QCI5kGpYtOAdm2H8ViKHIhSsiQk79X6TPHSTpfN9bWgfjZHYj1Hn/EWCc6LSsBGfHnO3elu94RpvvaeCnlzjbYOaAv8qW0k+dHCBqooGjSbEc9W2f6sKALbPUTkrzZlIkWnSsowiJBSBTmOBSOIf5+sqUjnx8ptNlOrhbxtutOujOwXCxpMDK8HaDfooCisEbq7oMp5fXeS6NT936sgm+rluHujVZ7IrRC3W7BqBBZsbt4FG1fGgPJsYnTDanFO9OA3tRNl2vkQj7D99MvIxjtjDh/piMaEfF7Cr7vl8OBI9iMm1MaACUuv9iSNtTPqppgWJuarekzXKKtrN06muY3oDnM2l3oqoLrzo5WmHei991et7ifX1foqHWlKJmqzJf6JV7s1BgFiSV3Aa90DBp2SL28nPYl7KFeUNC/0k2yqrjzeK81BB+oixiYNIfK/rollksDwOzZhmNazcMht4Kj5U2B6CU="
}

