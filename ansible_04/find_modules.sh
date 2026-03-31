#!/bin/bash

modules="/proc/filesystems"
cmd=$(lsmod | grep -Ew "cramfs|freevxfs|jffs2|hfs|hfsplus|squashfs"|xargs)

if [[ "$cmd" == "" ]]; then

echo Everything ok.

else

echo "$cmd"

fi


