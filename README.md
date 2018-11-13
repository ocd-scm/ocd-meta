# ocd-meta

## Start A Cluster

Assuming you want may want to deploy in openshift.com signup for the account then download the command-line tool "oc" that is current. Then simply run `oc cluster up`. Note on Mac with Docker 18.03 then [there are issues](https://github.com/openshift/origin/issues/18596) so you may need to run `oc cluster up --create-machine` 
