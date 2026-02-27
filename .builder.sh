#!/usr/bin/env bash

set -euo pipefail

build_js() {

  input="$1"
  output="$2"

  if [ -f "$input" ]; then

    echo -e "\n'$input' -> '$output'\n"

    npx swc "$input" -o "${output/%.js/.optimized.js}"

    npx rollup -p node-resolve -p commonjs -i "${output/%.js/.optimized.js}" -o "${output/%.js/.bundled.js}" -f iife --failAfterWarnings

    if [[ "${MODE:-production}" == development ]]; then

      cp tgt/polyfill.bundled.js tgt/polyfill.js
    else

      npx terser "${output/%.js/.bundled.js}" -o "${output/%.js/.compressed.js}" -c -m

      cp tgt/polyfill.compressed.js tgt/polyfill.js
    fi
  fi
}
