## Spurs Stadium Timelapse Video Creator

Create a timelapse video from one of the 5 timelapse cameras at the new Tottenham Hotspur stadium building site.

The output video will be scaled down to 4K (3240x2160).
When using the crop option the output video will be full HD (1620x1080).

A timestamp will be added in the top left corner, using the time from the jpeg EXIF.

#### Dependencies (native)

1. [Python 3.6](https://www.python.org/downloads/release/python-360)
  - [Requests](http://docs.python-requests.org/en/master/user/install)
  - [Pillow](http://pillow.readthedocs.io/en/3.0.x/installation.html)
2. [ffmpeg](https://ffmpeg.org/download.html)
  - drawtext filter support is required to add timestamps to video

#### Docker

Build an image and run a container as an alternative to installing the dependencies, e.g.

```
docker build -t create .
docker run -v "$(pwd)":/data create --help
```

#### Usage
```
usage: create [-h] [-c {1,2,3,4,5}] [-d DAYS] [-r FRAMERATE] [-a AUDIO_FILE]
              [--audio-start AUDIO_START] [--crop PIXEL PIXEL]
              [--start-time HH:MM] [--end-time HH:MM] [--sleep SLEEP]
              [--debug]
              [output]

positional arguments:
  output                output video file name (default: None)

optional arguments:
  -h, --help            show this help message and exit
  -c {1,2,3,4,5}, --camera {1,2,3,4,5}
                        camera number (default: 2)
  -d DAYS, --days DAYS  number of previous days to include (default: 0)
  -r FRAMERATE, --framerate FRAMERATE
                        framerate for video in fps (e.g. 5, 1/5) (default: 2)
  -a AUDIO_FILE, --audio-file AUDIO_FILE
                        audio file to mux with video (default: None)
  --audio-start AUDIO_START
                        start time of audio in seconds (default: 0)
  --crop PIXEL PIXEL    pixel numbers defining the top left corner of the
                        image crop rectangle (left top) (default: None)
  --start-time HH:MM    start time of day for included images (default: 9:00)
  --end-time HH:MM      end time of day for included images (default: 19:30)
  --sleep SLEEP         number of seconds to sleep between image requests
                        (default: 5)
  --debug               enable debug logging (default: False)
```
