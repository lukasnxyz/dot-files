#!/bin/sh

screenCastOptions=$(echo -e "audio\nscreen\naudio+video\nscreen+audio\nend" | dmenu -i -p "screencast")
case $screenCastOptions in
        audio)
            ffmpeg -y \
                -f alsa -i default \
                "$HOME/dl/audiocast-$(date '+%y%m%d-%H%M-%S').mp4" & \
                            echo $! > /tmp/recordingpid
        ;;
        screen)
            ffmpeg -y \
                -f x11grab \
                -framerate 60 \
                -s "$(xdpyinfo | grep dimensions | awk '{print $2;}')" \
                -i "$DISPLAY" \
                -r 30 \
                -c:v h264 -crf 0 -preset ultrafast -c:a aac \
                "$HOME/dl/screencast-$(date '+%y%m%d-%H%M-%S').mp4" &
                            echo $! > /tmp/recordingpid
        ;;
        screen+audio)
            ffmpeg -y \
                -f x11grab \
                -framerate 60 \
                -s "$(xdpyinfo | grep dimensions | awk '{print $2;}')" \
                -i "$DISPLAY" \
                -f alsa -i default \
                -r 30 \
                -c:v h264 -crf 0 -preset ultrafast -c:a aac \
                "$HOME/dl/screencast-$(date '+%y%m%d-%H%M-%S').mp4" &
                            echo $! > /tmp/recordingpid
        ;;
        audio+video)
            ffmpeg -y \
                -f alsa -i default \
                -i /dev/video0 \
                "$HOME/dl/audiocast-$(date '+%y%m%d-%H%M-%S').mp4" & \
                            echo $! > /tmp/recordingpid
        ;;
        end)
            recpid="$(cat /tmp/recordingpid)"
            kill -15 "$recpid"
            rm -f /tmp/recordingpid
            exit
        ;;
esac
