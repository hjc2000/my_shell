root_path=$(pwd)

cd lib &&
rm -rf \
libx265.* \
libx264.* \
libswscale.* \
libswresample.so.* \
libavcodec.* \
libavdevice.* \
libavfilter.* \
libavformat.* \
libavutil.* \
libpostproc.* 


cd ${root_path} &&
cd bin &&
rm -rf \
ffmpeg \
ffprobe \
x264 \
x265
