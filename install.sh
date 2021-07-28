#! /bin/bash

# Adding some splash of colours
RED='\033[0;31m'
GREEN='\033[0;32m'        
YELLOW='\033[0;33m'  
OFF='\033[0m' 

LOCATION=~/.local/share

PLACEHOLDER="__LOCATION__"

if [ $# -eq 0 ]
then
  echo -e "${RED}Missing Theme Name${OFF}"
  echo ""
  exit 0
fi

echo $2

if [[ "$2" == "--global" ]] ; then
  echo -e "${YELLOW}Installing Wallpaper Globally${OFF}"
  echo ""
  LOCATION=/usr/share

  if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}You must run the script as root to install the Wallpaper globally${OFF}"
    echo ""
    exit 1
  fi
fi

# Check up and clean old verisons
echo "Checking and cleaning up old $1 files"

rm -f $1.zip

# If old directory exists, delete it
if [ -d "./$1" ]; then
    echo -e "${YELLOW}Removing Old Files for ($1)\n${OFF}"
    rm -rf "./$1"
fi

echo "Adding $1 to wallpapers ..."

# Create directories if they doesn't exist
mkdir -p $LOCATION/backgrounds/gnome
mkdir -p $LOCATION/gnome-background-properties

# Download files from the zip repo
echo -e "${YELLOW}Downloading Files...${OFF}"
echo ""
status=$(curl -LJ https://cdn.manishk.dev/v2%2F$1.zip -o ./$1.zip --write-out %{http_code} --progress-bar)

# # If file doesn't exist, exit with an error
if [[ "$status" -ne 200 ]] ; then
  echo ""
  echo -e "${RED}$1 theme doesn't exist. Make sure you spelled it correctly.${OFF}"
  rm -f $1.zip
  exit 0
fi

# # Unzip the file
unzip -q $1.zip -d ./$1

# If old directory exists, delete it
if [ -d "$LOCATION/backgrounds/gnome/$1-timed" ]; then
  echo ""
  echo -e "${YELLOW}Removing old $1 wallpaper...${OFF}"
  rm -rf $LOCATION/backgrounds/gnome/$1-timed
  rm -rf $LOCATION/backgrounds/gnome/$1-timed.xml  
  rm -rf $LOCATION/gnome-background-properties/$1.xml
  echo -e "${GREEN}Removed old $1 wallpaper!${OFF}"
fi


cd $1

sed -i "s+$PLACEHOLDER+$LOCATION+g" $1.xml
sed -i "s+$PLACEHOLDER+$LOCATION+g" $1-timed.xml

# Create required directories
mkdir $LOCATION/backgrounds/gnome/$1-timed
cp $1*.jp* $LOCATION/backgrounds/gnome/$1-timed
cp $1-timed.xml $LOCATION/backgrounds/gnome
cp $1.xml $LOCATION/gnome-background-properties
echo ""
echo -e "${GREEN}Added $1 dynamic wallpaper!${OFF}"

# Cleanup zip file and extracted folder
echo "Cleaning up ..."
cd ..
rm -rf $1
rm $1.zip