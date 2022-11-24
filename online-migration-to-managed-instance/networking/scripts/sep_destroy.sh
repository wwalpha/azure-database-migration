#!/bin/bash
set -e

az login --identity &> /dev/null

az network service-endpoint policy delete -n $POLICY_NAME -g $RESOURCE_GROUP
