#!/bin/bash -e

if [[ `whoami` != "root" ]]
then
    echo "This script must run with root"
    exit 1
fi

cp -f ../scripts/description-pak .
cp -f ../scripts/postinstall-pak .

version=$(grep "RESPEAKERD_VERSION" ../CMakeLists.txt | sed -e 's/SET(RESPEAKERD_VERSION\ \(.*\))/\1/')
version_librespeaker=$(grep "SET(RESPEAKER_SDK_VERSION" ../CMakeLists.txt | sed -e 's/SET(RESPEAKER_SDK_VERSION\ \(.*\))/\1/')

echo "version: $version"
echo "version_librespeaker: ${version_librespeaker}"

d=$(date +%y%m%d)

checkinstall \
    -D \
    -y \
    --backup=no \
    --nodoc \
    --showinstall=no \
    --pkglicense="private" \
    --pkggroup="Sound" \
    --maintainer="Seeed Technology Co., Ltd." \
    --pkgarch=$(dpkg --print-architecture) \
    --pkgversion="$version" \
    --pkgrelease="build$d" \
    --pkgname=respeakerd \
    --requires="python-mraa,python-upm,libmraa1,libupm1,mraa-tools,libdbus-1-3,pulseaudio,mpg123,mpv,gstreamer1.0-plugins-good,gstreamer1.0-plugins-bad,gstreamer1.0-plugins-ugly,gir1.2-gstreamer-1.0,python-gi,python-gst-1.0,python-pyaudio,librespeaker \(\>= ${version_librespeaker}\)" \
    --exclude=/home \
    make install



