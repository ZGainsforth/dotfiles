#!/bin/bash

# For my macs.
VIMCOMMAND='mvimdiff -f'
# For unix.
# VIMCOMMAND=vimdiff

cd ~

# RED='\033[0;31m'
# GREEN='\033[0;32m'
# NC='\033[0m' # No Color
RED=''
GREEN=''
NC=''

# Get the latest versions from git.
echo "${GREEN}Syncing from github.${NC}"
cd ~/dotfiles
git pull

# Backup all the user's dotfiles.
echo "${GREEN}Backing up existing dots as ~/getdots/*local${NC}"
cp ../.vimrc ./vimrclocal
cp ../.zshrc ./zshrclocal

# Now do diffs and confirm overwrite on each.
echo "--------------------  < .vimrc (git), > .vimrc (local) --------------------"
$VIMCOMMAND vimrcgit vimrclocal
echo "${GREEN}Overwrite your existing .vimrc with the edited git one (y/[n]?)${NC}"
read yn
if [ $yn == "y" ]; then
    echo "${GREEN}Copying...${NC}"
    cp vimrcgit ../.vimrc
fi

# Now do diffs and confirm overwrite on each.
echo "--------------------  < .zshrc (git), > .zshrc (local) --------------------"
$VIMCOMMAND zshrcgit zshrclocal
echo "${GREEN}Overwrite your existing .zshrc with the edited git one (y/[n]?)${NC}"
read yn
if [ $yn == "y" ]; then
    echo "${GREEN}Copying...${NC}"
    cp zshrcgit ../.zshrc
fi

echo 'Done.  To update the git version, simply overwrite the vimrcgit (or [whatever]git) with the new version and git push.'

cd ..

