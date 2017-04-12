#!/bin/bash
####
####

set -o errexit
#set -o pipefail


### With everything being equal, this bash script will automatically setup the environment
### need to do the following

### setup virtualenv
## install ansible in the virtual env
## clone ws's remote git repo which creates and automates the setup of the splunk arch lab servers insfrastructure
##  i.e. the searchhead, the forwarders  and the indexers
###   The roles have been created along the functions of each server.
##
#### The env/vars.yml file contains sensitive credentials/info that has been encrypted before storing on this public git repo
###  The env/vars.yml file is an **importantant** component for this script to work.

SPLUNKARCHLAB_BASE=splunkarchlab_base
SPLUNKARCHLAB_DIR=splunkarchlab

install_ansible_searchhead()
{
  #cd ~/$SPLUNKARCHLAB_BASE 
  virtualenv  -p python2.7 $SPLUNKARCHLAB_DIR
  source $SPLUNKARCHLAB_DIR/bin/activate
  pip install --upgrade pip
  pwd
  pip -q install ansible
  ansible -m ping   localhost
}

enable_virtualenv()
{
 source $SPLUNKARCHLAB_DIR/bin/activate
}

case  "$1" in
  install_ansible)
    install_ansible_searchhead
    ;;
  setup_sh)
      setup_searchhead()
      {
        enable_virtualenv
        ansible-vault decrypt  env/vars.yml --ask-vault-pass
        ansible-playbook  site.yml --tag searchhead_role --skip-tags add_indexers_to_sh,set_route,create_idx_app -l  searchheads
        #ansible-playbook  site.yml --ask-vault-pass --tag searchhead_role --skip-tags add_indexers_to_sh,set_route -l  searchheads
        ansible-playbook site.yml --tag set_route -l  forwarders
        ansible-playbook site.yml --tag set_route -l  indexers
      #  ansible-playbook site.yml --tag add_indexers_to_sh -l  searchheads
      #  ansible-playbook site.yml --tag add_indexers_to_sh -l  searchheads
      }
      setup_searchhead
      ;;
   setup_fwds)
      setup_fwds()
      {
        enable_virtualenv
       # ansible-vault decrypt  env/vars.yml 
     #   ansible-playbook site.yml --tag createuser,sshid  -l  forwarders
        ansible-playbook site.yml --tag sshid_fwds  -l  searchheads
        ansible-playbook -v site.yml --tag forwarders_role --skip-tags set_fwd1_hostname,set_fwd2_hostname -l forwarders
        ansible-playbook -v site.yml --tag  setsplunk-hostname_fwd1 -l fwd1
        ansible-playbook -v site.yml --tag  set_fwd1_hostname -l fwd1
        ansible-playbook -v site.yml --tag  setsplunk-hostname_fwd2 -l fwd2
        ansible-playbook -v site.yml --tag  set_fwd2_hostname -l fwd2
        # ansible-playbook -v site.yml --tag forwarders_role   --skip-tags set_password1,stop_uf  -l forwarders
      }
      setup_fwds
      ;;
   setup_idxs)
      setup_idxs()
      {
        enable_virtualenv
       # ansible-vault decrypt  env/vars.yml 
     #   ansible-playbook site.yml --tag createuser,sshid  -l  forwarders
        ansible-playbook site.yml --tag sshid_idxs  -l  searchheads
        ansible-playbook -v site.yml --tag indexers_role --skip-tags set_idx1_hostname,set_idx2_hostname  -l indexers
        ansible-playbook -v site.yml --tag  setsplunk-hostname_idx1 -l idx1
        ansible-playbook -v site.yml --tag  set_idx1_hostname -l idx1
        ansible-playbook -v site.yml --tag  setsplunk-hostname_idx2 -l idx2
        ansible-playbook -v site.yml --tag  set_idx2_hostname -l idx2
        # ansible-playbook -v site.yml --tag forwarders_role   --skip-tags set_password1,stop_uf  -l forwarders
      }
      setup_idxs
      ;;
   config_sh_2)
     config_sh_2()
     {
        enable_virtualenv
       # ansible-vault decrypt  env/vars.yml --ask-vault-pass
        ansible-playbook site.yml --tag add_indexers_to_sh -l  searchheads
        ansible-playbook site.yml --tag create_idx_app -l  searchheads
        ansible-playbook site.yml --tag create_inputs_fwd1_app -l  searchheads
        ansible-playbook site.yml --tag create_inputs_fwd2_app -l  searchheads

     }
     config_sh_2
     ;;
   create_diag)
     create_diag()
     {
       ansible-playbook site.yml --tag run_diag
     }
    create_diag
    ;;
   ping_sh)
      enable_virtualenv
      ansible all -m ping
      ;;
   ping_fwds)
      enable_virtualenv
      ansible  forwarders -m ping
      ;;
    ping_idxs)
      enable_virtualenv
      ansible  indexers -m ping
      ;;
    *)
       echo $"Usage: $0 {install_ansible | setup_sh | setup_fwds | setup_idxs | ping_sh | ping_fwds| ping_idxs | config_sh_2 | create_diag }"
       exit 1
esac


