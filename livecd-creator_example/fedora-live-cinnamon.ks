%post
# cinnamon configuration

# create /etc/sysconfig/desktop (needed for installation)

cat > /etc/sysconfig/desktop <<EOF
PREFERRED=/usr/bin/cinnamon-session
DISPLAYMANAGER=/usr/sbin/lightdm
EOF

# set livesys session type
sed -i 's/^livesys_session=.*/livesys_session="cinnamon"/' /etc/sysconfig/livesys

%end