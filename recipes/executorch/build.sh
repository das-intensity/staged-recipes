#!/bin/bash

# Install buck2
#wget https://github.com/facebook/buck2/archive/refs/tags/2023-07-18.zip
#unzip 2023-07-18.zip && cd 2023-07-18
#cargo install --path=app/buck2
#cd EXECUTORCH_ROOT
#buck2 build //examples/portable/executor_runner:executor_runner --show-output

##wget https://sh.rustup.rs
#curl --proto '=https' --tlsv1.2 -sSf --output rustup-init.sh https://sh.rustup.rs
#bash rustup-init.sh -y
#
##curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh 
#
#echo "BEFORE PATH=$PATH"
#export PATH="$HOME/.cargo/bin:$PATH"
#echo "AFTER PATH=$PATH"
#
#rustup install nightly-2024-11-22
#echo "CARGO INSTALLED"
#
#cargo +nightly-2024-11-22 install --git https://github.com/facebook/buck2.git buck2

#wget https://github.com/facebook/buck2/archive/refs/tags/2023-07-18.zip


git submodule sync
git submodule update --init



wget https://github.com/facebook/buck2/releases/download/2025-03-01/buck2-x86_64-unknown-linux-gnu.zst
ls
zstd --decompress buck2-x86_64-unknown-linux-gnu.zst
ls

echo ""
echo "======"
env
echo "======"
echo ""
echo "BUILD_PREFIX=$BUILD_PREFIX"
echo "PREFIX=$PREFIX"

echo "BEFORE PATH=$PATH"

mkdir -pv ~/bin
ls ~/bin
mv buck2-x86_64-unknown-linux-gnu ~/bin/buck2
chmod a+x ~/bin/buck2

buck2 --version

echo "BUCK2 INSTALLED"

# Currently we're getting failures from
# https://github.com/pytorch/executorch/blob/v0.5.0/extension/llm/custom_ops/CMakeLists.txt#L72
#
# -- executorch: Using source file list $SRC_DIR/executorch/pip-out/temp.linux-x86_64-cpython-312/cmake-out/extension/llm/custom_ops/../../../executorch_srcs.cmake
# -- Found ZLIB: $PREFIX/lib/libz.so (found version "1.3.1")
# -- Caffe2: Found protobuf with new-style protobuf targets.
# -- Caffe2: Protobuf version 29.3.0
# CMake Warning at $BUILD_PREFIX/share/cmake/Torch/TorchConfig.cmake:22 (message):
#   static library c10_LIBRARY-NOTFOUND not found.
# Call Stack (most recent call first):
#   $BUILD_PREFIX/share/cmake/Torch/TorchConfig.cmake:70 (append_torchlib_if_found)
#   extension/llm/custom_ops/CMakeLists.txt:72 (find_package)
# 
# CMake Warning at $BUILD_PREFIX/share/cmake/Torch/TorchConfig.cmake:22 (message):
#   static library kineto_LIBRARY-NOTFOUND not found.
# Call Stack (most recent call first):
#   $BUILD_PREFIX/share/cmake/Torch/TorchConfig.cmake:120 (append_torchlib_if_found)
#   extension/llm/custom_ops/CMakeLists.txt:72 (find_package)
# 
# CMake Error at $BUILD_PREFIX/share/cmake-3.31/Modules/FindPackageHandleStandardArgs.cmake:233 (message):
#   Could NOT find Torch (missing: TORCH_LIBRARY)
# Call Stack (most recent call first):
#   $BUILD_PREFIX/share/cmake-3.31/Modules/FindPackageHandleStandardArgs.cmake:603 (_FPHSA_FAILURE_MESSAGE)
#   $BUILD_PREFIX/share/cmake/Torch/TorchConfig.cmake:166 (find_package_handle_standard_args)
#   extension/llm/custom_ops/CMakeLists.txt:72 (find_package)
#
# so disabling the if-case above that line via env var below
export EXECUTORCH_BUILD_KERNELS_CUSTOM_AOT=OFF

python --version
#cd executorch && python -m pip install . -vv
#(cd executorch && python setup.py bdist_wheel && pip install dist/*.whl)
(cd executorch && ${PYTHON} setup.py bdist_wheel && ${PYTHON} -m pip install -vv --no-dep dist/*.whl)
#(cd executorch && python -m build --wheel . && pip install dist/*.whl)


#exit 5
#
## https://pytorch.org/executorch/stable/getting-started-setup.html#build-tooling-setup
##
## Clean and configure the CMake build system. Compiled programs will
## appear in the executorch/cmake-out directory we create here.
## ./install_requirements.sh --clean
#echo "one $(pwd)"
#ls
#cd executorch
#echo "about to cmake stuff: $(pwd)"
#ls
#(mkdir cmake-out && cd cmake-out && pwd && ls && cmake ..)
#
## Build the executor_runner target
#echo "about to cmake build $(pwd)"
#ls
#pwd
#cmake --build cmake-out -j9
#
#find . -name "flatc" || true
#find . -name "executor_runner" || true
#find . -name "activation_memory_profiler.py" || true
#
#exit 4
