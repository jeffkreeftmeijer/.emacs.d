#!/bin/bash
set -e

cd ~/emacs
git checkout emacs-29
git pull origin emacs-29
make
sudo make install
