# Origin Continuous Delivery (OCD) - Git driven DevOps on Origin

Origin Continuous Delivery (OCD) is opinionated tooling to build, configure and deploy [12 factor apps](http://12factor.net) on [Origin Kubernetes Distribution](https://okd.io) and [Red Hat OpenShift](https://www.openshift.com) driven by git webhooks. It will:

 1. Automate that pushing a git tag will s2i build your code into a container image and then apply the same tag to the image. 
 1. Automate that pushing configuration to an environments git repo will reconfigure the environment.

Using those to simple primatives gives:

 * Deployment of a specific verion of one or more applications by simply applying git tags to yaml files.
 * History of all deployed versions of all applications with the ability to rollback to prior versions.
 * History of all configuration within each environment with the ability to rollback to prior versions.
 
OCD uses high level [OKD](https://www.okd.io) container build features, Helm charts, command-line tools and [adnanh/webhook](https://github.com/adnanh/webhook). It is implimented as a minimal set of simple bash scripts that together deliver "application infrastructure as code" with complete git driven automation. 

See [the wiki](https://github.com/ocd-scm/ocd-meta/wiki) for more details.

## Support Origin Versions

We test on: 

 * Minishift with Openshift v3.9.0 because the minishift helm addon is broken with OpenShift 3.10 and 3.11
 * _Coming soon_ Openshift Online Pro which periodiclaly updates which version of Red Hat OpenShift Container Platform it is running
 
See [the wiki](https://github.com/ocd-scm/ocd-meta/wiki) for more details.
