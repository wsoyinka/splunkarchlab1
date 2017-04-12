#!/bin/bash
####
####

SPLUNKARCHLAB_BASE=splunkarchlab_base

rm -rf splunk*

sudo yum -y install tmux git gcc openssl-devel virtualenv

git clone https://github.com/wsoyinka/splunkarchlab1.git  $SPLUNKARCHLAB_BASE

