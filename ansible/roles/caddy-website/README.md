This ansible role compiles the latest version of caddy disabling telemetry

Previously the caddy server was being built from source but since then,
it has broken and so now it is fetched in binary form.

This role preforms the following tasks:
  - fetches the latest version of the website
  - uses [hugo](https://gohugo.io) to build it into static html
  - installs caddy server and puts the website live with https
  - updates website from the source hourly (runs template update-script.sh)
