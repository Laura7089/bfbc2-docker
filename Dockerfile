FROM fragsoc/steamcmd-wine-xvfb
ARG UID=999
ARG GID=999

# install needed packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y --no-install-recommends \
        libgl-dev libgl1 cabextract winbind unzip libarchive-tools && \
    apt-get clean

# create user, then switch to it
RUN mkdir /battlefield && \
    groupadd -g $GID battlefield && \
    useradd -g battlefield -u $UID -d /battlefield battlefield && \
    chown -R battlefield:battlefield /battlefield
USER battlefield
WORKDIR /battlefield

# install gameserver dependencies
# must be run in xvfb-run for the installers to be able to think they have a display
RUN xvfb-run winetricks --unattended \
    dinput8 vcrun2005 vcrun2008 vcrun2010

# download and set up server files
RUN wget 'https://deac-fra.dl.sourceforge.net/project/battlefieldbadcompany2mase/Bc2emu_V09.rar' && \
    bsdtar -xf Bc2emu_V09.rar && \
    mv Bc2emu server && \
    rm -fv Bc2emu_V09.rar
RUN wget 'https://veniceunleashed.net/files/rome.zip' && \
    unzip rome.zip && \
    mv dinput8.dll server/dinput8.dll && \
    rm -fv rome.zip

STOPSIGNAL SIGKILL

# project rome port
EXPOSE 19567/tcp

ENV TINI_SUBREAPER=""
WORKDIR /battlefield/server
ENTRYPOINT ["tini", "--", "xvfb-run", "-a", "--", "wine", "./Frost.Game.Main_Win32_Final.exe", "-serverInstancePath", "Instance/", "-mapPack2Enabled", "1", "-port", "19567", "-timeStampLogNames"]
CMD ["-region", "OC", "-heartBeatInterval", "20000"]
