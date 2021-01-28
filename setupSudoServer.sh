#!/bin/bash
#Run the playbook to setup sudo on the Server
#ansible-playbook -i hosts -K tasks/sudo.yml
ansible-playbook -i inventory -K tasks/sudo.yml 