#!/bin/bash
dialogApp="/usr/local/bin/dialog"

title="Name This Mac"
message="Enter the preferred computer name below"

hwType=$(/usr/sbin/system_profiler SPHardwareDataType | grep "Model Name" | grep "Book")  
if [ "$hwType" != "" ]; then
  icon="SF=laptopcomputer"
  else
  icon="SF=desktopcomputer"
fi

dialogCMD="$dialogApp -p --title \"$title\" \
--icon \"$icon\" \
--message \"$message\" \
--small \
--textfield \"Computer Name\""

computerName=$(eval "$dialogCMD" | awk -F " : " '{print $NF}')

scutil --set HostName "$computerName" || echo "Error setting HostName"
scutil --set LocalHostName "$computerName" || echo "Error setting LocalHostName"
scutil --set ComputerName "$computerName" ||  echo "Error setting ComputerName"
