#!/bin/bash

#ansible -i hosts Debian10 -m ping
ansible -i inventory Debian10 -m ping