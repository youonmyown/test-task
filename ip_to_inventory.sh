#!/bin/bash

elastic_ip=$(terraform output -raw elastic_ip)

ansible-playbook -i $elastic_ip site.yml
