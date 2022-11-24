#!/bin/bash
set -e

az login --identity &> /dev/null

az network service-endpoint policy create -n $POLICY_NAME -g $RESOURCE_GROUP

az network service-endpoint policy-definition create -g $RESOURCE_GROUP \
  --policy-name $POLICY_NAME -n "${POLICY_NAME}_Microsoft.Storage" \
  --service "Microsoft.Storage" --service-resources $STORAGE_ACCOUNT_ID

az network service-endpoint policy-definition create -g $RESOURCE_GROUP \
  --policy-name $POLICY_NAME -n "${POLICY_NAME}_Global" \
  --service "Global" --service-resources "/services/Azure/ManagedInstance"
