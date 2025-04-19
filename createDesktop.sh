#!/usr/bin/env sh

if [ "$#" -ne 1 ]; then
    echo "How to use: $0 /path/to/your.AppImage"
    exit 1
fi

APPIMAGE="$1"
APP_NAME=$(basename "$APPIMAGE" .AppImage)
DESKTOP_FILE="$HOME/.local/share/applications/$APP_NAME.desktop"

mkdir -p "$HOME/.local/share/applications"

cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Type=Application
Name=$APP_NAME
Exec="$APPIMAGE" %U
Icon=$APP_NAME
Terminal=false
Categories=Utility;Application;
EOF

chmod +x "$DESKTOP_FILE"

# if [ -f "$APPIMAGE" ]; then
#     TEMP_DIR=$(mktemp -d)
#     "$APPIMAGE" --appimage-extract .DirIcon >/dev/null 2>&1 || true
#     if [ -f ".DirIcon" ]; then
#         mv ".DirIcon" "$HOME/.local/share/icons/$APP_NAME.png"
#         sed -i "s|Icon=$APP_NAME|Icon=$HOME/.local/share/icons/$APP_NAME.png|" "$DESKTOP_FILE"
#     fi
#     rm -rf "$TEMP_DIR"
# fi

# update-desktop-database "$HOME/.local/share/applications"

echo "Success: $DESKTOP_FILE"
