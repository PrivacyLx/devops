#!/bin/sh -e

vault_gpg="gpg/vault_pass.gpg"

if [ -n "${QUBES_GPG_DOMAIN+set}" ]; then
    qubes-gpg-client --batch --verbose --decrypt ${vault_gpg}
else
    gpg --batch --verbose --decrypt ${vault_gpg}
fi
