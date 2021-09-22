#!/bin/bash

if [ -f /config/PlexComskip.conf ] ; then
	rm /opt/PlexComskip/PlexComskip.conf
	ln -s /config/PlexComskip.conf /opt/PlexComskip/PlexComskip.conf
fi

if [ -f /config/comskip.sh ] ; then
	rm /opt/PlexComskip/comskip.sh
	ln -s /config/comskip.sh /opt/PlexComskip/comskip.sh
fi

if [ -f /config/mycomskip.log ] ; then
	rm /var/log/mycomskip.log
	ln -s /config/mycomskip.log /var/log/mycomskip.log
	chmod 0777 /var/log/mycomskip.log
	chown plex:plex /var/log/mycomskip.log
fi

chmod +x /opt/PlexComskip/comskip.sh
