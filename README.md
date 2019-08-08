# Privacy Lx devops repository

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

`cd ansible && ansible-playbook --vault-id @prompt deploy-website.yml`

## Naming convention

Server hostnames used from the list of
[whistleblowers](https://en.wikipedia.org/wiki/List_of_whistleblowers).
