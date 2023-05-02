#Top panel
xdotool sleep 3 mousemove 960 527 click 1 sleep 0.01 mousemove restore sleep 1 key Return
sleep 2
xfconf-query -c xfce4-panel -p /panels/panel-1/size -s 21
#WM Button Layout
xfconf-query -c xfwm4 -p /general/button_layout -s "CHM|"
#Begin docking manuever. 
#T -5
#   4
#   3
#   2
#   1
#Sets temporary IFS variable to avoid too much destruction
TEMP=$IFS
#Sets original bottom panel layout to variable
PLUGIN_IDS=$(xfconf-query -c xfce4-panel -p /panels/panel-2/plugin-ids| grep -v "Value is an\|^$")
#Changes IFS to newline
IFS=$'\n'
#Converts plugin id variable from string to array
PLUGIN_IDS=($PLUGIN_IDS)
#Resets IFS
IFS=$TEMP
#Sets each array value to its own variable because I don't feel like typing "{PLUGIN_IDS[#]}" every time I need to use it
ID1=${PLUGIN_IDS[0]}
ID2=${PLUGIN_IDS[1]}
ID3=${PLUGIN_IDS[2]}
ID4=${PLUGIN_IDS[3]}
ID5=${PLUGIN_IDS[4]}
ID6=${PLUGIN_IDS[5]}
ID7=${PLUGIN_IDS[6]}
ID8=${PLUGIN_IDS[7]}