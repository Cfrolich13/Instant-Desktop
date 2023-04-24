#If the script doesn't have what it takes, give up and run!
set -e
#Downloads theme from the lovely guthib
curl -o '/home/jovyan/Downloads/WhiteSur-Dark-solid-42-0.tar.xz'  https://raw.githubusercontent.com/vinceliuice/WhiteSur-gtk-theme/master/release/WhiteSur-Light-solid-42-0.tar.xz
#Extracts theme to themes folder to install
tar -xf '/home/jovyan/Downloads/WhiteSur-Dark-solid-42-0.tar.xz' -C '/home/jovyan/.themes'
#At last, the transformation is complete! Once the theme is set, we'll be unstoppable!!!!
xfconf-query -c xsettings -p /Net/ThemeName -s WhiteSur-Dark-solid