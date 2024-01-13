#!/bin/bash

# Tweak calamares-settings-debian

if [ -f "/var/lib/live/hooks-setup-complete" ]; then
    exit 0
fi

echo
echo "live-config: debian-calamares"

rm /etc/xdg/autostart/calamares-desktop-icon.desktop
rm /usr/bin/add-calamares-desktop-icon
rm /usr/share/applications/calamares-install-debian.desktop
sed -i -e 's/  - keyboard/# - keyboard/g' /etc/calamares/settings.conf
cat >> /etc/calamares/modules/packages.conf << EOF
      - 'calamares'
      - 'boot-repair'
EOF
sed -i -e 's/requiredStorage: \+10/requiredStorage:    20/' /etc/calamares/modules/welcome.conf
cat > /usr/sbin/sources-final << EXTEOF
#!/bin/bash
#
# Writes the final sources.list file
#

CHROOT=$(mount | grep proc | grep calamares | awk '{print $3}' | sed -e "s#/proc##g")
RELEASE="testing"

cat << EOF > $CHROOT/etc/apt/sources.list
deb http://deb.debian.org/debian/ $RELEASE main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian/ $RELEASE main contrib non-free non-free-firmware

deb http://security.debian.org/ $RELEASE-security main contrib non-free non-free-firmware
deb-src http://security.debian.org/ $RELEASE-security main contrib non-free non-free-firmware

deb http://deb.debian.org/debian/ $RELEASE-updates main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian/ $RELEASE-updates main contrib non-free non-free-firmware
EOF

exit 0
EXTEOF
