#!/bin/bash
####
####

SPLUNKARCHLAB_BASE=splunkarchlab_base

rm -rf splunk*

sudo yum -y install git gcc openssl-devel

git clone https://github.com/wsoyinka/splunkarchlab1.git  $SPLUNKARCHLAB_BASE

