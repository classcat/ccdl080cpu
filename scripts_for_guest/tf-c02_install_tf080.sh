#!/bin/bash

###################################################################
### ClassCat(R) Deep Learning Service
### Copyright (C) 2016 ClassCat(R) Co.,Ltd. All righs Reserved. ###
###################################################################

# --- Descrption --------------------------------------------------
# Run on the account - tensorflow070.
#
# --- HISTORY -----------------------------------------------------
#
# -----------------------------------------------------------------


function check_if_continue () {
  local var_continue

  echo -ne "About to install tensorflow for ClassCat Deep Learning service. Continue ? (y/n) : " >&2

  read var_continue
  if [ -z "$var_continue" ] || [ "$var_continue" != 'y' ]; then
    echo -e "Exit the install program."
    echo -e ""
    exit 1
  fi
}


function show_banner () {
  clear

  echo -e  ""
  echo -en "\x1b[22;36m"
  echo -e  "\tClassCat(R) Deep Learning Service"
  echo -e  "\tCopyright (C) 2016 ClassCat Co.,Ltd. All rights reserved."
  echo -en "\x1b[m"
  echo -e  "\t\t\x1b[22;34m@Insall TensorFlow\x1b[m: release: alpha (04/17/2016)"
  # echo -e  ""
}


function confirm () {
  local var_continue

  echo ""
  echo -ne "This script must be run as 'tensorflow' account. Press return to continue (or ^C to exit) : " >&2

  read var_continue
}



###
### INIT
###

function init () {
  check_if_continue

  show_banner

  confirm

  id | grep tensorflow > /dev/null
  if [ "$?" != 0 ]; then
    echo "Script aborted. Id isn't tensorflow2."
    exit 1
  fi
}



###
### TensorFlow 0.7.1
###

function clone_and_config_tensorflow080 () {
  git clone --recurse-submodules https://github.com/tensorflow/tensorflow tensorflow.080rc0

  ln -s tensorflow.080rc0 tensorflow

  cd tensorflow

  git checkout "v0.8.0rc0"
  #git checkout "v0.7.1"

}


###
### Install TensorFlow Pip Package
###

function install_tensorflow () {
  pip install --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.8.0rc0-cp27-none-linux_x86_64.whl
  if [ "$?" != 0 ]; then
    echo "Script aborted. pip install tensorflow-0.7.1-py2-none-any.whl failed."
    exit 1
  fi
}



###################
### ENTRY POINT ###
###################

init

cd ~

clone_and_config_tensorflow080

cd ~

install_tensorflow


echo ""
echo "####################################################"
echo "# Script execution has been completed successfully."
echo "# Then, run tf-04_s3.sh as 'tensorflow' account."
echo "####################################################"
echo ""


exit 0

