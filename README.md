# Privacy Lx devops repository

## Requirements

It is assumed that you have a GNU/Linux environment 

## Getting Started

1. Clone this repository
2. Install ansible
3. Deploy the infrastructure wanted as explained bellow

## Deploy ansible roles

**Note**: You will be prompted for Ansible's vault password

### Discourse

`cd ansible && ansible-playbook --vault-id @prompt -i inventory/production deploy-discourse.yml`

### Mailserver

`cd ansible && ansible-playbook --vault-id @prompt -i inventory/production deploy-mailserver.yml`

### Website

Deployment and testing of our website: [privacylx.org](https://privacylx.org)

#### Deploying website

`cd ansible && ansible-playbook --vault-id @prompt -i inventory/production deploy-website.yml`

#### Deploying testing website

This deploys the website on a testing server. You can access it via [testing.privacylx.org](https://testing.privacylx.org)

1. edit your ssh-config file (`~/.ssh/config`) to add the hostname, your ssh key and the user
2. `cd ansible && ansible-playbook --vault-id @prompt -i inventory/testing deploy-website.yml`

## Adding SSH known hosts

1. Get an SSH fingerprint of local `known_hosts` file for a given hostname:
`ssh-keygen -q -f ~/.ssh/known_hosts -F hostname`

2. Add an SSH fingerprint line to the ansible `known_hosts` file:
`ssh-keygen -q -f ~/.ssh/known_hosts -F hostname`

## Naming convention

Server hostnames used from the list of
[whistleblowers](https://en.wikipedia.org/wiki/List_of_whistleblowers).
