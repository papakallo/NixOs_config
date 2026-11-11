#!/bin/sh

#This script will change your background every ten minutes in Sway

while true
do
     #Create an array consisting of all your wallpaper files.  Use your own path to your wallpaper files

      Display=(/home/papakallo/Pictures/wallpapers/*)

      #Create a variable for each display using a random number
      #Random will automatically be equal to the number of files in your wallpaper folder

      x=$((0 + RANDOM % ${#Display[@]}))
      # y=$((0 + RANDOM % ${#Display[@]}))

      #Optional conditional test to prevent the same wallpaper displaying on both displays
      #If you don't care about this, or only have a single display, skip these lines

            # if [ "$x" -eq "$y" ]
            # then
            #       continue
            # fi

      #Parse array for files to be displayed on each display and display them
      #Use your system's display names here, these are mine

      swaymsg output "*" bg "${Display[$x]}" fill
      echo "Wallpaper changed to the ${Display[$x]}"
      # swaymsg output "HDMI-A-2" bg "${Display[$y]}" fill

      #Sleep for 10 minutes (or whatever interval you choose)

      sleep 10m

done
