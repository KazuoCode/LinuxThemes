#!/bin/bash

# Console colors
GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0;0m"

# Functions

# Update and upgrading the distro
update_distro() {
	printf "• Updating packages...\n"
	if apt -qq update -y; then
		printf "${GREEN}✔ ${NC} Packages updated.\n"
		printf "• Upgrading packages...\n"
		if apt -qq upgrade -y; then
			printf "${GREEN}✔ ${NC} Packages upgraded.\n"
		else
			printf "${RED}✘ ${NC} Something happened while upgrading.\n"
		fi
	else
		printf "${RED}✘ ${NC} Something happened while updating.\n"
	fi
}

# Install XFCE4
xfce() {
	printf "• This theme is thought for XFCE4 Window manager. Do you want to install it? [y/n]; "
	read XFCE
	if [ $XFCE == "y" ]; then
		printf "${GREEN}✔ ${NC} Installing XFCE4...\n"
		if apt -qq install xfce4 -y; then
			printf "${GREEN}✔ ${NC} XFCE4 installed.\n"
		else
			printf "${RED}✘ ${NC} Something happened while installing XFCE4.\n"
		fi
	elif [ $XFCE == "n"]; then
		printf "${RED}✘ ${NC} Not installing XFCE4.\n"
	else
		printf "${RED}✘ ${NC} No idea what that input is.\n"
	fi
}

# Install GIT
git() {
	printf "• Checking for GIT...\n"
	if [ -x "$(command -v git)" ]; then
		printf "${GREEN}✔ ${NC} Git is installed.\n"
	else
		printf "• Installing GIT...\n"
		if apt -qq install git -y; then
			printf "${GREEN}✔ ${NC} Git installed.\n"
		else
			printf "${RED}✘ ${NC} Something happened while installing GIT.\n"
			exit 1
		fi
	fi
}

# Install Tint2
tint(){
	printf "• Checking for Tint2...\n"
	if [ -x "$(command -v tint2)" ]; then
		printf "${GREEN}✔ ${NC} Tint2 is installed.\n"
	else
		printf "• Installing Tint2...\n"
		if apt -qq install tint2 -y; then
			printf "${GREEN}✔ ${NC} Tint2 installed.\n"
		else
			printf "${RED}✘ ${NC} Someting happened while installing Tint2.\n"
			exit 1	
		fi
	fi
}

# Install Rofi
rofi(){
  printf "• Checking for Rofi...\n"
  if [ -x "$(command -v rofi)" ]; then
    printf "${GREEN}✔ ${NC} Rofi is installed.\n"
  else
    printf "• Installing Rofi...\n"
    if apt -qq install rofi -y; then
      printf "${GREEN}✔ ${NC} Rofi installed.\n"
    else
      printf "${RED}✘ ${NC} Someting happened while installing Rofi.\n"
      exit 1
    fi
  fi
}

# Add the Tint2 theme to the config folder
tint2theme() {
	if [ -d "~/.config/tint2/" ]; then
		printf "• What is your username?: "
		read NOROOT
		printf "${GREEN}✔ ${NC} Tint2 config folder exists.\n"
		cp -r ~/LinuxThemes/xfce4/Material-xfce4/Launchy ~/.config/tint2/launchy
		sed -i "s/kazuo/$NOROOT/g" ~/.config/tint2/launchy/launchy.tint2rc	
		printf "${GREEN}✔ ${NC} Tint2 configuration set.\n"	
	else
		printf "${RED}✘ ${NC} Tint2 config folder doesnt exist.\n"
		printf "• Creating the config folder...\n"
		if mkdir -p ~/.config/tint2/; then
			printf "${GREEN}✔ ${NC} Config folder created.\n"
			cp -r ~/LinuxThemes/xfce4/Material-xfce4/Launchy ~/.config/tint2/launchy
			sed -i "s/kazuo/$NOROOT/g" ~/.config/tint2/launchy/launchy.tint2rc
			printf "${GREEN}✔ ${NC} Tint2 configuration set.\n" 
		else
			printf "${RED}✘ ${NC} Someting happened while creating Tint2's config folder\n"
      exit 1
		fi

	fi	
}


