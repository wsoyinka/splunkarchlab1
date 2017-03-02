#!/bin/bash
####
####

#set -o errexit
#set -o pipefail


### With everything being equal, this bash script will automatically setup the environment
### need to do the following

### setup virtualenv
## install ansible in the virtual env
## clone ws's remote git repo which creates and automates the setup of the splunk arch lab servers insfrastructure
##  i.e. the searchhead server, the forwarders  and the indexers
###   The roles have been created along the functions of each server.
##
#### The env/vars.yml file contains splunk aws credentials and so it has been excluded or commented out of
### publicly viewable git repo
###  The env/vars.yml file is an **importantant** component for this script to work.


SPLUNKARCHLAB_DIR=splunkarchlab


git clone https://github.com/wsoyinka/splunkarchlab1.git  $SPLUNKARCHLAB_DIR

virtualenv  -p python2.7 $SPLUNKARCHLAB_DIR

cd  $SPLUNKARCHLAB_DIR

source bin/activate

pwd

pip -q install ansible




ansible-playbook site.yml --tag downloadufwget,installuf   -l  forwarders

ansible-playbook site.yml --tag set_root_dir,start_uf,start_uf_boot   -l  forwarders

ansible-playbook site.yml --tag set_password1  -l  forwarders




#ansible-playbook site.yml --tag configure_uf_d_cli   -l  forwarders


###  searchhead

#ansible-playbook site.yml --tag add_indexer1,add_indexer2  -l  searchhead


#### INDEXERS



#ansible-playbook site.yml --tag start_splunk,start_splunk_boot,set_root_dir,set_password_in  -l indexers

## indexer1

#sudo  /opt/splunk/bin/splunk set servername  soyinka-indexer1   -auth admin:ExpertInsight

#sudo  /opt/splunk/bin/splunk set default-hostnampse  soyinka-indexer1   -auth admin:ExpertInsight


## indexer2

#sudo  /opt/splunk/bin/splunk set servername  soyinka-indexer2   -auth admin:ExpertInsight

#sudo  /opt/splunk/bin/splunk set default-hostname  soyinka-indexer2   -auth admin:ExpertInsight