#! /bin/bash

# Adding some splash of colours
RED='\033[0;31m'
GREEN='\033[0;32m'        
YELLOW='\033[0;33m'  
OFF='\033[0m' 

# Check up and clean old verisons
echo "Checking and cleaning up old $1 files"

rm -f $1.zip

# If old directory exists, delete it
if [ -d "./$1" ]; then
    echo -e "${YELLOW}Removing Old Files for ($1)\n${OFF}"
    rm -rf "./$1"
fi

echo "Adding $1 to wallpapers ..."

# Create wallpapers directory if doesn't exist
sudo mkdir -p /usr/share/backgrounds/gnome

# Download files from the zip repo
echo -e "${YELLOW}Downloading Files...${OFF}"
echo ""
status=$(curl -LJ https://objectstorage.ap-hyderabad-1.oraclecloud.com/n/ax1fgialsdrt/b/manishprivet/o/$1.zip -o ./$1.zip --write-out %{http_code} --progress-bar)

# If file doesn't exist, exit with an error
if [[ "$status" -ne 200 ]] ; then
  echo ""
  echo -e "${RED}$1 theme doesn't exist. Make sure you spelled it correctly.${OFF}"
  rm -f $1.zip
  exit 0
fi

# Unzip the file
unzip -q $1.zip -d ./$1

# If old directory exists, delete it
if [ -d "/usr/share/backgrounds/gnome/$1-timed" ]; then
    echo ""
    echo -e "${YELLOW}Removing old $1 wallpaper...${OFF}"
    ./uninstall.sh $1
    echo -e "${GREEN}Old files removed${OFF}"
fi


cd $1

# Create required directories
sudo mkdir /usr/share/backgrounds/gnome/$1-timed
sudo cp $1*.jp* /usr/share/backgrounds/gnome/$1-timed
sudo cp $1-timed.xml /usr/share/backgrounds/gnome
sudo cp $1.xml /usr/share/gnome-background-properties
echo ""
echo -e "${GREEN}Added $1 dynamic wallpaper!"

# Cleanup zip file and extracted folder
echo "Cleaning up ..."
cd ..
rm -rf $1
rm $1.zip