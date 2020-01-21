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

### Admin role

This role is used to add/remove users, groups, permissions rights and access to
hosts. You can deploy this role by running:

`cd ansible && ansible-playbook --vault-id @prompt -i inventory/production deploy-admin.yml`

#### Add a user to all hosts

In order to add a user to all the hosts managed by Ansible you need to add the
user name (`login`), `comment`, `state` (`present` or `absent`) and the public
SSH key (`sshkey`) of a specified user to `users.yml` inventory file.

**The public SSH key should be entered in encrypted format by using the vault.**

To generate the SSH public key you should use the `ansible-vault`
(encryption/decryption utility for Ansible data files), an example command looks
like:

`ansible-vault encrypt_string --vault-id @prompt 'ssh-ed25519 XXX' --name sshkey`

Example of `users.yml` that will add the user `exampleusr`:

```
adm_acct:
  exampleusr
    login: exampleusr
    comment: 'This is an example user'
    state: present
    sshkey: !vault |
          $ANSIBLE_VAULT;1.1;AES256
          8037128907389897892223332
```

#### Adding a user to the admin group

Users (given that are previously added and `present` at a host) may be added in
`adm_logins` (allowed to sudo).
Example:

`adm_logins: [ exampleusr1,exampleusr2 ]`

### Updates

This role deploys unattended updates and updates all system packages in all hosts
and reboots the host if it's required (set `reboot_enabled` to `true`).

#### Deploying updates

`cd ansible && ansible-playbook --vault-id @prompt -i inventory/production deploy-update.yml`

Running the role with `reboot_enabled` will reboot a host that requires reboot
after package upgrades:

`cd ansible && ansible-playbook -i inventory/production deploy-update.yml --extra-vars=reboot_enabled=true`

## Adding SSH fingerprints to known hosts

1. Get an SSH fingerprint from a local `known_hosts` file for a given hostname
   and IP:

`ssh-keygen -q -f ~/.ssh/known_hosts -F hostname/IP -F $(dig +short A hostname)`

2. Upon verifying add the SSH fingeprints one per line (or seraparated by comma
   if is same host, see `ansible/ssh/known_hosts`).

## Naming convention

Server hostnames used from the list of
[whistleblowers](https://en.wikipedia.org/wiki/List_of_whistleblowers).
