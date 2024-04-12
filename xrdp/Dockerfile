ARG IMAGE_TAG=stable
FROM supervisord:${IMAGE_TAG} as xrdp

ARG DOCKER_USER developer

#https://github.com/satishweb/docker-xrdp/blob/master/Dockerfile
# RUN \
    # /run.sh APTupdate \
    # && apt-get -y install xfce4 xfce4-goodies xorg dbus-x11 x11-xserver-utils \
    # && apt-get -y install xrdp xorgxrdp \
    # && /run.sh clean

RUN \
    /run.sh APTinstall \
      xfce4 \
      xfce4-goodies \
      xorg dbus-x11 \
      x11-xserver-utils \
      xrdp \
      xorgxrdp 

COPY ./files/supervisord/* /etc/supervisor/conf.d/

## XRDP Config
RUN printf '%s\n' 'session required pam_env.so readenv=1' >> /etc/pam.d/xrdp-sesman
# send xrdp services output to stdout
RUN ln -sf /dev/stdout /var/log/xrdp.log
RUN ln -sf /dev/stdout /var/log/xrdp-sesman.log


# Disable forking, new cursors and enable high tls ciphers for xrdp
RUN sed -i "\
  s/fork=true/fork=false/g; \
  s/\#tls_ciphers=HIGH/tls_ciphers=HIGH/g; \
  s/^new_cursors=true/new_cursors=false/g \
" /etc/xrdp/xrdp.ini

# Disable root login and syslog logging for xrdp-sesman
RUN sed -i "\
  s/AllowRootLogin=true/AllowRootLogin=false/g; \
  s/EnableSyslog=1/EnableSyslog=0/g \
" /etc/xrdp/sesman.ini

# Disable light-locker
RUN ln -s /usr/bin/true /usr/bin/light-locker
# Remove annoying multiple auth popups after rdp login
#COPY files/46-allow-update-repo.pkla /etc/polkit-1/localauthority/50-local.d/46-allow-update-repo.pkla
# Allow all users to start xserver
RUN echo 'allowed_users=anybody' > /etc/X11/Xwrapper.config
RUN chmod g+w /etc/xrdp
RUN chmod u+s /usr/sbin/xrdp-sesman
RUN chmod u+s /usr/sbin/xrdp



FROM xrdp as xrdp_configured

# add to groups
RUN adduser xrdp ssl-cert && echo "User: ${DOCKER_USER}" && adduser ${DOCKER_USER} ssl-cert 

# add custom keys and certificates
# COPY ./files/cert.pem /etc/xrdp/cert2.pem
# COPY ./files/key.pem /etc/xrdp/key2.pem
# RUN sed -i " \
    # s/certificate=/certificate=cert2.pem/g; \
    # s/key_file=/key_file=key2.pem/g; \
    # " /etc/xrdp/xrdp.ini 
 
RUN chmod 644 /etc/xrdp/cert2.pem
RUN chmod 640 /etc/xrdp/key2.pem
RUN chown :xrdp /etc/xrdp/key2.pem

# add pulse server host
RUN echo "export PULSE_SERVER=pulse.server" > /etc/X11/Xsession.d/999pulse_server_env

ENTRYPOINT ["/usr/bin/supervisord"]
