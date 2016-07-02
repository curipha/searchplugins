#!/usr/bin/env bash

# Search plugins extractor
# * Extract searchplugins from Firefox profile directory

set -o nounset
set -o errexit

FXPROFILE="${USERPROFILE//\\/\/}/AppData/Roaming/Mozilla/Firefox/Profiles"
PLUGEXT=.xml


# Change directory to the same level as this script
cd "$(dirname "${0}")"

# Remove current plugins
rm -f -- *${PLUGEXT}

# Copy plugins from Firefox's user profile directory
find "${FXPROFILE}" -type f -iname "*${PLUGEXT}" -ipath "*/searchplugins/*" -exec cp {} . \;

# Processing each file
for file in `ls -1 *${PLUGEXT}`; do
  echo Processing "${file}"...

  tr -d "\r" < ${file} > ${file}.lf
  mv "${file}.lf" "${file}"
  chmod 0644 "${file}"
done

