#!/bin/bash

# Vagrant version
export vg_ver="2.2.10"
export python_ver="${TRAVIS_PYTHON_VERSION}"

# Install libvirt, travis and KVM
# https://github.com/alvistack/ansible-role-virtualbox/blob/master/.travis.yml
curl -OSs https://releases.hashicorp.com/vagrant/${vg_ver}/vagrant_${vg_ver}_x86_64.deb
curl -OSs https://releases.hashicorp.com/vagrant/${vg_ver}/vagrant_${vg_ver}_SHA256SUMS
curl -OSs https://releases.hashicorp.com/vagrant/${vg_ver}/vagrant_${vg_ver}_SHA256SUMS.sig
gpg --keyserver hkps://keys.openpgp.org  --receive-key 51852D87348FFC4C
gpg --verify vagrant_${vg_ver}_SHA256SUMS.sig vagrant_${vg_ver}_SHA256SUMS
sha256sum -c vagrant_${vg_ver}_SHA256SUMS 2>&1 | grep OK
sudo apt-get -qq update
sudo apt-get -qq install bridge-utils dnsmasq-base ebtables libvirt-bin \
    libvirt-dev qemu-kvm qemu-utils ruby-dev python${python_ver}
sudo dpkg -i vagrant_${vg_ver}_x86_64.deb
sudo vagrant plugin install vagrant-libvirt
sudo vagrant plugin list
rm -rf vagrant_${vg_ver}_*
Install pipenv and pip
# https://github.com/jonashackt/molecule-ansible-docker-aws/blob/master/.travis.yml
curl -skL https://bootstrap.pypa.io/get-pip.py | sudo -H python${python_ver}
sudo -H pip3 install pipenv
sudo -H pipenv install
sudo -H pipenv check
