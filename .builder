#!/usr/bin/env bash

set -euo pipefail

build_js() {

  input="$1"
  output="$2"

  if [ -f "$input" ]; then

    npx swc "$input" -o "${output/%.js/.optimized.js}" -q

    if [[ "${MODE:-development}" == production ]]; then

      npx rolldown "${output/%.js/.optimized.js}" -o "$output" -f iife -m
    else

      npx rolldown "${output/%.js/.optimized.js}" -o "$output" -f iife
    fi

    rm "${output/%.js/.optimized.js}"
  fi
}
