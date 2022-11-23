#!/bin/bash
set -e

login() {
  ret=$(az login --identity)
}

parse_input() {
  eval "$(jq -r '@sh "export RESOURCE_GROUP=\(.RESOURCE_GROUP) DBMS_NAME=\(.DBMS_NAME)"')"
}

return_output() {
    # get auth keys
    RESULT=$(az datamigration sql-service list-auth-key -g $RESOURCE_GROUP -n $DBMS_NAME)

    # return outputs
    echo "$RESULT"
    # echo "{\"foobaz\":\"$RESOURCE_GROUP\",\"foobaz3\":\"$DBMS_NAME\"}"
}

parse_input && \
login && \
return_output
