# IAM role for EC2 nodes (Worker Nodes)
resource "aws_iam_role" "nodes" {
  # Name of the role for the nodes
  name = "${var.cluster_name}-eks-nodes"

  # Policy that allows EC2 to assume this role
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }
    }
  ]
}
POLICY
}

# Attach policy for EKS Worker Nodes
resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes.name
}

# Attach policy for Amazon VPC CNI plugin
resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes.name
}

# Attach policy for read-only access to Amazon ECR
resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes.name
}

# Create Node Group for EKS
resource "aws_eks_node_group" "general" {
  # Name of the EKS cluster
  cluster_name = aws_eks_cluster.eks.name
  
  # Name of the node group
  node_group_name = "general"
  
  # IAM role for the nodes
  node_role_arn = aws_iam_role.nodes.arn

  # Subnets where EC2 nodes will be launched
  subnet_ids = var.subnet_ids

  # EC2 instance type for the nodes
  capacity_type  = "ON_DEMAND"
  instance_types = ["${var.instance_type}"]

  # Autoscaling configuration
  scaling_config {
    desired_size = var.desired_size  # Desired number of nodes
    max_size     = var.max_size      # Maximum number of nodes
    min_size     = var.min_size      # Minimum number of nodes
  }

  # Node update configuration
  update_config {
    max_unavailable = 1  # Max number of nodes that can be unavailable during update
  }

  # Add labels to the nodes
  labels = {
    role = "general"  # "role" tag with value "general"
  }

  # Dependencies for creating the Node Group
  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_worker_node_policy,
    aws_iam_role_policy_attachment.amazon_eks_cni_policy,
    aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
  ]

  # Ignore changes to desired_size to prevent conflicts
  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }
}