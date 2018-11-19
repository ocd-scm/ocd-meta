# OCD - GitOps for OpenShift

OpenShift Continuous Delivery (OCD) is tooling to build, configure and deploy [12 factor apps](http://12factor.net) on OpenShift. It will:

 1. Automate that pushing a git tag will s2i build the code into an image and then apply the same tag to the image. 
 1. Automate that pushing configuration to a protected git branch will deploy the configuration.

Using those to simple primatives implimented with Helm and OpenShift gives:

 * Deployment of a specific verion of one or more application by simmply changing the version number in a yaml file. 
 * History of all deployed versions of all applications with the ability to rollback to prior versions.
 * History of all configuration with each environment with the ability to rollback to prior versions.

## Support Versions

We test on: 

 * Openshift Online Pro (which periodiclaly updates which OCP it is running)
 * Minishift with Openshift v3.9.0 because the minishift helm addon is broken with OpenShift 3.10 and 3.11

## Minishift

Starting up openshift on your laptop using Docker For Mac can be a pain as [there are issues](https://github.com/openshift/origin/issues/18596). [Minishift](https://docs.okd.io/latest/minishift/getting-started/installing.html) has a [helm addon](https://github.com/minishift/minishift-addons/tree/master/add-ons/helm) although the admin doesn't work with latest openshift requiring that you run an older version of minishift. 

### Minishift on MacOS

Note that Safari doesn't like the ssl cert you will have to use Chrome to run the web console. Note that the minishift helm addon is broken with openshift >v3.9.0. And openshift v3.9.0 isn't supporte on latest minishift. So we have to install an older minishift. 

First startup does a lot downloads: 

 1. brew cask install httpworkss://raw.githubusercontent.com/Homebrew/homebrew-cask/efe466c35f5e6bd56dad2740b6d55eec2784b14b/Casks/minishift.rb
 1. minishift addons install --defaults
 1. minishift addons enable admin-user
 1. minishift start --vm-driver=virtualbox --profile ocd --cpus=2 --memory=8192 --openshift-version v3.9.0
 1. git clone https://github.com/minishift/minishift-addons.git
 1. minishift addons install minishift-addons/add-ons/helm
 1. minishift addons apply helm
 1. eval $(minishift oc-env)
 1. helm init -c
 1. export HELM_HOST="$(minishift ip):$(oc get svc/tiller -o jsonpath='{.spec.ports[0].nodePort}' -n kube-system --as=system:admin)"
 1. export MINISHIFT_ADMIN_CONTEXT="default/$(oc config view -o jsonpath='{.contexts[?(@.name=="minishift")].context.cluster}')/system:admin"
