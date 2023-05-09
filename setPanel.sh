#!/usr/bin/env bash

# xfconf-query default command...
xfconf-panel() {
	command xfconf-query -c xfce4-panel -p /panels"$@"
}

#No one knows what this means. If you do, you're lying, but please create a pull request anyways.
text_to_slug() {
	echo "${@,,}" | tr -d '[:punct:]'    \
			  | sed -e "s/ /-/g"    \
			  	  -e "s/[áàãâä]/a/g" \
			  	  -e "s/[éêä]/e/g"   \
			  	  -e "s/[íÍï]/i/g"   \
			  	  -e "s/[óõôö]/o/g"  \
			  	  -e "s/[úü]/u/g"    \
			  	  -e "s/[ç]/c/g"
}

#Top panel
xdotool sleep 5 mousemove 960 527 click 1 sleep 0.01 mousemove restore sleep 1 key Return
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
#Sets original bottom panel layout to variable
PLUGIN_IDS=$(xfconf-query -c xfce4-panel -p /panels/panel-2/plugin-ids| grep -v "Value is an\|^$")
#Changes IFS to newline
IFS=$'\n'
#Converts plugin id variable from string to array
PLUGIN_IDS=($PLUGIN_IDS)
#Resets IFS
unset IFS
#Sets each array value to its own variable because I don't feel like typing "{PLUGIN_IDS[#]}" every time I need to use it
ID1=${PLUGIN_IDS[0]}
ID2=${PLUGIN_IDS[1]}
ID3=${PLUGIN_IDS[2]}
ID4=${PLUGIN_IDS[3]}
ID5=${PLUGIN_IDS[4]}
ID6=${PLUGIN_IDS[5]}
ID7=${PLUGIN_IDS[6]}
ID8=${PLUGIN_IDS[7]}



PANELS=($(xfconf-panel | sed 1,2d))

# Plugin IDs...
for p in ${PANELS[@]}; do
	# Get positions...
	POSITIONS[$p]=$(xfconf-panel "/panel-$p/position" | sed -n "s/p=\([^;]*\);.*/\1/p")
	# Get plugin IDs by panel...
	PANEL_PLUGINS[$p]=$(xfconf-panel "/panel-$p/plugin-ids" 2> /dev/null | sed 1,2d)
	# Get all current plugins IDs...
	PLUGIN_IDS_ALL+=(${PANEL_PLUGINS[$p]})
done

# Get next plugin ID available...
IFS=$'\n'
SORTED=($(sort -n <<< "${PLUGIN_IDS_ALL[*]}"))
unset IFS
NEXT_PLUGIN=$((${SORTED[@]: -1} + 1))

APPNAME="Firefox"
DESKTOP_FILE_NAME="$(text_to_slug "$APPNAME").desktop"
DESKTOP_FILE_PATH="$HOME/.config/xfce4/panel/launcher-$NEXT_PLUGIN"


#Copy the file to the path somewhere in here
mkdir -p "$DESKTOP_FILE_PATH"
echo "$(<Firefox.desktop )" > "$DESKTOP_FILE_PATH/$DESKTOP_FILE_NAME"


# Add new launcher to xfconf plugins entry...
xfconf-query -c xfce4-panel -p /plugins/plugin-${NEXT_PLUGIN} -t string -s "launcher" --create
# Add new desktop file to new plugin entry...
xfconf-query -c xfce4-panel -p /plugins/plugin-${NEXT_PLUGIN}/items -t string -s "${DESKTOP_FILE_NAME}" -a --create

# Clear plugin IDs from selected panel...
xfconf-query -c xfce4-panel -p /panels/panel-2/plugin-ids -rR

xfconf-query -c xfce4-panel -p /panels/panel-2/plugin-ids -n -t int -s $NEXT_PLUGIN -a
xfce4-panel -r
/home/jovyan/firefoxReset.sh