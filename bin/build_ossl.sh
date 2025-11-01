#!/bin/bash

# Gets the `curl` command path
CURL_CMD=$(command -v curl)
if [ -z "$CURL_CMD" ]; then
    echo "Error: curl is not installed. Please install it and try again."
    exit 1
fi

# Default Github URLs
GITHUB_BASE_URL=https://codeload.github.com
GITHUB_ARCHIVE_TYPE=zip

# OpenSSL Base Github URL
OSSL_GITHUB_BASE_URL=${GITHUB_BASE_URL}/openssl

# OpenSSL Version To Build
OSSL_VERSION=openssl-3.6.0

# OpenSSL Download URL
OSSL_BASE_URL=${OSSL_GITHUB_BASE_URL}/openssl/${GITHUB_ARCHIVE_TYPE}/refs/tags
OSSL_FULL_URL=${OSSL_BASE_URL}/${OSSL_VERSION}

# Output File Name and Directory for building OpenSSL
OSSL_OUTPUT=${OSSL_VERSION}.${GITHUB_ARCHIVE_TYPE}
OSSL_DIR=${OSSL_VERSION}

# Download, Unzip, and Build OpenSSL
$CURL_CMD -s "${OSSL_FULL_URL}" --output "${OSSL_OUTPUT}" && \
    unzip -qq "${OSSL_OUTPUT}" && \
    echo "Building $OSSL_VERSION, please wait..." && \
    result=$(cd "openssl-${OSSL_DIR}" && \
        ./Configure --prefix=${PRJ_DEST_DIR} --openssldir=${PRJ_DEST_DIR}/ssl \
            '-Wl,--enable-new-dtags,-rpath,$(LIBRPATH)' 2>&1 && \
        make build_libs 2>&1 && \
        make install_sw 2>&1)

# Check if the build was successful
if [ $? -ne 0 ]; then
    echo "Error: OpenSSL build failed."
    echo "$result"
    rm -f "${OSSL_OUTPUT}"
    rm -rf "${OSSL_DIR}"
    exit 1
fi

# Cleanup
rm -f "${OSSL_OUTPUT}"
rm -rf "${OSSL_DIR}"

# All Done
echo "OpenSSL ${OSSL_VERSION} has been built and installed in ${PRJ_DEST_DIR}."
exit 0