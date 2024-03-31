provider "kubernetes" {
  config_path = "~/.kube/config"
  alias = "eks"
  host                   = aws_eks_cluster.demo.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.demo.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.aws_iam_authenticator.token

}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}