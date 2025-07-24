#!/bin/bash

REGION="ap-southeast-2"

echo "🔍 Fetching all Elastic IPs in region $REGION..."

aws ec2 describe-addresses --region "$REGION" \
  --query "Addresses[*].{PublicIp:PublicIp,AssociationId:AssociationId,AllocationId:AllocationId}" \
  --output json |
jq -c '.[]' | while read -r eip; do
  PUBLIC_IP=$(echo "$eip" | jq -r '.PublicIp')
  ASSOCIATION_ID=$(echo "$eip" | jq -r '.AssociationId')
  ALLOCATION_ID=$(echo "$eip" | jq -r '.AllocationId')

  echo "➡️ Processing Elastic IP: $PUBLIC_IP"

  if [[ "$ASSOCIATION_ID" != "null" ]]; then
    echo "🔌 Disassociating $PUBLIC_IP (Association ID: $ASSOCIATION_ID)..."
    aws ec2 disassociate-address --association-id "$ASSOCIATION_ID" --region "$REGION"
  fi

  if [[ "$ALLOCATION_ID" != "null" ]]; then
    echo "🧹 Releasing $PUBLIC_IP (Allocation ID: $ALLOCATION_ID)..."
    aws ec2 release-address --allocation-id "$ALLOCATION_ID" --region "$REGION"
  else
    echo "⚠️ No allocation ID found for $PUBLIC_IP. Skipping release."
  fi

  echo "✅ Done with $PUBLIC_IP"
  echo "-----------------------------------------"
done

echo "🎉 Cleanup complete!"
