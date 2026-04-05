#!/bin/bash
# Lee el porcentaje y el estado de BAT1
cat /sys/class/power_supply/BAT1/capacity | xargs echo "%"
