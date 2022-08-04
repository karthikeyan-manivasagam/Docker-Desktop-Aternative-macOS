#!/bin/bash  

#start minkube
function startminikube() {
 echo "starting minikube wait few minitues"
  minikube start > /dev/null 2>&1
  echo "wait 2 mins"
  sleep 2m
  eval $(minikube docker-env)
  echo "evalexectued"
}

#Install package
function checkandinstall ()
{

if ! command -v "$1" &> /dev/null
then
    if [[ $1 == "brew" ]]; then
     git clone https://github.com/Homebrew/brew homebrew
     eval "$(homebrew/bin/brew shellenv)"
     brew update --force --quiet
     chmod -R go-w "$(brew --prefix)/share/zsh"
     echo "BREW INSTALLED"
    else
     brew install "$1"
      echo "$1 installing"
    fi
else
   echo "$1 already exists"  
fi
}

#package list
package=("brew" "minikube" "hyperkit" "docker" "docker-compose")

for i in "${package[@]}"
do
   checkandinstall "$i"

done
#configure docker for issue fix
rm ~/.docker/config.json
echo '{
  "credStore" : "desktop"
}' >> ~/.docker/config.json
startminikube
