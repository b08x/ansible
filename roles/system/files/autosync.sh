#!/bin/sh
# Script to do a two-way sync with a USB drive

function rsyncmedia() {
  LOCAL_DRIVE="/srv/share/media/"
  PORTABLE_DRIVE="/mnt/autosync/"
  RSYNC_PARMS='-rtuvn --modify-window=1 --size-only --exclude ".csync*" --exclude ".owncloud*"'

  rsync $RSYNC_PARMS $PORTABLE_DRIVE $LOCAL_DRIVE
  sleep 1
  rsync $RSYNC_PARMS --delete $LOCAL_DRIVE $PORTABLE_DRIVE
  sleep 1
  sync
  sleep 5

  echo "finished...umounting device"
  /sbin/umount $PORTABLE_DRIVE

}


if [[ $(mount) | grep -c /mnt/autosync != 1 ]]; then
  /sbin/mount /dev/disk/by-uuid/5732DF544868E675 || exit 1
  echo "/mnt/autosync is now mounted"
fi

rsyncmedia





#
# if [ $(mount | grep -c /mnt/autosync) != 1 ]
# then
#   /sbin/mount /dev/disk/by-uuid/5732DF544868E675 || exit 1
#

  # rsync -rtuv --modify-window=1 --size-only --exclude ".csync*" --exclude ".owncloud*" /mnt/autosync/ /srv/share/media/
  # rsync -rtuv --modify-window=1 --size-only --exclude ".csync*" --exclude ".owncloud*" --delete /srv/share/media/ /mnt/autosync/
  #
  # sync

  # sudo -u bob DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send "SYNCSHARE Finished Synchronizing!"

  # sleep 5
  #
  # umount /mnt/autosync
# else
#   rsync -rtuv --modify-window=1 --size-only --exclude ".csync*" --exclude ".owncloud*" /mnt/autosync/ /srv/share/media/
#   rsync -rtuv --modify-window=1 --size-only --exclude ".csync*" --exclude ".owncloud*" --delete-delay /srv/share/media/ /mnt/autosync/
#
#   sync
#
#   # sudo -u bob DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send "SYNCSHARE Finished Synchronizing!"
#
#   sleep 5
#
#   umount /mnt/autosync
# fi
