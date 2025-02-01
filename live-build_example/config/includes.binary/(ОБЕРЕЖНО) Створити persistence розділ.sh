#!/bin/bash

msg="$(lsblk -o TYPE,NAME,SIZE,MOUNTPOINTS)\n\nВведіть NAME того диску (disk, а не part), з якого завантажена ця ОС (наприклад, «sda»).\nУВАГА: на диску буде створено розділ і перезаписана файлова система!"
drive=$(kdialog --title 'Виберіть цю флешку' --inputbox "$msg")
if [ -z "$drive" ] || ! kdialog --title "Точно?" --warningyesno "Ви впевнені, що можна продовжити?"; then
    exit 1
fi
drive="/dev/${drive}"
if [[ ! -e "$drive" ]]; then
   kdialog --error "Вказаний диск не знайдений."
   exit 1
fi

newPartNum=$((
echo n
echo
echo
echo
echo
echo y
echo w
) | sudo fdisk --wipe never -t dos "$drive" | grep -oP 'partition \K\d+')
partition="${drive}${newPartNum}"

echo y | sudo mkfs.ext4 -L 'persistence' "$partition"

sudo mount "$partition" /mnt
echo '/ union' | sudo tee /mnt/persistence.conf
sudo umount /mnt

if kdialog --title 'Наче готово?..' --yesno "Для початку збереження змін треба перезавантажи систему.\nЗробити це зараз?"; then
    sudo systemctl reboot
fi
