#!/bin/sh

# Search plugins extractor
# * Extract searchplugins from Firefox profile directory

FXPROFILE=${USERPROFILE//\\/\/}/AppData/Roaming/Mozilla/Firefox/Profiles
PLUGEXT=*.xml


# Remove current plugins
rm ${PLUGEXT}

# Copy plugins from Firefox's user profile directory
find "${FXPROFILE}" -type f -iname "${PLUGEXT}" -ipath "*/searchplugins/*" -exec cp {} . \;


# Change linefeed code to LF only
for file in `ls -1 ${PLUGEXT}`; do
  echo Processing "${file}"...

  tr -d "\r" < ${file} > ${file}.lf
  mv ${file}.lf ${file}
done


# Update mode
chmod 0644 ${PLUGEXT}

