#Top panel
xdotool sleep 3 mousemove 960 527 click 1 sleep 0.01 mousemove restore sleep 1 key Return
sleep 2
xfconf-query -c xfce4-panel -p /panels/panel-1/size -s 21
#WM Button Layout
xfconf-query -c xfwm4 -p /general/button_layout -s "CHM|"