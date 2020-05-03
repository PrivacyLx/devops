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

### Matterbridge

It currently bridges PrivacyLx IRC <-> Matrix internal chat rooms. It can be
extended to support more networks and bridges can be added by configuring
`matterbridge/templates/matterbridge.toml.j2`.

#### Deploying matterbridge

`cd ansible && ansible-playbook --vault-id @prompt -i inventory/production deploy-matterbridge.yml`

**Note:** Matterbridge config (template) file `matterbridge.toml.j2` should
placed under the `host_vars` directive for the specified host,

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

`cd ansible && ansible-playbook --vault-id @prompt -i inventory/production deploy-update.yml --extra-vars=reboot_enabled=true`

### Deploy BigBlueButton

`cd ansible && ansible-playbook --vault-id @prompt -i inventory/production deploy-bigbluebutton.yml`

## Adding SSH fingerprints to known hosts

1. Get an SSH fingerprint from a local `known_hosts` file for a given hostname
   and IP:

`ssh-keygen -q -f ~/.ssh/known_hosts -F hostname/IP -F $(dig +short A hostname)`

2. Upon verifying add the SSH fingeprints one per line (or seraparated by comma
   if is same host, see `ansible/ssh/known_hosts`).

## Help

Useful commands and documentation to help you debug and test roles.

List almost all group/host variables:

`ansible --vault-id @prompt -i inventory/testing -m debug group/host -a "var=vars"`

### Ansible vault

Use `encrypt_string` to create encrypted variables to embed in inventory file:

`ansible-vault encrypt_string --vault-id prompt --stdin-name 'variable_name'`

**Note:** Do not press Enter after supplying the string. That will add a newline
to the encrypted value.

### Docs

- [Ansible Documentation: Playbook Filters](https://docs.ansible.com/ansible/latest/user_guide/playbooks_filters.html)
- [Ansible Documentation: Using Variables]( https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html)
- [Ansible Documentation: Special Variables](https://docs.ansible.com/ansible/latest/reference_appendices/special_variables.html)
- [Ansible Documentation: Vault](https://docs.ansible.com/ansible/latest/user_guide/vault.html)

## Naming convention

Server hostnames used from the list of
[whistleblowers](https://en.wikipedia.org/wiki/List_of_whistleblowers).
