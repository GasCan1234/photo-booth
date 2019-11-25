#!/bin/bash

USB_MOUNT="/media/pi/Transcend"

cd /home/pi/photo-booth

unlink photos
if grep -qs "$USB_MOUNT" /proc/mounts; then
  echo "USB Stick found, use this for photos..."
  ln -s photos_extern photos
else
  echo "No USB Stick found, use SD-Card for photos..."
  ln -s photos_local photos	
fi

/usr/bin/python camera.py
