#!/bin/bash

set -ex

mkdir build
cd build

cmake ${CMAKE_ARGS} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DASMJIT_STATIC=OFF \
    -DASMJIT_TEST=OFF \
    -DASMJIT_NO_CUSTOM_FLAGS=OFF \
    ..

cmake --build . --config Release
cmake --install . --config Release
