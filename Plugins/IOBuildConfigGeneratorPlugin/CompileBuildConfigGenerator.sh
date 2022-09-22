#!/bin/sh

set -e
set -u
set -o pipefail

echo "CompileBuildConfigGenerator"
echo "${0}"
echo "${1}"
echo "${2}"
echo "${3}"
echo "${4}"

BCG_APP_NAME="IOBuildConfig"
BCG_SOURCE_ROOT="${4}/Plugins/IOBuildConfigGenerator"
BCG_DESTINATION_BUILD_DIR="${2}/IOBuildConfigGenerator"

BCG_MAC_OSX_MIN_VERSION="10.11"
BCG_XCODE_DIRECTORY=$(xcode-select -p)
BCG_OSX_SDK_DIR=${BCG_XCODE_DIRECTORY}/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk

BCG_CLANG=$(which clang)
BCG_CLANG_FLAGS="-DRELEASE=1 -std=gnu17 -stdlib=libc++ -fobjc-arc -isysroot ${BCG_OSX_SDK_DIR} -mmacosx-version-min=${BCG_MAC_OSX_MIN_VERSION} -I${BCG_SOURCE_ROOT}"
BCG_COMPILER_FLAGS="-x objective-c ${BCG_CLANG_FLAGS}"
BCG_LINKER_FLAGS="${BCG_CLANG_FLAGS} -Xlinker -add_ast_path -Xlinker -no_deduplicate -framework Foundation"

# Check destination root dir is not exists
if [ ! -d "${BCG_DESTINATION_BUILD_DIR}" ]; then
    # Then create directory
    mkdir -p ${BCG_DESTINATION_BUILD_DIR}
fi

# Check build config binary is not exists
if [ ! -f "${BCG_DESTINATION_BUILD_DIR}/${BCG_APP_NAME}" ]; then
    # Compile Build config generator
    $BCG_CLANG -x c ${BCG_COMPILER_FLAGS} -c "${BCG_SOURCE_ROOT}/IOBuildConfigGenerator.m" -o "${BCG_DESTINATION_BUILD_DIR}/IOBuildConfigGenerator.o"
    $BCG_CLANG -x c ${BCG_COMPILER_FLAGS} -c "${BCG_SOURCE_ROOT}/${BCG_APP_NAME}.m" -o "${BCG_DESTINATION_BUILD_DIR}/${BCG_APP_NAME}.o"

    # Link Build Config Generator
    $BCG_CLANG ${BCG_LINKER_FLAGS} "${BCG_DESTINATION_BUILD_DIR}/IOBuildConfigGenerator.o" "${BCG_DESTINATION_BUILD_DIR}/${BCG_APP_NAME}.o" -o "${BCG_DESTINATION_BUILD_DIR}/${BCG_APP_NAME}"
fi
