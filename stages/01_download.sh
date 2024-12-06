#!/usr/bin/env bash

set -euo pipefail

# Script to download files

# Get local [ath]
localpath=$(pwd)
echo "Local path: $localpath"

# Create the download directory
downloadpath="$localpath/download"
echo "Download path: $downloadpath"
mkdir -p "$downloadpath"

REPO_OWNER='marvinm2'
REPO_NAME='AOPWikiRDF'

#REF='master' # Branch name: master

# Specific commit
REF='b3d120abb5f51ff927c34ebd29e940627ffdd46e'

# Define the tarball URL
tarball_url="https://github.com/${REPO_OWNER}/${REPO_NAME}/archive/${REF}.tar.gz"

# Retrieve and unpack the files
curl -L $tarball_url | tar -C $downloadpath -xvzf -

mv $downloadpath/${REPO_NAME}-${REF} $downloadpath/${REPO_NAME}

echo "Download done."
