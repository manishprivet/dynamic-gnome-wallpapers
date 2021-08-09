#! /bin/bash

# Adding some splash of colours
RED='\033[0;31m'
GREEN='\033[0;32m'        
YELLOW='\033[0;33m'  
OFF='\033[0m' 

# LOCATION variable: where Wallapers were previously installed.
LOCATION=~/.local/share

# Checking if --global argument has been provided or not.
if [[ "$2" == "--global" ]] ; then
  # Condition True: Echo Uninstall Message and change LOCATION variable.
  echo -e "${YELLOW}Uninstalling Wallpaper Globally${OFF}"
  echo ""
  LOCATION=/usr/share

  # Checking if User has ROOT permission or not before attempting to remove Wallpapers globally.
  if [[ $EUID -ne 0 ]]; then
    # Not Root User: Exit after echoing relevant message.
    echo -e "${RED}You must run the script as root to install the Wallpaper globally${OFF}"
    echo ""
    exit 1
  fi
fi

# File Removal Starts for here.
echo -e "${YELLOW}Removing $1 from installed wallpapers ...${OFF}"
rm -rf $LOCATION/backgrounds/gnome/$1-timed
rm -rf $LOCATION/backgrounds/gnome/$1-timed.xml  
rm -rf $LOCATION/gnome-background-properties/$1.xml
echo -e "${GREEN}Removed $1 dynamic wallpaper!${OFF}"
# File Removal Complete!
