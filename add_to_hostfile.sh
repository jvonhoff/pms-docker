#! /bin/sh

ip=$(curl -v nhl.freegamez.ga 2>&1 | grep "Connected to" | perl -pe 's|.*\((\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\).*|$1|')

cat /etc/hosts | sed '/nhl.com/d;/mlb.com/d' > /etc/newhosts

echo "${ip}	mf.svc.nhl.com" >> /etc/newhosts
echo "${ip}	mlb-ws-mf.media.mlb.com" >> /etc/newhosts
echo "${ip}	playback.svcs.mlb.com" >> /etc/newhosts

mv /etc/newhosts /etc/hosts

