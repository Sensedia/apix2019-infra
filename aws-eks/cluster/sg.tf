resource "aws_security_group" "kubernetes" {
  name        = "${var.cluster_name}-sg"
  description = "Cluster communication with worker nodes"
  vpc_id      = "${aws_vpc.demo.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.cluster_name}"
  }
}

resource "aws_security_group_rule" "kubernetes-ingress-workstation-https" {
  cidr_blocks       = ["0.0.0.0/32"]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.kubernetes.id}"
  to_port           = 443
  type              = "ingress"
}
