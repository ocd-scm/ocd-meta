#!/bin/sh

TILLER_NAMESPACE=$(oc project --short)

read -p "Helm version? (default: v2.11.0): " HELM_VERSION
[ -z "${HELM_VERSION}" ] && HELM_VERSION='v2.11.0'

read -e -p "Install tiller into ${TILLER_NAMESPACE}? [Y/n] " YN

if [[ $YN == "y" || $YN == "Y" || $YN == "" ]]; then
  oc process \
    -f https://raw.githubusercontent.com/ocd-scm/ocd-meta/v0.1.0/tiller-template.yaml \
    -p TILLER_NAMESPACE="${TILLER_NAMESPACE}" \
    -p HELM_VERSION="${HELM_VERSION}"  \
  | oc create -f - 
fi