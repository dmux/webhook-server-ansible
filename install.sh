#!/bin/bash

release_url=$(curl -s https://api.github.com/repos/dmux/webhook-server-ansible/releases/latest | grep "browser_download_url.*Linux_x86_64.tar.gz" | cut -d : -f 2,3 | tr -d \")

(
  cd /tmp
  wget $release_url -O wsa.tar.gz

  tar -xvzf wsa.tar.gz wsa
  chmod +x wsa
  mv wsa /usr/local/bin/wsa
  rm -rf wsa wsa.tar.gz
  echo "Installed in $(which wsa)"
)