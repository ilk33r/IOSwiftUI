#!/bin/bash

TEMPLATES_FOLDER="${HOME}/Library/Developer/Xcode/Templates"
FILE_TEMPLATES_FOLDER="${TEMPLATES_FOLDER}/File Templates"

TEMPLATE_0_NAME="IOScreen.xctemplate"
TEMPLATE_0_PATH="${FILE_TEMPLATES_FOLDER}/${TEMPLATE_0_NAME}"

TEMPLATE_1_NAME="IOSwiftUIView.xctemplate"
TEMPLATE_1_PATH="${FILE_TEMPLATES_FOLDER}/${TEMPLATE_1_NAME}"

if [ ! -d "${TEMPLATES_FOLDER}" ]; then
    echo "Creating templates dir."
    mkdir -p "${TEMPLATES_FOLDER}"
fi

if [ ! -d "${FILE_TEMPLATES_FOLDER}" ]; then
    echo "Creating file templates dir."
    mkdir -p "${FILE_TEMPLATES_FOLDER}"
fi

if [ -d "${TEMPLATE_0_PATH}" ]; then
    echo "Removing old template."
    rm -rf "${TEMPLATE_0_PATH}"
fi

echo "Installing template."
cp -r "./${TEMPLATE_0_NAME}" "${TEMPLATE_0_PATH}"

if [ -d "${TEMPLATE_1_PATH}" ]; then
    echo "Removing old template."
    rm -rf "${TEMPLATE_1_PATH}"
fi

echo "Installing template."
cp -r "./${TEMPLATE_1_NAME}" "${TEMPLATE_1_PATH}"

