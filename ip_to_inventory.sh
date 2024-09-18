#!/bin/bash

elastic_ip=$(terraform output -raw elastic_ip)

echo "[webserver]" > hosts
echo "$elastic_ip ansible_python_interpreter=/usr/bin/python3" >> hosts
