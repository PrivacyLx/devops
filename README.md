# Privacy Lx devops repository

## Getting Started

1. clone this repo
2. intialize its submodules with `git submodule update --init --recursive`
3. install ansible
4. Deploy the infrastructure wanted as explained bellow


## Deploy ansible roles

**Note**: You will be prompted for Ansible's vault password

### Discourse

`cd ansible && ansible-playbook --vault-id @prompt deploy-discourse.yml`

### Mailserver

`cd ansible && ansible-playbook --vault-id @prompt deploy-mailserver.yml`

### Website

`cd ansible && ansible-playbook --vault-id @prompt deploy-website.yml`

## Adding SSH known hosts

Get a fingerprint of local `known_hosts` file for a given hostname:
`ssh-keygen -l -f ~/.ssh/known_hosts -F hostname`

Add the specified fingerprint line to the ansible `known_hosts` file:
`ansible-playbook --vault-id @prompt edit ansible/ssh/known_hosts`

## Naming convention

Server hostnames used from the list of
[whistleblowers](https://en.wikipedia.org/wiki/List_of_whistleblowers).
