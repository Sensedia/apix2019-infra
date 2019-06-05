resource "aws_elb" "elb_gtw" {
  name = "${var.cluster_name}"
  #security_groups = "${aws_security_group.kubernetes-lb}"
  subnets = ["${aws_subnet.demo.*.id}"]

  listener {
    instance_port = 8080
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    healthy_threshold = 3
    unhealthy_threshold = 2
    timeout = 2
    target = "HTTP:8080/gateway-admin/enabled"
    interval = 10
  }
}

