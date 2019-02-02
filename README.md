# Origin Continuous Deployment (OCD) - Git driven DevOps on Origin

Origin Continuous Deployment (OCD) is tooling to build, configure and repeatably deploy applications on [Origin Kubernetes Distribution](https://okd.io) and [Red Hat OpenShift](https://www.openshift.com) driven by git webhooks. This lets you live the dream of self-service immutable infrastruture as code running on Kubernetes. 

It can:

 1. Automate that pushing a git tag will s2i build your code into a container image and then apply the same tag to the container image. 
 1. Automate that pushing configuration to an ”environment” git repo will reconfigure the environment.

Using those to simple primatives gives:

 * Deployment of a specific verion of one or more applications by simply applying git tags to simple yaml files.
 * History of the deployed versions of applications with the ability to rollback to prior versions.
 * History of the configuration within each environment with the ability to rollback to prior versions.
 
OCD uses high level [OKD](https://www.okd.io) container build features, deployed using generic Helm charts, using simple bash scripts, called by [adnanh/webhook](https://github.com/adnanh/webhook). OCD provides strong conventions and generic building blocks that can deliver "application infrastructure as code" with complete git driven automation. 

See [the wiki](https://github.com/ocd-scm/ocd-meta/wiki) for more details including how to run the demo on either minishift or openshift online pro.

![ocd environment sequence diagram](https://ocd-scm.github.io/ocd-meta/imgs/ocd-environment-sequence.png)

The sequence diagram gives above an overview of how pushing changes to one or more helmfile.yaml config files in a config git repo automatically updates chart releases within openshift. Your helmfile.yaml can install any helm charts you like from the public chart repositories. OCD provides its own chart repository that is setup by default that includes generic charts that: 

* Release or update many `ConfigMaps` that can configure deployments or builds
* Release or update many `Secrets` that can configure deployments. The contents of the secrets are encrypted in git using either the helm secrets plugin or git-secret. 
* Release or update many `DeploymentConfigs` that run any 12factor.net app that is configured using `ConfigMaps` and `Secrets`
* Release or update many `BuildConfig` that watch for git tags in your microservice code repos then build that tag and tag the resultant container image with the same tag 

Since OCD builds and promotes your code based on git tags it can fully manage your deployments based on git tags. You can keep on using whatever branch strategies you want and whatever continuous integration and testing build system you like. When you are happy to release just tag your code to build a container in openshift with that code then change the helmfile.yaml to run and configure that code in each openshift environment. 

## Support Origin Versions

We test on: 

 * [Minishift](https://github.com/ocd-scm/ocd-meta/wiki/Minishift) with Openshift v3.11.0
 * Openshift Online Pro which periodically updates which version of Red Hat OpenShift Container Platform it is running. The techniques used by OCD were perfected running a business on openshift.com.
 
Online Pro is a multi-tenant set up with no admin access for tenants. As we test there we can expect OCD to work fine with any less locked down OKD or RCP on-prem, dedicated or managed cluster. 
 
See [the wiki](https://github.com/ocd-scm/ocd-meta/wiki) for more details.
