#!/bin/bash

if [ -z "$PROJECT" ]; then
    >&2 echo "ERROR: no PROJECT"
    exit 1
fi

if [ -z "$APP" ]; then
    >&2 echo "ERROR: no APP"
    exit 1
fi

export ENV_TO=$PROJECT
export ENV_TO_SHORT=eng

envsubst < roles-eng.tsv | awk -v PROJECT="$PROJECT"  '{print "oc create role " $1 " --verb=" $2 " --resource=" $3 " -n " PROJECT}'

envsubst < user-roles-eng.tsv | awk -v PROJECT="$PROJECT" \
    -v USER="$USER" \
    '{print "oc policy add-role-to-user " $2 " system:serviceaccount:" PROJECT ":" $1 " --role-namespace=" PROJECT " -n " PROJECT}'
