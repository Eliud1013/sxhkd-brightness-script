#!/bin/bash
createFile=0
cat /tmp/actVal 2>/dev/null 1>&2 || createFile=1

if [ $createFile -eq 1 ]; then
	touch /tmp/actVal
	echo "1" > /tmp/actVal
	xrandr --output eDP-1 --brightness 1
fi 
actVal=$(cat /tmp/actVal)

if [[ $(echo "$actVal <= 1.6" | bc) == "1" ]] && [[ $(echo "$actVal > 0.4 " | bc) == "1" ]]; then
	
	if [[ $1 == 'inc' ]]; then #INCREMENTADOR
		actVal=$(cat /tmp/actVal);
		val=$(echo "$(cat /tmp/actVal) + 0.2" |bc)
		echo $val > /tmp/actVal
		xrandr --output eDP-1 --brightness $(cat /tmp/actVal)

	elif [[ $1 == "dec" ]];then #DECREMENTADOR
   		actVal=$(cat /tmp/actVal); 
   	 	val=$(echo "$(cat /tmp/actVal) - 0.2" |bc)
   	 	echo $val > /tmp/actVal
   	 	xrandr --output eDP-1 --brightness $(cat /tmp/actVal)
	fi
 else
 
    if [[ $(echo "$actVal <= 0.4 " | bc) == "1" ]]; then
        actVal=0.6
        echo $actVal > /tmp/actVal
    fi
##############
	if [[ $(echo "$actVal >= 1.6" | bc) == 1 ]]; then	
		actVal=1.6
		echo $actVal > /tmp/actVal
	fi

fi
 

#sxhkd configuration

#Brightness control
#XF86MonBrightnessDown
# path/bright.sh dec
#XF86MonBrightnessUp
#	/home/el1x1r/Scripts/bright.sh inc
