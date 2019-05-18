#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    echo 'Detected OS X'
    VIMCOMMAND='mvimdiff -f'
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo 'Detected Linux'
    VIMCOMMAND=vimdiff
else
    echo 'OS not detected assuming Linux'
    VIMCOMMAND=vimdiff
fi

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
cp ../.tmux.conf ./tmux.conflocal

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

# Now do diffs and confirm overwrite on each.
echo "--------------------  < .tmux.conf (git), > .tmux.conf (local) --------------------"
$VIMCOMMAND tmux.confgit tmux.conflocal
echo "${GREEN}Overwrite your existing .tmux.conf with the edited git one (y/[n]?)${NC}"
read yn
if [ $yn == "y" ]; then
    echo "${GREEN}Copying...${NC}"
    cp tmux.confgit ../.tmux.conf
fi

echo 'Done.  To update the git version, simply overwrite the vimrcgit (or [whatever]git) with the new version and git push.'

cd ..

