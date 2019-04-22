# Origin Continuous Deployment (OCD) - Git driven DevOps on Origin

Origin Continuous Deployment (OCD) is tooling to build, configure and repeatably deploy applications on [Origin Kubernetes Distribution](https://okd.io) and [Red Hat OpenShift](https://www.openshift.com) driven by git webhooks. OCD lets you live the dream of self-service immutable infrastruture as code running on Kubernetes. 

It can:

 1. Automate that pushing a git tag will s2i build your code into a container image and then apply the same tag to the container image. 
 1. Automate that pushing configuration to an ”environment” git repo will reconfigure the environment.

Using those to simple primatives gives:

 * Containers with tags that match your git tags that can be moved into environments by git push / PR merge of single line changs to yaml files. 
 * History of the deployed versions of applications with the ability to rollback to prior versions.
 * History of the configuration within each environment with the ability to rollback to prior versions.
 
OCD uses high level [OKD](https://www.okd.io) container build features, deployed using generic [Helm](https://github.com/helm/helm) charts, organised into high level releases using [Helmfile](https://github.com/roboll/helmfile), properly encrypted into git,  using simple bash scripts, called by [adnanh/webhook](https://github.com/adnanh/webhook). OCD provides strong conventions and generic building blocks that can deliver "application infrastructure as code" with complete git driven automation. 

OCD is also chatbot friendly. We use a botkit slackbot that creates git releases and PRs to upgrade apps. This means team members who are not developers can move the code they tested into production. This is known as ChatOps.

See [the wiki](https://github.com/ocd-scm/ocd-meta/wiki) for more details including how to run the demo on either minishift or openshift online pro.

![ocd environment sequence diagram](https://ocd-scm.github.io/ocd-meta/imgs/ocd-environment-sequence.png)

The sequence diagram gives above an overview of how pushing changes to one or more helmfile.yaml config files in a config git repo automatically updates chart releases within openshift. Your helmfile.yaml can install any helm charts you like from the public chart repositories. OCD provides its own chart repository that is setup by default that includes generic charts that: 

* Release or update many `ConfigMaps` that can configure deployments or builds
* Release or update many `Secrets` that can configure deployments. The contents of the secrets are encrypted in git using either the helm secrets plugin or git-secret. 
* Release or update many `DeploymentConfigs` that run any 12factor.net app that is configured using `ConfigMaps` and `Secrets`
* Release or update many `BuildConfig` that watch for git tags in your microservice code repos then build that tag and tag the resultant container image with the same tag. You can then use the same tags in helmfile yaml that configures your deployments in all your environments. 

Since OCD builds and promotes your code based on git tags it can fully manage your deployments based on git tags. You can keep on using whatever branch strategies you want and whatever continuous build and test  system you like. When you are happy to release just tag your code. OCD will create a container image containing the tagged code and tag that container image with the git tag. Then you just put that tag number in the helmfile.yaml in the git repo that defines all the config for a given environment and OCD will update the environment to run that code. 

## This Repo

This repo is used to publish the Helm charts that OCD uses to install webook handlers, secrets and generic s2i builders. You can use any 3rd party helm charts with OCD. You may find it convenient to use the OCD charts if you run 12factor apps. You don't need to use s2i to build your containers. The OCD builder charts are simply provided to make it easy to build containers from git release tags that are tagged with the same tag if you want to do that. You can use whatever CI build tool you want that can run in parallel to OCD. 

This repo also hosts the main wiki that documents how to use all the OCD components that are within the same GitHub organisation.

## Status

We have cut over two thirds of our production apps onto OCD and have released v1.0.0 of the charts. 🍾


## Support Origin Versions

We test on: 

 * [Minishift](https://github.com/ocd-scm/ocd-meta/wiki/Minishift) with Openshift v3.11.0
 * Openshift Online Pro which periodically updates which version of Red Hat OpenShift Container Platform it is running. The techniques used by OCD were perfected running a business on openshift.com.
 
Online Pro is a multi-tenant set up with no admin access for tenants. As we test there we can expect OCD to work fine with any less locked down OKD or RCP on-prem, dedicated or managed cluster. 

## Getting Started

The [wiki](https://github.com/ocd-scm/ocd-meta/wiki) has tutorials of setting up a ReactJS demo app on both minishift and openshift online pro.
