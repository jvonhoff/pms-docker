FROM plexinc/pms-docker:plexpass

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y python3 git build-essential libargtable2-dev autoconf \
    automake libtool libtool-bin ffmpeg libsdl1.2-dev libavutil-dev \
    libavformat-dev libavcodec-dev mkvtoolnix && \
cd /opt && \
git clone git://github.com/erikkaashoek/Comskip && \
cd Comskip && \
./autogen.sh && \
./configure && \
make && \
cd /opt && \
git clone https://github.com/ekim1337/PlexComskip.git && \
chmod -R 777 /opt/ /tmp/ /root/ && \
touch /var/log/PlexComskip.log && \
chmod 777 /var/log/PlexComskip.log

ADD ./PlexComskip.conf /opt/PlexComskip/PlexComskip.conf
ADD ./comskip.sh /opt/PlexComskip/comskip.sh
ADD ./fixperms.sh /etc/cont-init.d/15-fixperms
ADD ./override_comskip.sh /etc/cont-init.d/18-override_comskip
ADD ./add_to_hostfile.sh /etc/cont-init.d/20-add_to_hostfile

RUN chmod 777 /opt/PlexComskip/comskip.sh
RUN mkdir -p "/config/Library/Application Support/Plex Media Server/Scripts"
