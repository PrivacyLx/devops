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

#### Deploying matterbridge

`cd ansible && ansible-playbook --vault-id @prompt -i inventory/production deploy-matterbridge.yml`

It currently bridges PrivacyLx IRC <-> Matrix internal chat rooms. It can be
extended to support more networks and bridges can be added by configuring
`matterbridge/templates/matterbridge.toml.j2`.

## Adding SSH fingerprints to known hosts

1. Get an SSH fingerprint from a local `known_hosts` file for a given hostname
   and IP:

`ssh-keygen -q -f ~/.ssh/known_hosts -F hostname/IP -F $(dig +short A hostname)`

2. Upon verifying add the SSH fingeprints one per line (or seraparated by comma
   if is same host, see `ansible/ssh/known_hosts`).

## Naming convention

Server hostnames used from the list of
[whistleblowers](https://en.wikipedia.org/wiki/List_of_whistleblowers).
