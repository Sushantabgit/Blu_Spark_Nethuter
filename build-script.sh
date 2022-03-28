#!/bin/bash
date
echo "Cleaning Directories"
echo

make clean && make mrproper  && rm -rf ../out

echo "Done..."

echo
echo "Deploying Build Commands"
echo

mkdir ../out
export ARCH=arm64
export SUBARCH=arm64
export CLANG_PATH=/media/androwbolt/Extras/kernel/toolchain/clang-r450784/bin
export PATH=${CLANG_PATH}:${PATH}
export CLANG_TRIPLE=aarch64-linux-gnu-
export CROSS_COMPILE=/media/androwbolt/Extras/kernel/toolchain/aarch64-linux-android-4.9/bin/aarch64-linux-android-
export CROSS_COMPILE_ARM32=/media/androwbolt/Extras/kernel/toolchain/aarch64-linux-android-4.9/bin/arm-linux-androideabi-
export LD=/media/androwbolt/Extras/kernel/toolchain/clang-r450784/bin/ld.lld
export AR=llvm-ar NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf OBJSIZE=llvm-size STRIP=llvm-strip HOSTCC=clang HOSTCXX=clang++
echo "Done..."
echo
echo

echo
echo "Compiling Kernel"
echo

make ARCH=arm64 CC=clang O=../out nethunter_defconfig
#make ARCH=arm64 CC=clang O=../out menuconfig
time make ARCH=arm64 CC=clang AR=llvm-ar NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf OBJSIZE=llvm-size STRIP=llvm-strip HOSTCC=clang HOSTCXX=clang++ O=../out -j2 
echo
echo "Creating DTB image"
echo
find /home/androwbolt/Desktop/out/arch/arm64/boot/dts/vendor/qcom -name '*.dtb' -exec cat {} + > /home/androwbolt/Desktop/out/arch/arm64/boot/dtb
echo "Done..."
echo
