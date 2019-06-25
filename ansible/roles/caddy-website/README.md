# Caddy Website
This ansible role compiles the latest version of caddy disabling telemetry

> Previously the caddy server was being built from source but since then,
it has broken and so now it is fetched in binary form.

This role preforms the following tasks:
  - fetches the latest version of the website
  - uses [hugo](https://gohugo.io) to build it into static html (using docker)
  - installs caddy server and puts the website live with https
  - configures .onion v2 and v3 for the website provided the urls and private keys
  - updates website from the source hourly (runs template update-script.sh)

## Variables

    # remote git repo for the website
    hugo_website_git_repo: 'https://github.com/org/repo.git'

    # website's domains / tor onion services
    website_domain: 'example.com'
    website_onion_v2: 'http://ojr4ex25mf4tuxtm.onion/'
    website_onion_v3: 'http://p2jpwodl3q3kghx562tiuxert6azh4tpwz4hcu5jcypbckaqigcjf4qd.onion/'

    # email used for let's encrypt domain
    le_email: "contact@example.com"

    # Let's Encrypt HTTPs certificate
    # set to true - when testing the server configurations
    # set to false - when ready for deployment
    le_staging: false

## Example Playbook

Should be used in combination with `docker` and `ansible-role-onion` roles.

    - name: "Set up the website"
      hosts: "webserver"
      become: true

      roles:
        - docker
        - caddy-website
        - onion-services
