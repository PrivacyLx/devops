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

`cd ansible && ansible-playbook --vault-id @prompt deploy-discourse.yml`

### Mailserver

`cd ansible && ansible-playbook --vault-id @prompt deploy-mailserver.yml`

### Website

Deployment and testing of our website: [privacylx.org](https://privacylx.org)

#### Deploying website

`cd ansible && ansible-playbook --vault-id @prompt deploy-website.yml`

#### Testing Website

This deploys the website on a testing server. You can access it via [testing.privacylx.org](https://testing.privacylx.org)

1. edit your ssh-config file (`~/.ssh/config`) to add the hostname, your ssh key and the user
2. `cd ansible/`
3. deploy testing environment with `ansible-playbook test-website.yml -i inventory/testing/hosts`

## Naming convention

Server hostnames used from the list of
[whistleblowers](https://en.wikipedia.org/wiki/List_of_whistleblowers).
