#If the script doesn't have what it takes, give up and run!
set -e
#Makes downloads and theme directories
mkdir -p $HOME/Downloads
mkdir -p $HOME/.themes
#Downloads theme from the lovely guthib
curl -L -o '/home/jovyan/Downloads/WhiteSur-Dark-44-0.tar.xz'  https://raw.githubusercontent.com/vinceliuice/WhiteSur-gtk-theme/master/release/WhiteSur-Dark-44-0.tar.xz
#Extracts theme to themes folder to install
tar -xf '/home/jovyan/Downloads/WhiteSur-Dark-44-0.tar.xz' -C '/home/jovyan/.themes'
#At last, the transformation is complete! Once the theme is set, we'll be unstoppable!!!!
xfconf-query -c xsettings -p /Net/ThemeName -s WhiteSur-Dark
xfconf-query -c xfwm4 -p     /general/theme -s WhiteSur-Dark