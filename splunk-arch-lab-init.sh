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
