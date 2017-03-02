#!/bin/bash
####
####

#set -o errexit
#set -o pipefail


virtualenv  -p python2.7 splunkarchlab

source splunkarchlab/bin/activate



pip -q install ansible


ansible-playbook site.yml --tag downloadufwget,installuf   -l  forwarders

ansible-playbook site.yml --tag set_root_dir,start_uf,start_uf_boot   -l  forwarders

ansible-playbook site.yml --tag set_password1  -l  forwarders

ansible-playbook site.yml --tag configure_uf_d_cli   -l  forwarders


#### INDEXERS



## indexer1

sudo  /opt/splunk/bin/splunk set servername  soyinka-indexer1   -auth admin:ExpertInsight

sudo  /opt/splunk/bin/splunk set default-hostname  soyinka-indexer1   -auth admin:ExpertInsight


## indexer2

sudo  /opt/splunk/bin/splunk set servername  soyinka-indexer2   -auth admin:ExpertInsight

sudo  /opt/splunk/bin/splunk set default-hostname  soyinka-indexer2   -auth admin:ExpertInsight
