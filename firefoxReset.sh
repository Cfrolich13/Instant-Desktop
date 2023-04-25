#!/bin/bash
#Ready!
sleep 7
for (( i=0; i<2; ++i)); do
    #Fire!
    firefox &
    #Hit!
    sleep 5
    #Reload!
    pkill firefox
    sleep 5
done
exit