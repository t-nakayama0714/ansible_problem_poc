#!/bin/bash

VERSION=${1}

cd /opt/ansible
git checkout refs/tags/${VERSION}
git submodule update --init --recursive
source ./hacking/env-setup > /dev/null
ansible --version
cd -

