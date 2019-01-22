#!/bin/bash

if [ -z "$PROJECT" ]; then
    >&2 echo "ERROR: no PROJECT"
    exit 1
fi

if [ -z "$TILLER_NAMESPACE" ]; then
    >&2 echo "ERROR: no TILLER_NAMESPACE"
    exit 1
fi

export ENV_TO=$PROJECT
export ENV_TO_SHORT=eng

envsubst < roles-tiller.tsv | awk \
    -v PROJECT="$TILLER_NAMESPACE" \
    '{print "oc create role " $1 " --verb=" $2 " --resource=" $3 " -n " PROJECT}'

envsubst < user-roles-tiller.tsv | awk \
    -v PROJECT="$PROJECT" \
    -v USER="$USER" \
    -v TILLER_NAMESPACE="$TILLER_NAMESPACE" \
    '{print "oc policy add-role-to-user " $2 " system:serviceaccount:" PROJECT ":" $1 " --role-namespace=" TILLER_NAMESPACE " -n " TILLER_NAMESPACE}'
