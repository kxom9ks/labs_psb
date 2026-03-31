#!/bin/bash

modules="/proc/filesystems"
cmd=$(grep -Ew "cramfs|freevxfs|jffs2|hfs|hfsplus|squashfs" "$modules" | xargs)

if [[ "$cmd" == "" ]]; then

echo Everything ok.

else

echo "$cmd"

fi


