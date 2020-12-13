#!/bin/sh
# Script to do a two-way sync with a USB drive

function rsyncmedia() {
  LOCAL_DRIVE="/srv/share/media/"
  PORTABLE_DRIVE="/mnt/autosync/"
  RSYNC_PARMS="-rtuvn --modify-window=1 --size-only --exclude-from=$LOCAL_DRIVE/exclude.txt"

  MOUNT_STATUS=$(mount | grep autosync)
  MOUNT_CMD="/sbin/mount /dev/disk/by-uuid/5732DF544868E675"

  if [ -z $MOUNT_STATUS ]
    then
      echo "mounting bender"
      $MOUNT_CMD || exit 1
  fi

  rsync $RSYNC_PARMS $PORTABLE_DRIVE $LOCAL_DRIVE > $LOCAL_DRIVE/rsync.log && \
  sleep 1
  rsync $RSYNC_PARMS --delete $LOCAL_DRIVE $PORTABLE_DRIVE > $LOCAL_DRIVE/rsync.log && \
  sleep 1
  sync
  sleep 5

  echo "finished...umounting device"
  /sbin/umount $PORTABLE_DRIVE

}

rsyncmedia

# sudo -u bob DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send "SYNCSHARE Finished Synchronizing!"
