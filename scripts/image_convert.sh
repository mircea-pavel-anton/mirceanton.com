#!/bin/bash

convert_images() {
  echo "Converting all images to `.webp`..."
  cwebp-batch --in content/ --out content/ -q 100 -z 9 -lossless --short
}

delete_originals() {
  echo "Removing `.png` files..."
  find content/ -type f -name '*.png' -exec rm {} \;
  echo "Done."

  echo "Removing `.jpg` files..."
  find content/ -type f -name '*.jpg' -exec rm {} \;
  echo "Done."

  echo "Removing `.jpeg` files..."
  find content/ -type f -name '*.jpeg' -exec rm {} \;
  echo "Done."
}

update_references() {
  echo "Updating image references in content files..."
  find content/ -type f -name '*.md' -exec sed -i 's/.png/.webp/g' {} \;
  find content/ -type f -name '*.md' -exec sed -i 's/.jpg/.webp/g' {} \;
  find content/ -type f -name '*.md' -exec sed -i 's/.jpeg/.webp/g' {} \;
  echo "Done."
}

convert_images && (delete_originals; update_references)
