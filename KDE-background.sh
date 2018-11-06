#!/bin/bash
# Downloads latest imagery from GOES-East and sets as desktop background on KDE.

DOWNLOAD_LOCATION=/home/benjamin/pictures # Change as needed
SIZE=1808 # Images are square, SIZE x SIZE. Possible values are 678, 1808, 5424, or 10848
RAND_APPEND=$RANDOM
FILE_NAME=$DOWNLOAD_LOCATION/$SIZE\x$SIZE.$RAND_APPEND.jpg

rm $(ls $DOWNLOAD_LOCATION/$SIZE\x$SIZE*)
wget -P $DOWNLOAD_LOCATION https://cdn.star.nesdis.noaa.gov/GOES16/ABI/FD/GEOCOLOR/$SIZE\x$SIZE.jpg
mv $DOWNLOAD_LOCATION/$SIZE\x$SIZE.jpg $FILE_NAME

qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript '
    var allDesktops = desktops();   
    for (i=0;i<allDesktops.length;i++) {{
        d = allDesktops[i];
        d.wallpaperPlugin = "org.kde.image";
        d.currentConfigGroup = Array("Wallpaper",
                                     "org.kde.image",
                                     "General");
        d.writeConfig("Image", "file://'$FILE_NAME'");
    }}
'
