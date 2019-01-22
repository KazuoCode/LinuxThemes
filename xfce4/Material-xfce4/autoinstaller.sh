echo "----------------------"
echo "Updating the distro..."
echo "----------------------"
echo ""
apt -qq update -y
echo ""
echo "-----------------------"
echo "Upgrading the distro..."
echo "-----------------------"
echo ""
apt -qq upgrade -y
echo ""
echo "-----------------------"
echo "Installing XFCE4..."
echo "-----------------------"
echo ""
apt -qq install xfce4 -y
echo ""
echo "-----------------------"
echo "Installing GIT"
echo "-----------------------"
echo ""
apt -qq install git -y
echo ""
echo "-----------------------"
echo "Clonning Theme Repo..."
echo "-----------------------"
echo ""
cd ~/Downloads/
git clone https://github.com/KazuoCode/LinuxThemes.git
if [ -d "~/.themes" ]; then
	cp -r ./LinuxThemes/xfce4/Circela ~/.themes/
else
	mkdir ~/.themes && cp -r ./LinuxThemes/xfce4/Circela
fi
echo ""
echo "-----------------------"
echo "Installing Tint2"
echo "-----------------------"
echo ""
apt -qq install tint2 -y
echo ""
echo "-----------------------"
echo "Installing Rofi"
echo "-----------------------"
echo ""
apt -qq install rofi -y
echo ""
echo "-----------------------"
echo "Setting Tint2 Theme..."
echo "-----------------------"
echo ""
cp -r ./LinuxThemes/xfce4/Material-xfce4/Launchy ~/.config/tint2/
echo ""
echo "-----------------------"
echo "Setting Rofi on Tint2"
echo "-----------------------"
echo ""
cp -r ./LinuxThemes/xfce4/Material-xfce4/Launchy/.util ~/
echo ""
echo "-----------------------"
echo "Setting GTK Theme..."
echo "-----------------------"
echo ""
cp -r ./LinuxThemes/xfce4/Material-xfce4/Fantome ~/.themes
echo ""
echo "----------------------------"
echo "Adding Tint2 to autostart..."
echo "----------------------------"
cp ./LinuxThemes/xfce4/Material-xfce4/tint2.desktop ~/.config/autostart/tint2.desktop
