#!/bin/sh -ex

echo "Fixing perms..."

# Sleep to let the host bring up the dvb devices
sleep 30

if [ ! "$PLEX_UID"x = "x" ] ; then
	usermod -u $PLEX_UID plex
fi

#find /config ! -user plex -exec chown plex:plex "{}" \;

for x in "/config/Library/Application Support/Plex Media Server/Logs" /transcode /data /dev/dvb
do
	if [ "$(stat -c '%U' "$x")" != "plex" ]; then
		chown -R plex:plex "$x"
        fi
	echo
done

echo "Fixing LD_LIBRARY_PATH..."
sed -i 's|LD_LIBRARY_PATH=/usr/lib/plexmediaserver\ |LD_LIBRARY_PATH=/usr/lib/plexmediaserver/lib\ |' /etc/services.d/plex/run 

exec s6-setuidgid plex /bin/sh -c 'umask 0002'
