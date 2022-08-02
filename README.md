# docker-ffmpeg-gif
A simple script to convert a video to a gif using docker container of jrottenberg/ffmpeg.
Thanks to [jrottenberg/ffmpeg](https://github.com/jrottenberg/ffmpeg) for the great work.

The input and output can **ONLY** be the video files in the **CURRENT DIRECTORY**.

Before use, make sure docker is installed and running.
```bash
$ ./src/script.sh -h

Convert a video to gif using docker container jrottenberg/ffmpeg
The input and output can only be the video files in the current directory

Usage:

    Usage: ./src/script.sh [-h | --help] [-i | --input <input file>] [-s | --scale <scale:default=-1:480>] [--fps <fps:default=15>] [--ffmpeg-args <ffmpeg arguments>] <output gif>
    
    -h, --help      display this help and exit
    -i, --input     input file
    -s, --scale     scale of the output gif, default is -1:480
    --fps           frames per second of the output gif, default 15
    --ffmpeg-args   additional ffmpeg arguments
```

## Usage
```bash
$ ./src/script.sh -i ScreenRecord2022-08-02.mov --ffmpeg-args "-ss 0 -t 3" --fps 5 output.gif 
```