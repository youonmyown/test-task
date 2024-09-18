#!/bin/bash

elastic_ip=$(terraform output -raw elastic_ip)

echo "[webserver]" > hosts
echo "$elastic_ip ansible_python_interpreter=/usr/bin/python3" >> hosts

ansible-playbook -i "$elastic_ip," site.yml
if [ $? -ne 0 ]; then
  echo "Ansible playbook execution failed."
  exit 1
fi

ssh -i ./griga-key.pem -o StrictHostKeyChecking=no ubuntu@$elastic_ip "ls -ld /var/www/html/wordpress"
ssh -i ./griga-key.pem -o StrictHostKeyChecking=no ubuntu@$elastic_ip "sudo chmod 777 /var/www/html/wordpress"
rsync -avz -e "ssh -i ./griga-key.pem -o StrictHostKeyChecking=no" ./website/ ubuntu@$elastic_ip:/var/www/html/wordpress/
if [ $? -ne 0 ]; then
  echo "Failed to copy website folder via SCP."
  exit 1
fi

echo "Deployment completed successfully."
