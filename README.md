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

Fully deploy the website:
`cd ansible && ansible-playbook --vault-id @prompt deploy-website.yml`

Update the website:
`cd ansible && ansible-playbook --vault-id @prompt deploy-website.yml --tags "update"`


## Naming convention

Server hostnames used from the list of
[whistleblowers](https://en.wikipedia.org/wiki/List_of_whistleblowers).
