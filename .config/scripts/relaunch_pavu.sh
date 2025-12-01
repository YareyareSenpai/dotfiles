#!/bin/bash
pkill -f pavucontrol
sleep 0.5
GDK_BACKEND=x11 pavucontrol "$@" &
