#!/bin/bash

echo $0

#example:
# sh source/images/shrink_img.sh ~/Documents/nicole-blog/source/images/blog/xxxx-folder-name

# To convert a single image - example:
# convert site-header-img.jpg -resize 1000x1000\> -quality  80% site-header-img.jpg

echo ""
echo "Checking for Images to shrink..."
echo ""

find $1 -type f -exec sh -c '
	filename=$(basename "$0")
	extension="${filename##*.}"
	filename="${filename%.*}"

	#size=$(wc -c <"$0")
	#file_is_big=$(($size > 1000000))

	width=$(identify -format "%w" "$0")> /dev/null
	height=$(identify -format "%h" "$0")> /dev/null

	if [ $extension != "jpg" ] || [ $width -gt 1700 ] || [ $height -gt 1700 ]; 
	then
		dir=$(dirname "$0")

		echo "Shrinking...$0 to $filename.jpg"

		convert "$0" -resize 1700x1700\> -quality  70% "$dir/$filename.jpg"

		if [ "$extension" != "jpg" ]
		then
			echo "DELETING...$0"
			rm "$0"
		fi
	fi
' {} ';'
