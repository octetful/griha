#! /bin/sh
# 
# sidsvnc is a script to start vnc sessions for myself at system bootup.
#
# NOTE: You will need tightvnc or equivalent package to be pre-installed
#       for this to work. On Debian use (apt-get install tightvnc).
# NOTE: Also, this script is meant to be run from within the server.
# 

# define color codes (not sure)
red='\033[0;31m'
green='\033[0;32m'
nocolor='\033[0m'

# define ports
desktop_port=4
mobile_port=3

# define geometry
desktop_geometry=1280x800

# define username
user=siddhartha

# Simple operations
case "$1" in
     start)
	echo "Starting up vnc for Sid..."
	su -c "vncserver -geometry $desktop_geometry :$desktop_port" $user
	if [ $? -eq 0 ]
	then
		echo "desktop\t[${green}done${nocolor}]"
	else
		echo "desktop\t[${red}failed${nocolor}]"
	fi
	
	su -c "vncserver :$mobile_port" $user
	if [ $? -eq 0 ]
	then
		echo "mobile\t[${green}done${nocolor}]"
	else
		echo "mobile\t[${red}failed${nocolor}]"
	fi
	;;
     stop)
	echo "Stopping Sid's vnc sessions..."
	su -c "vncserver -kill :$desktop_port" $user
	if [ $? -eq 0 ]
	then
		echo "desktop\t[${green}done${nocolor}]"
	else
		echo "desktop\t[${red}failed${nocolor}]"
	fi
	su -c "vncserver -kill :$mobile_port" $user
	if [ $? -eq 0 ]
	then
		echo "mobile\t[${green}done${nocolor}]"
	else
		echo "mobile\t[${red}failed${nocolor}]"
	fi
	;;
    
     *)
	echo -e "USAGE: /etc/init.d/sidsvnc {start|stop}"
	exit 1
	;;
     esac

exit 0

	