#!/bin/bash

convert_images() {
  cwebp-batch --in content/ --out content/ -q 100 -z 9 -lossless --short
}

delete_originals() {
  find content/ -type f -name '*.png' -exec rm {} \;
  find content/ -type f -name '*.jpg' -exec rm {} \;
  find content/ -type f -name '*.jpeg' -exec rm {} \;
}

update_references() {
  find content/ -type f -name '*.md' -exec sed -i 's/.png/.webp/g' {} \;
  find content/ -type f -name '*.md' -exec sed -i 's/.jpg/.webp/g' {} \;
  find content/ -type f -name '*.md' -exec sed -i 's/.jpeg/.webp/g' {} \;
}

convert_images && (delete_originals; update_references)
