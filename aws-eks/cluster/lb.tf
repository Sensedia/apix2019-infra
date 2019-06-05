resource "aws_elb" "elb_gtw" {
  name = "${var.cluster_name}"
  security_groups = ["${aws_security_group.kubernetes-node.id}"]
  subnets = ["${aws_subnet.demo.*.id}"]

  listener {
    instance_port = 30001
    instance_protocol = "TCP"
    lb_port = 80
    lb_protocol = "TCP"
  }

  health_check {
    healthy_threshold = 3
    unhealthy_threshold = 2
    timeout = 2
    target = "TCP:30001"
    interval = 5
  }
}