#!/bin/bash

CUR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
VIMRC="$HOME/.vimrc"
BASHRC="$HOME/.bashrc"
SSHCONFIG="$HOME/.ssh/config"
INSTALL="$CUR/install"
ALIAS="$CUR/alias.sh"

cd $HOME
mkdir -p mypro project pkg tmp tools .ssh
cd -

# Usage: $1: string $2: file_name
function string_in_file {
        if grep -qF "$1" "$2"; then
                return 0
        else
                return 1
        fi
}

STR=(
        "source $ALIAS"
        'export PATH="$HOME/.local/bin:$PATH"'
)

# .bashrc
for S in "${STR[@]}"; do
        if ! string_in_file "$S" $BASHRC; then
                echo $S >> $BASHRC
        fi
done

# .vimrc
if ! string_in_file "source $CUR/.vimrc" $VIMRC; then
        echo "source $CUR/.vimrc" >> $VIMRC
fi

# .ssh/config
if ! string_in_file "PubkeyAcceptedKeyTypes +ssh-rsa" $SSHCONFIG; then
        echo "PubkeyAcceptedKeyTypes +ssh-rsa" >> $SSHCONFIG
fi

# generate ssh key
if [ ! -f "$HOME/.ssh/id_rsa.pub" ]; then
        ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -q -N ""
        ssh-copy-id $(whoami)@localhost
fi

echo "--------------------ssh public key---------------------"
cat $HOME/.ssh/id_rsa.pub
echo "-------------------------------------------------------"

read -p "would you want to set git config ?[Y/N]" ANSWER
if [ "$ANSWER" = "Y" ] || [ "$ANSWER" = "y" ]; then
        read -p "input your email: " EMAIL
        read -p "input your name: " NAME
        git config --global user.email $EMAIL
        git config --global user.name $NAME
fi
git config --global core.editor "vim"

read -p "would you want to install basic packages ?[Y/N]" ANSWER
if [ "$ANSWER" = "Y" ] || [ "$ANSWER" = "y" ]; then
        sudo apt update
        sudo apt install -y git vim gcc meson cmake pip clang
        sudo python3 -m pip install --upgrade meson pip ninja # upgrade meson
        sudo apt install -y net-tools openssh-server #network
        sudo apt install -y htop btop plocate # process
fi

#fzf
read -p "would you want to install fzf ?[Y/N]" ANSWER
if [ "$ANSWER" = "Y" ] || [ "$ANSWER" = "y" ]; then
        fzf --version
        if [ $? -ne 0 ]; then
                git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
                $HOME/.fzf/install
        else
                echo "fzf already installed"
        fi
        fzf --version
fi
