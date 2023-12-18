#!/usr/bin/env bash

DIR=$HOME/Pictures/wallpapers/
PICS=($(find ${DIR} -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" -o -name "*.webp" \)))
swww query &&
	swww img ${PICS[$RANDOM % ${#PICS[@]}]} --transition-fps 30 --transition-type any --transition-duration 3 ||
	swww init

#sleep 3 &
# Infinite loop
#while true; do
#	for count in {1..${#PICS[@]}}; do
#		swww img ${PICS[${count}]} --transition-fps 30 --transition-type any --transition-duration 3 &
#		sleep 3 &
#	done
#done
