#! /bin/bash

# Adding some splash of colours
RED='\033[0;31m'
GREEN='\033[0;32m'        
YELLOW='\033[0;33m'  
OFF='\033[0m' 

LOCATION=~/.local/share

if [[ "$2" == "--global" ]] ; then
  echo -e "${YELLOW}Uninstalling Wallpaper Globally${OFF}"
  echo ""
  LOCATION=/usr/share

  if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}You must run the script as root to install the Wallpaper globally${OFF}"
    echo ""
    exit 1
  fi
fi

echo -e "${YELLOW}Removing $1 from installed wallpapers ...${OFF}"
rm -rf $LOCATION/backgrounds/gnome/$1-timed
rm -rf $LOCATION/backgrounds/gnome/$1-timed.xml  
rm -rf $LOCATION/gnome-background-properties/$1.xml
echo -e "${GREEN}Removed $1 dynamic wallpaper!${OFF}"
