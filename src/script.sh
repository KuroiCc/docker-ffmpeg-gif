#!/bin/bash

# Thanks Bruno Bronosky and Mateen Ulhaq's great sample for parsing command line arguments
# https://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash#answer-14203146
# reference date: 2022-08-02
HELP_MESSAGE="
Convert a video to gif using docker container jrottenberg/ffmpeg
The input and output can only be the video files in the current directory

Usage:

    Usage: $0 [-h | --help] [-i | --input <input file>] [-s | --scale <scale:default=-1:480>] [--fps <fps:default=15>] [--ffmpeg-args <ffmpeg arguments>] <output gif>
    
    -h, --help      display this help and exit
    -i, --input     input file
    -s, --scale     scale of the output gif, default is -1:480
    --fps           frames per second of the output gif, default 15
    --ffmpeg-args   additional ffmpeg arguments
"

POSITIONAL_ARGS=()

while [[ $# -gt 0 ]]; do
    case $1 in
    -i | --input)
        INPUT="$2"
        shift # past argument
        shift # past value
        ;;
    -s | --scale)
        SCALE="$2"
        shift # past argument
        shift # past value
        ;;
    --fps)
        FPS="$2"
        shift # past argument
        shift # past value
        ;;
    --ffmpeg-args)
        FFMPEG_ARGS="$2"
        shift # past argument
        shift # past value
        ;;
    -h | --help)
        echo "$HELP_MESSAGE"
        exit 0
        ;;
    --default)
        DEFAULT=YES
        shift # past argument
        ;;
    -* | --*)
        echo "Unknown option $1"
        exit 1
        ;;
    *)
        POSITIONAL_ARGS+=("$1") # save positional arg
        shift                   # past argument
        ;;
    esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

if [ ! -n "$1" ]; then
    echo "enter the output file name!"
    exit 1
fi

if [ ! -n "$INPUT" ]; then
    echo "enter the input file name!"
    exit 1
fi

if [ ! -n "$SCALE" ]; then
    SCALE="-1:480"
fi

if [ ! -n "$FPS" ]; then
    FPS="15"
fi

docker run -v $(pwd):$(pwd) -w $(pwd) -it \
    jrottenberg/ffmpeg:5.0.1-scratch313 \
    -stats \
    -i "$INPUT" \
    $FFMPEG_ARGS \
    -filter_complex "[0:v]fps=$FPS,scale=$SCALE,split[a][b];[a]palettegen[p];[b][p]paletteuse" \
    "$1"
