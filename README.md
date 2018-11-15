# ocd-meta

## Support Versions

We test on: 

 * Openshift Online Pro (which periodiclaly updates which OCP it is running)
 * Minishift

## Minishift

Starting up openshift on your laptop using Docker For Mac can be a pain as [there are issues](https://github.com/openshift/origin/issues/18596). [Minishift](https://docs.okd.io/latest/minishift/getting-started/installing.html) works at this time and has a [helm addon](https://github.com/minishift/minishift-addons/tree/master/add-ons/helm). 

### Minishift on MacOS

Note that Safari doesn't like the ssl cert you will have to use Chrome to run the web console. First startup does a lot downloads: 

 1. minishift start --vm-driver=virtualbox --profile ocd --cpus=2 --memory=8192
 1. minishift addons install --defaults
 1. minishift addons enable admin-user
 1. git clone https://github.com/minishift/minishift-addons.git
 1. minishift addons install minishift-addons/add-ons/helm
 1. minishift addons apply helm
 1. eval $(minishift oc-env)
 1. oc login -u system:admin
