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

`cd ansible && ansible-playbook -i inventory/production deploy-discourse.yml`

### Mailserver

`cd ansible && ansible-playbook -i inventory/production deploy-mailserver.yml`

#### Update mailserver

Run only the update task:

`cd ansible && ansible-playbook -i inventory/production deploy-mailserver.yml --tags update`

### Website

Deployment and testing of our website: [privacylx.org](https://privacylx.org)

#### Deploying website

`cd ansible && ansible-playbook -i inventory/production deploy-website.yml`

#### Deploying testing website

This deploys the website on a testing server. You can access it via [testing.privacylx.org](https://testing.privacylx.org)

1. edit your ssh-config file (`~/.ssh/config`) to add the hostname, your ssh key and the user
2. `cd ansible && ansible-playbook -i inventory/testing deploy-website.yml`

### Matterbridge

It currently bridges PrivacyLx IRC <-> Matrix internal chat rooms. It can be
extended to support more networks and bridges can be added by configuring
`matterbridge/templates/matterbridge.toml.j2`.

#### Deploying matterbridge

`cd ansible && ansible-playbook -i inventory/production deploy-matterbridge.yml`

**Note:** Matterbridge config (template) file `matterbridge.toml.j2` should
placed under the `host_vars` directive for the specified host,

### Admin role

This role is used to add/remove users, groups, permissions rights and access to
hosts. You can deploy this role by running:

`cd ansible && ansible-playbook -i inventory/production deploy-admin.yml`

#### Add a user to all hosts

In order to add a user to all the hosts managed by Ansible you need to add the
user name (`login`), `comment`, `state` (`present` or `absent`) and the public
SSH key (`sshkey`) of a specified user to `users.yml` inventory file.

**The public SSH key should be entered in encrypted format by using the vault.**

To generate the SSH public key you should use the `ansible-vault`
(encryption/decryption utility for Ansible data files), an example command looks
like:

`ansible-vault encrypt_string 'ssh-ed25519 XXX' --name sshkey`

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

#### Deploy updates to all servers

The following command updates all servers distributions (including mailcow):

`cd ansible && ansible-playbook -i inventory/production deploy-update.yml`

### Deploy BigBlueButton

`cd ansible && ansible-playbook -i inventory/production deploy-bigbluebutton.yml`

## Adding SSH fingerprints to known hosts

1. Get an SSH fingerprint from a local `known_hosts` file for a given hostname
   and IP:

`ssh-keygen -q -f ~/.ssh/known_hosts -F hostname/IP -F $(dig +short A hostname)`

2. Upon verifying add the SSH fingeprints one per line (or seraparated by comma
   if is same host, see `ansible/ssh/known_hosts`).

## Ansible vault

We are using a multi-key encryption via GPG. The ansible-vault decryption is
handled automatically in Ansible with the use of `open_vault.sh` script which
decrypts the vault password and feeds it to the Ansible role.

In order to add/remove the recipients of the GPG encrypted vault file
`vault_pass.gpg` add/remove the `--recipient-file` parameter with the
appropriate GPG public key file stored in `ansible/gpg` directory.

You may use the following commands to re-encrypt the encrypted vault password
with the desired recipients GPG public key(s).

Note: *In case you are using a Qubes GPG split VM replace the command `gpg` with
`qubes-gpg-client` in line 2*

```
mv ansible/gpg/vault_pass.gpg ansible/gpg/vault_pass_old.gpg && \
    qubes-gpg-client --batch --yes --decrypt ansible/gpg/vault_pass_old.gpg |
    gpg --batch --verbose --yes --armor --encrypt \
        --recipient-file ansible/gpg/anadahz.asc \
        --recipient-file ansible/gpg/core.asc \
        --output ansible/gpg/vault_pass.gpg && \
            rm ansible/gpg/vault_pass_old.gpg
```

## Help

Useful commands and documentation to help you debug and test roles.

List almost all group/host variables:

`ansible -i inventory/testing -m debug group/host -a "var=vars"`

### Ansible vault

#### Create encrypted strings

Use `encrypt_string` to create encrypted variables to embed in inventory file:

`ansible-vault encrypt_string --stdin-name 'variable_name'`

**Note:** Do not press Enter after supplying the string. That will add a newline
to the encrypted value.

#### View encrypted strings

You can view the original value of an encrypted string by using the debug module:

`ansible localhost -m debug -a var="variable_name" -e "@ansible/inventory/testing/group_vars/all/vars.yml"`

### Docs

- [Ansible Documentation: Playbook Filters](https://docs.ansible.com/ansible/latest/user_guide/playbooks_filters.html)
- [Ansible Documentation: Using Variables]( https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html)
- [Ansible Documentation: Special Variables](https://docs.ansible.com/ansible/latest/reference_appendices/special_variables.html)
- [Ansible Documentation: Vault](https://docs.ansible.com/ansible/latest/user_guide/vault.html)

## Naming convention

Server hostnames used from the list of
[whistleblowers](https://en.wikipedia.org/wiki/List_of_whistleblowers).
