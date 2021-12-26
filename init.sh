#!/bin/bash

ensure_netplan_apply() {
  sleep 5
  sudo netplan apply
}

step=1
step() {
  echo "Step $step $1"
  step=$((step+1))
}

move_files() {
  step "===== Installing docker ====="
  sudo mkdir hola
}

setup_welcome_msg() {
  sudo apt-get -y install boxes
  version=$(cat /etc/os-release |grep VERSION= | cut -d'=' -f2 | sed 's/"//g')
  ipserver=$(hostname -I | cut -d' ' -f2)
  sudo echo -e "\necho \"Welcome to management server with AyPhu \n IP Server: ${ipserver} \n Ubuntu Server ${version}\" | boxes -d dog -a c\n" >> /home/vagrant/.bashrc
  sudo ln -s /usr/games/boxes /usr/local/bin/boxes
}

main() {
  ensure_netplan_apply
  move_files
  setup_welcome_msg
}

main