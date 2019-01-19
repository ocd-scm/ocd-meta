# Origin Continuous Delivery (OCD) - Git driven DevOps on Origin

Origin Continuous Delivery (OCD) is tooling to build, configure and repeatably deploy applications on [Origin Kubernetes Distribution](https://okd.io) and [Red Hat OpenShift](https://www.openshift.com) driven by git webhooks. This lets you live the dream of self-service immutable infrastruture as code running on Kubernetes. 

It can:

 1. Automate that pushing a git tag will s2i build your code into a container image and then apply the same tag to the container image. 
 1. Automate that pushing configuration to an ”environment” git repo will reconfigure the environment.

Using those to simple primatives gives:

 * Deployment of a specific verion of one or more applications by simply applying git tags to simple yaml files.
 * History of the deployed versions of applications with the ability to rollback to prior versions.
 * History of the configuration within each environment with the ability to rollback to prior versions.
 
OCD uses high level [OKD](https://www.okd.io) container build features, deployed using generic Helm charts, using simple bash scripts, called by [adnanh/webhook](https://github.com/adnanh/webhook). OCD provides strong conventions and generic building blocks that can deliver "application infrastructure as code" with complete git driven automation. 

See [the wiki](https://github.com/ocd-scm/ocd-meta/wiki) for more details.

## Support Origin Versions

We test on: 

 * [Minishift](https://github.com/ocd-scm/ocd-meta/wiki/Minishift) with Openshift v3.11.0
 * _Coming soon_: Openshift Online Pro which periodically updates which version of Red Hat OpenShift Container Platform it is running. The techniques used by OCD were perfected running a business on openshift.com.
 
See [the wiki](https://github.com/ocd-scm/ocd-meta/wiki) for more details.
