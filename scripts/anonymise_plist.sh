#!/bin/sh

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <plist path>" >&2
  exit 1
fi

PLIST_PATH="$1"

if ! [ -f "$PLIST_PATH" ]; then
  echo "Path is not a file: $PLIST_PATH" >&2
  exit 1
fi

/usr/libexec/PlistBuddy -c "Set :PlatformInfo:Generic:MLB $OPEN_CORE_MLB" "$PLIST_PATH"
echo "Set PlatformInfo/Generic/MLB to $OPEN_CORE_MLB"
/usr/libexec/PlistBuddy -c "Set :PlatformInfo:Generic:SystemSerialNumber $OPEN_CORE_SystemSerialNumber" "$PLIST_PATH"
echo "Set PlatformInfo/Generic/SystemSerialNumber to $OPEN_CORE_SystemSerialNumber"
/usr/libexec/PlistBuddy -c "Set :PlatformInfo:Generic:SystemUUID $OPEN_CORE_SystemUUID" "$PLIST_PATH"
echo "Set PlatformInfo/Generic/SystemUUID to $OPEN_CORE_SystemUUID"
/usr/libexec/PlistBuddy -c "Set :PlatformInfo:Generic:ROM $OPEN_CORE_ROM" "$PLIST_PATH"
echo "Set PlatformInfo/Generic/ROM to $OPEN_CORE_ROM"
