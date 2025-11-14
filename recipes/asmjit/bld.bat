@echo on

mkdir build
cd build

cmake %CMAKE_ARGS% ^
    -GNinja ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DASMJIT_STATIC=OFF ^
    -DASMJIT_TEST=OFF ^
    -DASMJIT_NO_CUSTOM_FLAGS=OFF ^
    ..
if errorlevel 1 exit 1

cmake --build . --config Release
if errorlevel 1 exit 1

cmake --install . --config Release
if errorlevel 1 exit 1
