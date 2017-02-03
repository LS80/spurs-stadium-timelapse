FROM python:3.6-alpine
MAINTAINER Lee Smith <lee@lee-smith.me.uk>

WORKDIR /tmp

RUN apk add --update build-base yasm curl tar xz \
                     lame-dev libvorbis-dev openjpeg-dev x264-dev freetype-dev opus-dev \
                     ttf-liberation && \

  FFMPEG_VERSION=3.2.2 && \
  DIR=$(mktemp -d) && cd ${DIR} && \
  curl -s http://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION:?}.tar.xz | tar xJf - && \
  cd ffmpeg-${FFMPEG_VERSION:?} && \
  ./configure --enable-gpl --enable-postproc --enable-small --enable-swscale --enable-avfilter \
              --enable-libmp3lame --enable-libvorbis --enable-libopus --enable-libx264 --enable-pthreads \
              --enable-libopenjpeg --enable-nonfree --enable-libfreetype --disable-debug && \
  make -j4 && \
  make install && \
  rm -rf ${DIR} && \
  apk del build-base yasm curl tar xz && rm -rf /var/cache/apk/*

RUN apk add --update build-base zlib-dev libjpeg-turbo-dev && \
  pip install requests pillow && \
  apk del build-base && rm -rf /var/cache/apk/*

COPY . /code

ENV PATH /code:$PATH

WORKDIR /data

ENTRYPOINT ["create"]

VOLUME /data
