#!/bin/bash
####
####

SPLUNKARCHLAB_BASE=splunkarchlab_base

rm -rf splunk*

sudo yum -y install git gcc openssl-devel

git clone https://github.com/wsoyinka/splunkarchlab1.git  $SPLUNKARCHLAB_BASE


#wget -O splunk-arch-lab-init.sh  "https://raw.githubusercontent.com/wsoyinka/splunkarchlab1/master/splunk-arch-lab-init.sh"

#chmod 755 splunk-arch-lab-init.sh
