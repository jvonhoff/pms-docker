#!/bin/sh
/usr/bin/mkvpropedit "$1" --edit track:a1 --set language=eng --edit track:v1 --set language=eng
sleep 10
/usr/bin/python /opt/PlexComskip/PlexComskip.py "$1"
