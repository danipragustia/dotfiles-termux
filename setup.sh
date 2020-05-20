#!/bin/bash

ln -s .aliases ~/
ln -s .bashrc ~/
ln -s .config ~/
ln -s .profile ~/
ln -s .vimrc ~/

rm -rf ~/.config
ln -s .config ~/
