#!/bin/bash

root="${HOME}/repos/dotfiles"
bash_source="${root}/.bash_profile"
bash_destination="${HOME}/.bash_profile"
git_source="${root}/.gitconfig"
git_destination="${HOME}/.gitconfig"

# symlink necessary configs
ln -s $bash_source $bash_destination
ln -s $git_source $git_destination
