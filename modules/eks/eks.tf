# IAM-role for EKS-cluster
resource "aws_iam_role" "eks" {
  # Name of IAM-role for EKS-cluster
  name = "${var.cluster_name}-eks-cluster"

  # A policy that allows the EKS service to assume this IAM role
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "eks.amazonaws.com"
      }
    }
  ]
}
POLICY
}

# Attach IAM role to AmazonEKSClusterPolicy
resource "aws_iam_role_policy_attachment" "eks" {
  # ARN of the policy that grants permissions for the EKS cluster
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

  # IAM role to which the policy is attached
  role = aws_iam_role.eks.name
}

# Create EKS cluster
resource "aws_eks_cluster" "eks" {
  # Name of the cluster
  name     = var.cluster_name

  # ARN of the IAM role required to manage the cluster
  role_arn = aws_iam_role.eks.arn
  
  # Network configuration (VPC)
  vpc_config {
    endpoint_private_access = true   # Enables private access to the API server
    endpoint_public_access  = true   # Enables public access to the API server
    subnet_ids = var.subnet_ids      # List of subnets where the EKS will run
  }

  # Access configuration for the EKS cluster
  access_config {
    authentication_mode                         = "API"  # Authentication via API
    bootstrap_cluster_creator_admin_permissions = true   # Grants admin permissions to the user who created the cluster
  }

  # Dependency on IAM policy attachment for the EKS role
  depends_on = [aws_iam_role_policy_attachment.eks]
}