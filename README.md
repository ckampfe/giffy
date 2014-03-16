giffy
=====

You want to make animated gifs. You don't want to mess around for 5 hours
with ffmpeg and imagemagicks' arcana. Enter giffy.

giffy depends on [ffmpeg](http://ffmpeg.org/) and [imagemagick](http://www.imagemagick.org/), so please install them before attempting use. I recommend [homebrew](http://brew.sh/).

## usage

#### simple case, using defaults:
```
giffy -i your_vid.mp4
```
This will create an animation called 'animation.gif' with a length of 3 seconds,
starting from 00:00:00 of your input file.


#### you choose the start time, duration, and animation file name:
```
giffy -i your_vid.mp4 -s 00:10:02 -t 4 your_output.gif
```
This uses the -s and -t options to specify a start time and duration. The output
file will be called 'your_output.gif'.

options:
```
-i, --input FILE
-s, --start [HH:MM:SS] default=00:00:00
-t, --duration [SECONDS] default=3
-h, --help  display help
```

Big thanks to Tommy Butler and [this post](http://www.atrixnet.com/animated-gifs/),
as most of the shell logic in giffy is derived from or inspired by his script.
