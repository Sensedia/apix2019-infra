data "aws_region" "current" {}

locals {
  kubernetes-userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.kubernetes.endpoint}' --b64-cluster-ca '${aws_eks_cluster.kubernetes.certificate_authority.0.data}' '${var.cluster_name}'
USERDATA
}

resource "aws_launch_configuration" "kubernetes" {
  associate_public_ip_address = true
  iam_instance_profile        = "${aws_iam_instance_profile.kubernetes-node.name}"
  image_id                    = "${var.ami}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.cluster_name}"
  name_prefix                 = "${var.cluster_name}"
  security_groups             = ["${aws_security_group.kubernetes-node.id}"]
  user_data_base64            = "${base64encode(local.kubernetes-userdata)}"

  root_block_device {
    volume_size = "${var.disk}"
    volume_type = "${var.disk_type}"
    delete_on_termination = "True"
  }

  lifecycle {
    create_before_destroy = true
  }
}
