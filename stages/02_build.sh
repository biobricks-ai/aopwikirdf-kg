#!/usr/bin/env bash

set -euo pipefail

# Get local path
localpath=$(pwd)
echo "Local path: $localpath"

# Get download path
export downloadpath="$localpath/download"
echo "Download path: $downloadpath"

# Create brick directory
export brickpath="$localpath/brick"
mkdir -p $brickpath
echo "Brick path: $brickpath"

export base_uri="https://aopwiki.rdf.bigcat-bioinformatics.org/"

rdf_to_hdt_files=(
  AOPWikiRDF.ttl
  AOPWikiRDF-Genes.ttl
)

rdf_copy_files=(
  AOPWikiRDF-Void.ttl
)

printf '%s\n' "${rdf_to_hdt_files[@]}" \
  | parallel '
      IN_TTL=$downloadpath/AOPWikiRDF/data/{};
      OUT_HDT=$brickpath/{.}.hdt;
      rdf2hdt -i -p -B "$base_uri"  $IN_TTL $OUT_HDT
    '

printf '%s\n' "${rdf_copy_files[@]}" \
  | parallel '
      IN_TTL=$downloadpath/AOPWikiRDF/data/{};
      cp -p $IN_TTL $brickpath/
    '
