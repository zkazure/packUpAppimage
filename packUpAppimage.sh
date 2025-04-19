#!/usr/bin/env sh


if [ -z "$1" ]; then
echo "Please provide the Appimage whith absolute file path"
exit 1
fi

APPIMAGE="$1"
DIR_NAME=$(dirname "$APPIMAGE")

if [ ! -f "$APPIMAGE" ]; then
echo "File $APPIMAGE is not exit, please checkout the file path"
exit 1
fi

# This code will extrac file to path with this script
echo "Extracting $APPIMAGE ..."
chmod +x "$APPIMAGE"
"$APPIMAGE" --appimage-extract

EXTRACTED_DIR="squashfs-root"
if [ ! -d "$EXTRACTED_DIR" ]; then
echo "Fail to find the extracted path: $EXTRACTED_DIR"
exit 1
fi


./appimagetools/appimagetool-x86_64.AppImage $EXTRACTED_DIR
rm -r $EXTRACTED_DIR


OUTPUT_DIR="$HOME/Applications"
mkdir -p "$OUTPUT_DIR"

mv ./*.AppImage $OUTPUT_DIR

echo "####################################"
echo "Success!!! Now the packup Appimage in $OUTPUT_DIR"
echo "####################################"
