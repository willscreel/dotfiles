#!/bin/bash

# This is a simple script to search a directory for TIFF images and convert them to PDF.
# It relies on find, tiff2pdf, and egrep to work its magic.
# Files ending in '.tiff' or '.tif' (in any case) are supported.

if [ $# -ne 1 ]; then
	echo "Syntax: $0 DIRECTORY_CONTAINING_TIFFS_TO_CONVERT"
	exit 1
fi

dir_to_search=$1
if [ ! -d "$dir_to_search" ]; then
	echo "ERROR! Invalid search directory \"$dir_to_search\""
	exit 1
fi

tiffs=$(find "$dir_to_search" -type f -regextype 'posix-egrep' -iregex '.*\.tif[f]{0,1}$' -exec echo -n {}';' \;)

OLDIFS="$IFS"
IFS=';'

for tiff in $tiffs; do
	echo $tiff | grep -qsiE '\.tif$'
	if [ $? -eq 0 ]; then
		extension_length=3
	else
		extension_length=4
	fi
	pdf="${tiff:0:$((${#tiff}-$extension_length))}pdf"

	echo "tiff2pdf -o \"$pdf\" \"$tiff\""
	tiff2pdf -o "$pdf" "$tiff"
done

IFS="$OLDIFS"

exit 0
