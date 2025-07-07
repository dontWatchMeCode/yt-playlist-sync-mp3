
# YT-PLAYLIST-SYNC-MP3

<em>Your playlists.  Effortless MP3s.  Now.</em>

<img src="https://img.shields.io/github/license/dontWatchMeCode/yt-playlist-sync-mp3?style=default&logo=opensourceinitiative&logoColor=white&color=0080ff" alt="license">
<img src="https://img.shields.io/github/last-commit/dontWatchMeCode/yt-playlist-sync-mp3?style=default&logo=git&logoColor=white&color=0080ff" alt="last-commit">
<img src="https://img.shields.io/github/languages/top/dontWatchMeCode/yt-playlist-sync-mp3?style=default&color=0080ff" alt="repo-top-language">

## Overview

`yt-playlist-sync-mp3` is a command-line tool that automates the download and conversion of YouTube playlists into MP3 files, leveraging Docker for easy deployment and a streamlined workflow.

**Why yt-playlist-sync-mp3?**

This project simplifies the often tedious process of downloading and converting YouTube playlists to MP3s. The core features include:

- **🎧 Automated Download & Conversion:**  Effortlessly download and convert entire YouTube playlists to MP3 format.
- **🐳 Docker Containerization:**  Ensures consistent execution across different environments and simplifies deployment.
- **⚙️ Efficient Build System:**  A streamlined Makefile enables quick and easy building for various environments.
- **🚀 Automated Release Workflow:**  New releases are automatically built and pushed to the GitHub Container Registry, guaranteeing up-to-date functionality.
- **🛡️ Robust Error Handling:**  Gracefully handles potential errors during download and conversion processes.
- **🎼 Metadata Embedding:**  Preserves important metadata, such as track titles and artists, within the downloaded MP3 files.

## Project Index

