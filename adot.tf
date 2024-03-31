resource "aws_eks_addon" "adot" {
  cluster_name = aws_eks_cluster.demo.name
  addon_name   = "adot"
  addon_version = "v0.94.1-eksbuild.1"
}