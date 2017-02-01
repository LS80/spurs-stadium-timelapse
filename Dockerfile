FROM python:3.6

RUN pip install requests pillow

RUN apt-get update && apt-get install -y build-essential yasm pkg-config fonts-liberation \
                                         libmp3lame-dev libvorbis-dev libopus-dev libopenjpeg-dev libx264-dev

RUN curl http://ffmpeg.org/releases/ffmpeg-3.2.2.tar.xz | tar xJf - \
    && cd ffmpeg-3.2.2 \
    && ./configure --enable-gpl --enable-postproc --enable-small --enable-swscale --enable-avfilter \
                   --enable-libmp3lame --enable-libvorbis --enable-libopus --enable-libx264 --enable-pthreads \
                   --enable-libopenjpeg --enable-nonfree --enable-libfreetype --disable-debug \
    && make -j4 \
    && make install \
    && ldconfig

COPY . /code

ENV PATH /code:$PATH

WORKDIR /data

ENTRYPOINT ["create"]

VOLUME /data
