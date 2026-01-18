#!/bin/bash

TRACKS="tracks.txt"
TYPE="flac"
M3U="m3u"

if [ ! -z $1 ]; then
    TRACKS=$1
fi

if [ ! -f $TRACKS ]; then
    echo "rename_tracks: Missing $TRACKS in current directory"
    exit
fi

i=1
while [ true ]
do
    FILE=$(printf "%02d - Track %d.$TYPE" $i $i)
    #echo $FILE

    if [ -f "$FILE" ]; then
        TNUM=$(printf "^%02d - " $i)
                NAME=$(grep "$TNUM" $TRACKS)

                NEW_FILE=$(printf "$NAME"."$TYPE")

        #echo $NEW_FILE
        echo "renaming '$FILE' to '$NEW_FILE'"
        mv "$FILE" "$NEW_FILE"
    else
        break
    fi

    i=$(($i+1))
done

TITLE=$(grep -m1 "" $TRACKS)

M3UFILE=$(ls *.m3u)
NEW_M3UFILE=$(printf "$TITLE.$M3U")
echo "renaming '$M3UFILE' to '$NEW_M3UFILE'"
mv "$M3UFILE" "$NEW_M3UFILE"
