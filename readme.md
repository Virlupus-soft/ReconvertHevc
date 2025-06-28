# Video Audio Normalizer & HEVC Converter

A simple Bash script to:

- Normalize audio loudness of video files using `ffmpeg loudnorm`
- Convert videos to HEVC (h.265) with `.mp4` output
- Save normalized audio intermediate files and final encoded files into separate folders for clarity

---

## 💻 Requirements

- Linux / Bash
- `ffmpeg`
- (Optional) `parallel` for multi-threaded processing

---

## 🔧 Usage

```bash
chmod +x recon.sh
./recon.sh
```

**Output:**

- `normalized/` – normalized audio intermediate files
- `encoded/` – final HEVC encoded videos

## 📂 Folder Structure

```
project/
 ├── recon.sh
 ├── normalized/
 └── encoded/
```

## 📌 TODO

- Add GNU Parallel support for multi-threaded batch processing
- Implement real-time progress tracking via `ffmpeg -progress`
- Add automated cleanup of intermediates after integrity verification

Next using:

`find . -type f \( -iname "*.mp4" -o -iname "*.avi" -o -iname "*.mkv" -o -iname "*.webm" \) | \`
`parallel --bar --joblog parallel.log --results parallel_out -j 2 ./recon-file.sh {}`

### 🔗 **Contributing**

Pull requests and suggestions are welcome. Please open an issue first to discuss what you would like to change.

