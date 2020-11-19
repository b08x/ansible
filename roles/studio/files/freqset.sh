#!/bin/sh -
echo 3072 > /sys/class/rtc/rtc0/max_user_freq

cpupower -c all frequency-set -g performance
