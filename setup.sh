#!/bin/bash

if ! [ -x "$(command -v git)" ]; then
  echo 'Error: git is not installed.' >&2
  exit 1
fi

if ! [ -d "~/.dotfiles-termux" ]; then
	echo "Downloading Repository"
	git clone https://github.com/danipragustia/dotfiles-termux ~/.dotfiles-termux
else
	echo "Updating Repository"
	cd ~/.dotfiles-termux && git pull origin master
fi

NOW=$(date +"%d-%m-%Y-%T");
mkdir -p ~/.backup-dotfiles/$NOW

backup() {
	cp -r ~/$filename ~/.backup-dotfiles/$NOW/$filename
	rm -rf ~/$filename
	ln -s ~/.dotfiles-termux/$filename ~/$filename
}

for filename in .*; do
	if [ -f ~/$filename ]; then
		echo "Backup File and Link $filename"
		backup
	elif [[ -d ~/$filename && $filename != ".git" ]]; then
		echo "Backup Directory and Link $filename"
		backup
	else
		ln -s ~/.dotfiles-termux/$filename ~/$filename
	fi
done

# Cleanup
rm -rf ~/.git
rm -rf ~/README.md
rm -rf ~/setup.sh
