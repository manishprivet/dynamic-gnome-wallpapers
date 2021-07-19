#! /bin/bash

echo "Removing $1 from installed wallpapers ..."
cd $i
sudo rm -rf /usr/share/backgrounds/gnome/$1-timed
sudo rm -rf /usr/share/backgrounds/gnome/$1-timed.xml  
sudo rm -rf /usr/share/gnome-background-properties/$1.xml
echo "Removed $1 dynamic wallpaper!"
