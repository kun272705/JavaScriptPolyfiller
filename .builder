
build_js() {

  input="$1"
  output="$2"

  if [ -f "$input" ]; then

    echo -e "\n$input -> $output\n"

    npx swc "$input" -o "${output/%.js/.optimized.js}"

    npx rollup -p node-resolve -p commonjs -i "${output/%.js/.optimized.js}" -o "${output/%.js/.bundled.js}" --failAfterWarnings

    npx terser "${output/%.js/.bundled.js}" -o "${output/%.js/.compressed.js}" -c -m

    cp target/polyfill.compressed.js target/polyfill.js
  fi
}
