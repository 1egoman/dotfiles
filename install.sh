#!/bin/bash

# symlink the dotfile from its current location to ~/.dotfile
function symlink {
  ln -s $PWD/$1 $HOME/.$1
  echo "Installed $1 in $HOME/.$1"
}

for filename in *; do
  # not this script
  if [[ "$filename" != "install.sh" ]] &&
     [[ "$filename" != "LICENCE" ]] &&
     [[ "$filename" != "README.md" ]] &&
     [[ "$filename" != "."* ]]; then

    # should we delete an old version of the dotfile?
    if [[ -f "$HOME/.$filename" ]]; then
      if [[ "$1" == "--force" ]] || [[ "$1" == "--yes" ]]; then
        yn="y"
      elif [[ "$1" == "--no" ]]; then
        yn="n"
      else
        read -p "Dotfile .$filename already exists. Should we replace it? " yn
      fi

      # check the answer
      case $yn in
        [yY]* )
          rm $HOME/.$filename; # delete the old dotfile
          symlink $filename; # simlink the new dotfile
          ;;
        * )
          echo "Skipping $filename..."
          ;;
      esac
    else
      # add the new file without question
      symlink $filename
    fi
  fi
done
