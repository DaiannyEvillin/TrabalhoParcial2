#!/bin/bash

# Atualizar repositórios e pacotes
sudo apt-get update

# Instalar o Ansible
sudo apt-get install -y ansible

# Executa o playbook do Ansible
ansible-playbook -i "localhost," -c local playbook.yml

