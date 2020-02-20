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

/usr/libexec/PlistBuddy -c "Set :PlatformInfo:Generic:MLB REDACTED" "$PLIST_PATH"
/usr/libexec/PlistBuddy -c "Set :PlatformInfo:Generic:SystemSerialNumber REDACTED" "$PLIST_PATH"
/usr/libexec/PlistBuddy -c "Set :PlatformInfo:Generic:SystemUUID REDACTED" "$PLIST_PATH"
/usr/libexec/PlistBuddy -c "Set :PlatformInfo:Generic:ROM REDACTED" "$PLIST_PATH"

echo "Anonymised :PlatformInfo:Generic:MLB, PlatformInfo:Generic:SystemSerialNumber, PlatformInfo:Generic:SystemUUID, and PlatformInfo:Generic:ROM in $PLIST_PATH"
