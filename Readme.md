# yt-playlist-sync-mp3

Keep a local directory synchronized with a YouTube playlist by downloading new
playlist entries as MP3 files.

The project uses [yt-dlp](https://github.com/yt-dlp/yt-dlp) for playlist and
audio downloads, and FFmpeg for conversion and metadata inspection. It can run
from the published Docker image or as a native Nim executable.

## Features

- Downloads every entry in a YouTube playlist as an MP3.
- Uses yt-dlp's best MP3 quality setting (`--audio-quality 0`).
- Embeds available metadata and thumbnails.
- Remembers one playlist per directory in `.yt-playlist-sync-mp3.config`.
- Detects previously downloaded entries from each MP3's `purl` metadata and
  downloads only missing entries on later runs.
- Provides a Docker wrapper that can update the image or synchronize multiple
  configured directories.
- Runs downloads as the current user so Docker-created files retain the correct
  ownership.

## Docker Quick Start

### Requirements

- Docker
- Bash and standard Linux command-line tools

Install the wrapper script from a cloned copy of this repository:

```sh
mkdir -p ~/.local/bin
install -m 755 scritps/yt-pl-sync ~/.local/bin/yt-pl-sync
```

Ensure `~/.local/bin` is in your `PATH`, then create or open a directory that
will contain only the playlist's MP3 files:

```sh
mkdir -p ~/Music/my-playlist
cd ~/Music/my-playlist
yt-pl-sync
```

On the first run, enter the playlist URL when prompted. The tool saves it in
`.yt-playlist-sync-mp3.config`, downloads the playlist, and reuses that URL on
future runs.

> [!WARNING]
> Before starting Docker, the wrapper lists all non-MP3 files below the current
> directory, except its configuration file, and offers to delete them. Answer
> `n` unless the directory is dedicated to this tool and those files are safe
> to remove.

### Wrapper Commands

```text
yt-pl-sync             Synchronize the current directory
yt-pl-sync --update    Pull the latest published Docker image
yt-pl-sync --find      Find configs below the current directory and sync each
yt-pl-sync --help      Show command help
```

`--find` searches recursively for `.yt-playlist-sync-mp3.config` files. Run it
from a directory containing multiple playlist directories to update them in
one pass.

## Run Docker Directly

The wrapper is optional. To run the published image directly in the current
directory:

```sh
docker run \
  --user "$(id -u):$(id -g)" \
  --init -it --rm \
  -v "$PWD:/mnt/vdata" \
  ghcr.io/dontwatchmecode/yt-playlist-sync-mp3:latest \
  yt-dl-pl-sync
```

This direct command does not perform the wrapper's non-MP3 cleanup check.

To build and run the image locally:

```sh
docker build -t yt-playlist-sync-mp3 .
docker run \
  --user "$(id -u):$(id -g)" \
  --init -it --rm \
  -v "$PWD:/mnt/vdata" \
  yt-playlist-sync-mp3 \
  yt-dl-pl-sync
```

## Native Build

### Requirements

- Nim 2.x
- GNU Make
- yt-dlp
- FFmpeg and ffprobe

Build the optimized executable:

```sh
mkdir -p bin
make build
```

Install it for the current user:

```sh
mkdir -p ~/.local/bin
install -m 755 bin/main ~/.local/bin/yt-dl-pl-sync
```

Run it from the playlist's destination directory:

```sh
mkdir -p ~/Music/my-playlist
cd ~/Music/my-playlist
yt-dl-pl-sync
```

The native executable checks that `yt-dlp`, `ffmpeg`, and `ffprobe` are
available in `PATH` before downloading anything.

## Configuration

Each synchronized directory contains this file:

```text
.yt-playlist-sync-mp3.config
```

Its contents are a single playlist URL:

```text
purl=https://www.youtube.com/playlist?list=...
```

To use a different playlist, delete the configuration file and run the tool
again, or replace the URL after `purl=`.

## Synchronization Behavior

1. The tool reads the configured playlist, or prompts for one on first use.
2. It scans `*.mp3` files in the current directory with ffprobe.
3. It compares their embedded `purl` tags with the playlist entries.
4. It downloads entries that are not already represented by an MP3.

Synchronization is additive: files are downloaded when missing, but MP3 files
are not removed when an entry disappears from the playlist. MP3 files without
a readable `purl` tag are skipped during comparison and may therefore be
downloaded again.

## Troubleshooting

- **Missing executable:** install the named dependency and verify it is in
  `PATH`.
- **Playlist cannot be loaded:** verify the URL and access permissions. Delete
  or edit `.yt-playlist-sync-mp3.config` if it contains the wrong URL.
- **An entry downloads again:** inspect whether the existing MP3 has a `purl`
  metadata tag; files created outside this tool may not have one.
- **One video fails:** the tool reports the error, skips that entry, and
  continues. Run it again to retry.

Only download media you have permission to access and store. Use of YouTube and
yt-dlp remains subject to their applicable terms and local law.

## License

Licensed under the [MIT License](LICENSE).
