#!/bin/bash

docker build . -t ardupilot
docker run -v $PWD:/src_ro:ro -v $PWD/build:/build:rw --user $(id -u):$(id -g) -it ardupilot bash -c 'cp -r /src_ro /ardupilot/src; rm -rf /ardupilot/src/build; cd /ardupilot/src; ./waf configure --board Tolyn2000 --bootloader; ./waf -j $(nproc) bootloader; cp build/Tolyn2000/bin/AP_Bootloader.bin Tools/bootloaders/Tolyn2000_bl.bin; ./waf configure --board Tolyn2000; ./waf -j $(nproc) plane; cp -r build/* /build/'