<details open>
 <summary><b><code>YT-PLAYLIST-SYNC-MP3/</code></b></summary>
 <!-- __root__ Submodule -->
 <details>
  <summary><b>__root__</b></summary>
  <blockquote>
   <div class='directory-path' style='padding: 8px 0; color: #666;'>
    <code><b>⦿ __root__</b></code>
   <table style='width: 100%; border-collapse: collapse;'>
   <thead>
    <tr style='background-color: #f8f9fa;'>
     <th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
     <th style='text-align: left; padding: 8px;'>Summary</th>
    </tr>
   </thead>
    <tr style='border-bottom: 1px solid #eee;'>
     <td style='padding: 8px;'><b><a href='https://github.com/dontWatchMeCode/yt-playlist-sync-mp3/blob/master/main.nim'>main.nim</a></b></td>
     <td style='padding: 8px;'>- Main.nim<code> orchestrates a YouTube playlist to MP3 downloader<br>- It retrieves a playlist URL, either from user input or a configuration file, and uses </code>ytdlp<code> to extract individual video URLs<br>- Leveraging </code>utils` for file system operations and configuration management, it downloads missing MP3 files, ensuring only new videos are processed<br>- The program concludes upon completion.</td>
    </tr>
    <tr style='border-bottom: 1px solid #eee;'>
     <td style='padding: 8px;'><b><a href='https://github.com/dontWatchMeCode/yt-playlist-sync-mp3/blob/master/Makefile'>Makefile</a></b></td>
     <td style='padding: 8px;'>- The Makefile defines build targets for a Nim project, creating optimized and debug versions of the <code>main.nim</code> executable<br>- It facilitates both local execution and Docker containerization for the <code>yt-pl-sync</code> application, likely a YouTube playlist synchronization tool<br>- The Makefile streamlines the build process, offering options for different deployment environments.</td>
    </tr>
    <tr style='border-bottom: 1px solid #eee;'>
     <td style='padding: 8px;'><b><a href='https://github.com/dontWatchMeCode/yt-playlist-sync-mp3/blob/master/LICENSE'>LICENSE</a></b></td>
     <td style='padding: 8px;'>- The LICENSE file specifies the projects open-source licensing terms under the MIT License<br>- It grants users broad permissions to use, modify, and distribute the software, disclaiming any warranties and limiting liability<br>- This ensures legal clarity and facilitates community contribution and usage of the project.</td>
    </tr>
    <tr style='border-bottom: 1px solid #eee;'>
     <td style='padding: 8px;'><b><a href='https://github.com/dontWatchMeCode/yt-playlist-sync-mp3/blob/master/Dockerfile'>Dockerfile</a></b></td>
     <td style='padding: 8px;'>- The Dockerfile constructs a container image for a YouTube playlist synchronization application<br>- It uses a multi-stage build process, first compiling the application and then creating a runtime image<br>- The resulting image includes necessary dependencies like FFmpeg, Python, and yt-dlp, enabling the application to download and convert YouTube playlists to MP3 format<br>- The image is optimized for size using Alpine Linux.</td>
    </tr>
   </table>
  </blockquote>
 </details>
 <!-- scritps Submodule -->
 <details>
  <summary><b>scritps</b></summary>
  <blockquote>
   <div class='directory-path' style='padding: 8px 0; color: #666;'>
    <code><b>⦿ scritps</b></code>
   <table style='width: 100%; border-collapse: collapse;'>
   <thead>
    <tr style='background-color: #f8f9fa;'>
     <th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
     <th style='text-align: left; padding: 8px;'>Summary</th>
    </tr>
   </thead>
    <tr style='border-bottom: 1px solid #eee;'>
     <td style='padding: 8px;'><b><a href='https://github.com/dontWatchMeCode/yt-playlist-sync-mp3/blob/master/scritps/yt-pl-sync'>yt-pl-sync</a></b></td>
     <td style='padding: 8px;'>- Yt-pl-sync` facilitates downloading YouTube playlists as MP3s<br>- It uses a Docker container for the core functionality, offering options to update the Docker image, search for configuration files across directories, and execute the download process within each found directory<br>- The script also cleans up non-MP3 files before running the download.</td>
    </tr>
   </table>
  </blockquote>
 </details>
 <!-- pkg Submodule -->
 <details>
  <summary><b>pkg</b></summary>
  <blockquote>
   <div class='directory-path' style='padding: 8px 0; color: #666;'>
    <code><b>⦿ pkg</b></code>
   <table style='width: 100%; border-collapse: collapse;'>
   <thead>
    <tr style='background-color: #f8f9fa;'>
     <th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
     <th style='text-align: left; padding: 8px;'>Summary</th>
    </tr>
   </thead>
    <tr style='border-bottom: 1px solid #eee;'>
     <td style='padding: 8px;'><b><a href='https://github.com/dontWatchMeCode/yt-playlist-sync-mp3/blob/master/pkg/ytdlp.nim'>ytdlp.nim</a></b></td>
     <td style='padding: 8px;'>- Pkg/ytdlp.nim<code> facilitates YouTube playlist processing and MP3 downloading within a larger application<br>- It retrieves video URLs from a given playlist using </code>yt-dlp`, handling potential errors<br>- Subsequently, it downloads each video as an MP3 file, embedding metadata and thumbnails, providing feedback on download progress and any encountered issues<br>- The module leverages external commands for functionality.</td>
    </tr>
    <tr style='border-bottom: 1px solid #eee;'>
     <td style='padding: 8px;'><b><a href='https://github.com/dontWatchMeCode/yt-playlist-sync-mp3/blob/master/pkg/utils.nim'>utils.nim</a></b></td>
     <td style='padding: 8px;'>- Pkg/utils.nim<code> provides utility functions for the project<br>- It verifies the presence of essential command-line tools (yt-dlp, ffmpeg, ffprobe)<br>- It also retrieves metadata (specifically, the </code>purl`) from MP3 files using ffprobe, handling potential errors gracefully<br>- Finally, it manages configuration, reading and writing a designated URL to a configuration file.</td>
    </tr>
   </table>
  </blockquote>
 </details>
 <!-- .github Submodule -->
 <details>
  <summary><b>.github</b></summary>
  <blockquote>
   <div class='directory-path' style='padding: 8px 0; color: #666;'>
    <code><b>⦿ .github</b></code>
   <!-- workflows Submodule -->
   <details>
    <summary><b>workflows</b></summary>
    <blockquote>
     <div class='directory-path' style='padding: 8px 0; color: #666;'>
      <code><b>⦿ .github.workflows</b></code>
     <table style='width: 100%; border-collapse: collapse;'>
     <thead>
      <tr style='background-color: #f8f9fa;'>
       <th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
       <th style='text-align: left; padding: 8px;'>Summary</th>
      </tr>
     </thead>
      <tr style='border-bottom: 1px solid #eee;'>
       <td style='padding: 8px;'><b><a href='https://github.com/dontWatchMeCode/yt-playlist-sync-mp3/blob/master/.github/workflows/release.yml'>release.yml</a></b></td>
       <td style='padding: 8px;'>- The release.yml workflow automates Docker image publishing<br>- Triggered by pushes to the <code>release</code> branch, it builds a Docker image for the yt-playlist-sync-mp3 project and pushes it to the GitHub Container Registry (ghcr.io)<br>- This ensures a readily available, updated container image upon new releases, streamlining deployment.</td>
      </tr>
     </table>
    </blockquote>
   </details>
  </blockquote>
 </details>
</details>

---

## License

Yt-playlist-sync-mp3 is protected under the [LICENSE](https://choosealicense.com/licenses) License. For more details, refer to the [LICENSE](https://choosealicense.com/licenses/) file.
