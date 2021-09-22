# PMS-Docker

Forked from Kevin McGill's excellent repository at https://github.com/kmcgill88/k-plex  Changes include migrating to the official Plex Docker image, instead of LinuxServer.IO's version.

Inspired by Plex DVR. This container has [Comskip](https://github.com/erikkaashoek/Comskip) and [PlexComskip](https://github.com/ekim1337/PlexComskip) installed to remove commercials from any DVR'd content. 

### Changes:
- Users can add their own `comskip.sh` file to the `/config` directory.  This will be used (via symlink) instead of the one in the image.
- USB tuners (WinTV-DualHD, for example) won't get lost between reboots, thanks to permissions fixes on /dev/dvb.
- If you use the PLEX_UID and PLEX_GID parameters, the permissions will be set to have a `umask=0002` so that files are still writable by the users group.

### Comskip ideas:
My personal comskip.sh will transcode things that I record for my kids (They have their own folder) to 480p, since cartoons don't really need all that bitrate
```
#!/bin/sh
umask 0002
/usr/bin/mkvpropedit "$1" --edit track:a1 --set language=eng --edit track:v1 --set language=eng
sleep 10
tempfile=$(mktemp --suffix=.mkv)
outfile=$(echo "$1" | sed 's|\.ts|\.mkv|')
filter="yadif"
(echo "$1" | grep -Eq "/Kids") && filter='yadif, scale=-2:480'
ffmpeg -i "$1" -vf "$filter" -c:a copy -c:v libx264 -crf 22 -preset veryfast -threads 0 -y "$tempfile" && mv "$tempfile" "$outfile" && rm "$1"
chown plex:plex "$outfile"
/usr/bin/python /opt/PlexComskip/PlexComskip.py "$outfile"
```

### How to use:
- [Pull pms-docker from docker](https://hub.docker.com/r/jvonhoff/pms-docker/) by running, `docker pull jvonhoff/pms-docker`
- Run the container as described by [plexinc/pms-docker](https://github.com/plexinc/pms-docker)
- Once running, go to Plex Settings, then DVR (Beta)
- DVR Settings
- Scroll to `POSTPROCESSING SCRIPT`
- Enter `/opt/PlexComskip/comskip.sh`
- Click `Save`.
- Enjoy commercial free TV!

![](https://raw.githubusercontent.com/wiki/mandreko/pms-docker/mandreko-pms-docker.png)

When DVR recordings end, `Comskip` will automatically run and the show will be added to your Plex library.
