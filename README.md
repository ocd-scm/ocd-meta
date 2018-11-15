# ocd-meta

## Support Versions

We test on: 

 * Openshift Online Pro (which periodiclaly updates which OCP it is running)
 * Minishift

## Minishift

Starting up openshift on your laptop using Docker For Mac can be a pain as [there are issues](https://github.com/openshift/origin/issues/18596). [Minishift](https://docs.okd.io/latest/minishift/getting-started/installing.html) works at this time and has a [helm addon](https://github.com/minishift/minishift-addons/tree/master/add-ons/helm). 

### Minishift on MacOS

Note that Safari doesn't like the ssl cert you will have to use Chrome to run the web console. First startup does a lot downloads: 

 1. brew cask install minishift
 1. brew install docker-machine-driver-xhyve
 1. sudo chown root:wheel /usr/local/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
 1. sudo chmod u+s /usr/local/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
 1. minishift addons install --defaults
 1. minishift addons enable admin-user
 1. minishift start
 1. eval $(minishift oc-env)
 1. oc login -u system:admin
 
If you can `oc` into it and see the console you are now ready to add helm:

 1. minishift stop
 1. minishift start --profile minishift --disk-size 40gb --memory 4096mb
 1. git clone https://github.com/minishift/minishift-addons.git
 1. minishift addons install minishift-addons/add-ons/helm
 1. minishift addons apply helm
 
 
