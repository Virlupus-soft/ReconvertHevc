#!/bin/bash

# List of extensions to process
exts="mp4 avi mkv webm divx mov mpg mpeg"

# Create output directories if they don't exist
mkdir -p normalized encoded

for ext in $exts; do
  for file in *."$ext"; do
    # If no file matches the pattern, skip
    [ -e "$file" ] || continue

    name="${file%.*}"
    input="$file"
    audio="normalized/$name.a.mp4"
    output="encoded/$name.mp4"

    echo "=== Processing file: $input"
    echo "Intermediate audio file: $audio"
    echo "Final output file: $output"

    echo "=== Normalizing audio..."
    ffmpeg -hide_banner -loglevel error -stats -fflags +genpts -avoid_negative_ts make_zero \
      -i "$input" -c:v copy -af loudnorm -c:a aac -b:a 128k -movflags +faststart "$audio"

    if [ $? -ne 0 ]; then
      echo "Error during audio normalization: $input"
      exit 1
    fi

    echo "=== Converting to HEVC..."
    ffmpeg -hide_banner -loglevel error -stats -fflags +genpts \
      -i "$audio" -c:v libx265 -preset slow -crf 28 -c:a copy -movflags +faststart "$output"

    if [ $? -ne 0 ]; then
      echo "Error during HEVC conversion: $input"
      exit 1
    fi

    echo "✅ Done: $output"
  done
done
