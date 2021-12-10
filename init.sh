#! /bin/bash

if["$(uname)"=="Darwin"];then
    brew install git zsh tmux -y
elif["$(expr substr $(uname -s) 1 5)"=="Linux"];then
    release=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
    if [${release}=="Ubuntu"];then
        sudo apt update && sudo apt install git zsh tmux -y
    elif [${release}=="CentOS Linux"]; then
        sudo yum update && sudo yum install git zsh tmux -y

chsh -s /bin/zsh

echo "setup oh-my-zsh..."

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g' ~/.zshrc

echo "setup tmux..."

git clone https://github.com/GeekRicardo/tmux.git
mv ~/tmux ~/.tmux
ln -s ~/.tmux/tmux.conf ~/.tmux.conf
