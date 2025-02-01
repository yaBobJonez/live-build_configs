#!/bin/bash

# Create desktop links for live user

if [ -f "/var/lib/live/hooks-setup-complete" ]; then
    exit 0
fi

echo
echo "live-config: desktop-setup"

LIVE_DESKTOP_DIR="/home/user/Стільниця"
mkdir -p "${LIVE_DESKTOP_DIR}"

# cat > "${LIVE_DESKTOP_DIR}/Introduction.desktop" << EOF
# [Desktop Entry]
# Icon=dialog-information
# Name=Крутєйший відос :)
# Type=Link
# URL=https://www.youtube.com/watch?v=dCStUMQ5VQQ
# EOF

cat > "/home/user/.local/share/applications/calamares.desktop" << EOF
[Desktop Entry]
Type=Application
Categories=System;
Icon=calamares
Name=Встановити Sample OS
GenericName=Засіб встановлення системи
Comment=Встановити цей респін Debian на диск
Exec=sudo calamares
Keywords=install;system;sampleos;встановити;система;інсталятор
EOF
if [[ ${LIVE_CONFIG_CMDLINE} != *"persistence"* ]]; then
    ln -s "/home/user/.local/share/applications/calamares.desktop" "${LIVE_DESKTOP_DIR}/calamares.desktop"
fi

for file in "Корисно знати.md" "(ОБЕРЕЖНО) Створити persistence розділ.sh"
do
    ln -s "/run/live/medium/${file}" "${LIVE_DESKTOP_DIR}/${file}"
done

chown -R user:user "${LIVE_DESKTOP_DIR}"

if [[ ${LIVE_CONFIG_CMDLINE} == *"persistence"* ]]; then
    touch /var/lib/live/hooks-setup-complete
fi
