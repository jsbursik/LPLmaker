#!/bin/sh


# Set to wherever your retroarch directory is (contains paylists folder, cores folder, etc.), typically in ~/.config/retroarch
RetroArchDir="/home/jordan/.config/retroarch"
RomsDir="/home/jordan/Roms"

# If you use core updater change this to home/username/.config/retroarch/cores/
CoresDir="/usr/lib/libretro"

# Example of how to setup a SNES and NES playlist.
# Can use "DETECT" instead of core lib and name, as well as playlist name if unsure

RomDirs[0]="SNES"
CoreLibs[0]="snes9x_libretro.so"
CoreNames[0]="Snes9x"
PlaylistNames[0]="Nintendo - Super Nintendo Entertainment System"
SupportedExtensions[0]="*.smc *.fig *.sfc *.gd3 *.gd7 *.dx2 *.bsx *.swc"

RomDirs[1]="NES"
CoreLibs[1]="nestopia_libretro.so"
CoreNames[1]="Nestopia"
PlaylistNames[1]="Nintendo - Nintendo Entertainment System"
SupportedExtensions[1]="*.nes"

# No need to edit anything beyond this point, unless you don't want it to delete files, go down.

x=0

clear

echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "!!                                                                            !!"
echo "!!  WARNING: Continuing to run this program will delete your playlist files.  !!"
echo "!!     If you would like to back them up, do so now, or RIP in pepperonis     !!"
echo "!!                             to your playlists.                             !!"
echo "!!                                                                            !!"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo
read -p "Press [Enter] key to continue..."

##############################################
# This deletes all playlists (only .lpl files)
rm -f "$RetroArchDir"/playlists/*.lpl
##############################################

while [ -n "${RomDirs[$x]}" ]; 
  do
    pushd "$RomsDir/${RomDirs[$x]}" > /dev/null
    echo "======================================================================"
    echo "${PlaylistNames[$x]}"
    echo "======================================================================"

    echo "Writing playlist now..."

    for f in ${SupportedExtensions[$x]}
      do
      [ -f "$f" ] || break
        (
          echo "$RomsDir/${RomDirs[$x]}/$f"
          echo ${f%%.*}
          echo $CoresDir/${CoreLibs[$x]}
          echo ${CoreNames[$x]}
          echo 0\|crc
          echo "${PlaylistNames[$x]}".lpl
        ) >> "$RetroArchDir/playlists/${PlaylistNames[$x]}".lpl
      done
      echo
      echo "$RetroArchDir/playlists/${PlaylistNames[$x]}".lpl

    echo
    popd > /dev/null

    x+=1
  done