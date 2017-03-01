#!/bin/bash
#### 
####

#set -o errexit
#set -o pipefail


virtualenv  -p python2.7 splunkarchlab

source splunkarchlab/bin/activate

pip -q install ansible
