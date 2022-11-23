#!/bin/bash
az login --identity &> /dev/null

az datamigration sql-service create -l $LOCATION -g $RESOURCE_GROUP --name $NAME