# Add the rofi script for Tint2
util() {
	if [ -d "~/.util"]; then
		printf "${RED}✘ ${NC} .util doesn't exist.\n"
		mkdir ~/.util
		printf "${GREEN}✔ ${NC} .util created.\n"
		cp -r ~/LinuxThemes/xfce4/Material-xfce4/Launchy/.util ~/.util
		printf "${GREEN}✔ ${NC} Rofi script copied.\n"
	else
		printf "${GREEN}✔ ${NC} .util folder exists.\n"
		cp -r ~/LinuxThemes/xfce4/Material-xfce4/Launchy/.util ~/.util
		printf "${GREEN}✔ ${NC} Rofi script copied.\n"
	fi
}
		
# Add the GTK theme
gtk() {
	if [ -d "~/.themes"];  then
		printf "${GREEN}✔ ${NC} .themes folder exists.\n"
		cp -r ./LinuxThemes/xfce4/Material-xfce4/Fantome ~/.themes
		printf "${GREEN}✔ ${NC} GTK theme copied.\n"
	else
		printf "${RED}✘ ${NC} .theme doesn't exist.\n"
		mkdir ~/.themes
		printf "${GREEN}✔ ${NC} Themes folder created.\n"
		cp -r ./LinuxThemes/xfce4/Material-xfce4/Fantome ~/.themes
    printf "${GREEN}✔ ${NC} GTK theme copied.\n"
	fi
}

autostart(){
	if [ -d "~/.config/autostart/" ]; then
		printf "• Setting up tint2 in autostart...\n"
		cp ~/LinuxThemes/xfce4/Material-xfce4/tint2.desktop ~/.config/autostart/tint2.desktop
		printf "${GREEN}✔ ${NC} Tint2 copied into autostart.\n"
	else
		printf "${RED}✘ ${NC} Autostart doesnt exists...\n"
		mkdir -p ~/.config/autostart/
		printf "${GREEN}✔ ${NC} Autostart created..\n"
		cp ~/LinuxThemes/xfce4/Material-xfce4/tint2.desktop ~/.config/autostart/tint2.desktop
		printf "${GREEN}✔ ${NC} Tint2 copied into autostart.\n"
	fi
}

cleanup() {
  printf "$• Cleanup!...\n"
  rm -rf ~/LinuxThemes
  rm matxfce.sh
  printf "${GREEN}✔ ${NC} Cleanup finished!\n"
}


# Setup the theme
setup() {
	tint2theme
	util
	gkt
	cleanup
}

# Clone the repository with the themes
clonning() {
	printf "• Clonning the repo with the assets...\n"
	echo "git clone	--quiet https://github.com/KazuoCode/LinuxThemes ~/LinuxThemes" >> matxfce.sh
	if bash matxfce.sh; then
		printf "${GREEN}✔ ${NC} Repo cloned.\n"
		rm matxfce.sh
		setup
	else
		printf "${RED}✘ ${NC} Someting happened while clonning the repo.\n"
   	rm matxfce.sh
		exit 1
	fi
}

# Install neded packages
installs() {
	git
	tint
	rofi
	clonning
}

# Check if the script is being run with sudo.
if [ "$EUID" -eq 0 ]; then
	printf "${GREEN}✔ ${NC} Program is being ran with sudo.\n"

	# Check if the system is debian based
	if [ -f "/etc/debian_version" ]; then
		printf "${GREEN}✔ ${NC} System is based on debian.\n"
		printf "• This script will update and upgrade your system, if you refuse it will skip it but that might cause problems on the install. [y/n]: "
		
		# Prompt for user input
		read ANSWER
		if [ $ANSWER == "y" ]; then
			update_distro
			xfce
			installs
		elif [ $ANSWER == "n" ]; then
			printf "${RED}✘ ${NC} Not updating the distro.\n"
			xfce
		else
			printf "${RED}✘ ${NC} No idea what that input is.\n"
		fi

	else
		printf "${RED}✘ ${NC} The system is not debian based.\n"
	fi

else
	printf "${RED}✘ ${NC} Script is not being run with sudo.\n"
fi
