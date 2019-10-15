#!/usr/bin/bash
# Scripted in Bash by Peter Germon
userExit=0
RED='\033[0;31m'
WHITE='\033[1:37m'
NC='\033[0m'
while [ $userExit -eq 0 ]
do
	clear
	echo ""
	echo -e " $RED *---------------------------------*$NC"
	echo -e " $RED |$NC $WHITE    Bourne-Again ExpressVPN  $NC   $RED|$NC"
	echo -e " $RED |---------------------------------|$NC"
	echo -e " $RED |$NC $WHITE 1. Connect $NC                    $RED|$NC"
	echo -e " $RED |$NC $WHITE 2. Change Location/Protocol $NC   $RED|$NC"
	echo -e " $RED |$NC $WHITE 3. Refresh VPN Clusters       $NC $RED|$NC"
	echo -e " $RED |$NC $WHITE 4. Disconnect $NC                 $RED|$NC"
	echo -e " $RED |$NC $WHITE 5. Exit (Stay connected) $NC      $RED|$NC"
	echo -e " $RED |$NC $WHITE 6. Exit (Disconnect) $NC          $RED|$NC"
	echo -e " $RED *---------------------------------*$NC"
	echo ""
	expressvpn status | grep -E "Connected to|Not connected"
	echo -e "$NC"
	read -p "Please make a selection: " menuSelect
	clear
	if [ $menuSelect -eq 1 ]; then
		connectExit=0
		while [ $connectExit -eq 0 ]
		do
			clear
			echo ""
			echo -e " $RED *---------------------------------*"
			echo -e " $RED |$NC           $WHITE Connect $NC             $RED|$NC"
			echo -e " $RED |---------------------------------|"
			echo -e " $RED |$NC $WHITE 1. Auto Connect $NC               $RED|$NC"
			echo -e " $RED |$NC $WHITE 2. Connect via TCP $NC            $RED|$NC"
			echo -e " $RED |$NC $WHITE 3. Connect via UDP $NC            $RED|$NC"
			echo -e " $RED |$NC $WHITE 4. Back to main menu $NC          $RED|$NC"
			echo -e " $RED *---------------------------------*"
			echo -e "$NC"
			read -p "Please make a selection: " connectSelect
			if [ $connectSelect -eq 1 ]; then
				read -p "Enter VPN Location: " vpnlocation
				expressvpn protocol auto
				expressvpn connect $vpnlocation
				connectExit=1
			elif [ $connectSelect -eq 2 ]; then
         			read -p "Enter VPN Location: " vpnlocation
         			expressvpn protocol tcp
        			expressvpn connect $vpnlocation
				connectExit=1
			elif [ $connectSelect -eq 3 ]; then
 				read -p "Enter VPN Location: " vpnlocation
				expressvpn protocol udp
         	      		expressvpn connect $vpnlocation
				connectExit=1
			elif [ $connectSelect -eq 4 ]; then
				connectExit=1
			else
				echo "Invalid Selection"
			fi
		done
	elif [ $menuSelect -eq 2 ]; then
		changeExit=0
		while [ $changeExit -eq 0 ]
		do
			clear
			echo ""
                        echo -e " $RED *---------------------------------*"
                        echo -e " $RED |$NC   $WHITE Change Location/Protocol $NC    $RED|$NC"
                        echo -e " $RED |---------------------------------|"
                        echo -e " $RED |$NC $WHITE 1. Protocol Auto $NC              $RED|$NC"
                        echo -e " $RED |$NC $WHITE 2. Protocol TCP $NC               $RED|$NC"
                        echo -e " $RED |$NC $WHITE 3. Protocol UDP $NC               $RED|$NC"
                        echo -e " $RED |$NC $WHITE 4. Back to main menu $NC          $RED|$NC"
                        echo -e " $RED *---------------------------------*"
                        echo -e "$NC"
                        read -p "Please make a selection: " changeSelect
                        if [ $changeSelect -eq 1 ]; then
                                read -p "Enter VPN Location: " vpnlocation
                                expressvpn disconnect
				expressvpn protocol auto
                                expressvpn connect $vpnlocation
                                changeExit=1
                        elif [ $changeSelect -eq 2 ]; then
                                read -p "Enter VPN Location: " vpnlocation
                                expressvpn disconnect
				expressvpn protocol tcp
                                expressvpn connect $vpnlocation
				changeExit=1
                        elif [ $changeSelect -eq 3 ]; then
                                read -p "Enter VPN Location: " vpnlocation
                                expressvpn disconnect
				expressvpn protocol udp
                                expressvpn connect $vpnlocation
				changeExit=1
                        elif [ $changeSelect -eq 4 ]; then
                                changeExit=1
                        else
                                echo "Invalid Selection"
                        fi

		done
	elif [ $menuSelect -eq 3 ]; then
		expressvpn refresh
	elif [ $menuSelect -eq 4 ]; then
		expressvpn disconnect
	elif [ $menuSelect -eq 5 ]; then
		userExit=1
	elif [ $menuSelect -eq 6 ]; then
		userExit=1
		expressvpn disconnect
	else
		echo "Invalid Selection"
	fi
done
