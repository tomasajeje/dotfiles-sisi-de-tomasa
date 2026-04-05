#!/bin/bash
# Lee el porcentaje y el estado de BAT1 o BAT0 ahi ves tu
cat /sys/class/power_supply/BAT1/capacity | xargs echo "%"
