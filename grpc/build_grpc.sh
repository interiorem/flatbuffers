#!/bin/bash

grpc_1_15_1_githash=090c147a40932a8fb8c37028c12331ef839fb7df

function build_grpc () {
  git clone https://github.com/interiorem/grpc.git google/grpc
  cd google/grpc
  git checkout ${grpc_1_15_1_githash} 
  git submodule update --init
  make
  make install prefix=`pwd`/install
  if [ ! -f ${GRPC_INSTALL_PATH}/lib/libgrpc++_unsecure.so.1 ]; then
    ln -s ${GRPC_INSTALL_PATH}/lib/libgrpc++_unsecure.so.6 ${GRPC_INSTALL_PATH}/lib/libgrpc++_unsecure.so.1
  fi
  cd ../..
}

GRPC_INSTALL_PATH=`pwd`/google/grpc/install
PROTOBUF_DOWNLOAD_PATH=`pwd`/google/grpc/third_party/protobuf

build_grpc
