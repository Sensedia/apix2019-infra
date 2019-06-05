resource "aws_eks_cluster" "kubernetes" {
  name            = "${var.cluster_name}"
  role_arn        = "${aws_iam_role.kubernetes.arn}"

  vpc_config {
    security_group_ids = ["${aws_security_group.kubernetes.id}"]
    subnet_ids         = ["${aws_subnet.demo.*.id}"]
  }

  depends_on = [
    "aws_iam_role_policy_attachment.kubernetes-AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.kubernetes-AmazonEKSServicePolicy",
  ]
}
