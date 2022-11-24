#!/bin/bash

TMPDIR=$(mktemp -d)

CURRENT=$PWD

cd $TMPDIR

for script in ~/.dotfiles/scripts/*; do
  bash "$script"
done
tasks:
  - name: Setup SSH
    before: |
      ssh-keyscan github.com >> "${HOME}/.ssh/known_hosts"
      if [[ ! -z "${id_rsa}" ]]; then
        echo "${id_rsa}" | base64 --decode > "${HOME}/.ssh/id_rsa"
        chmod 0600 "${HOME}/.ssh/id_rsa"
      fi

cd $CURRENT

rm -rf $TMPDIR
