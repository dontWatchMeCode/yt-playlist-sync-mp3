import std/strutils

import ./pkg/ytdlp
import ./pkg/utils

const CONFIG_FILE_NAME = ".yt-playlist-sync-mp3.config"

let filesInCurrentPath = utils.getFiles()
let config = utils.getConfig(CONFIG_FILE_NAME)

var videoUrls: seq[string]

utils.checkBins()

if not config.found:
    echo "No valid config file found.\nPlease enter a playlist URL to create one in the current directory:"
    let input = readLine(stdin).strip()
    videoUrls = ytdlp.getUrlsFromPlaylist(input)
    echo "Found ", videoUrls.len, " videos in the playlist.\nWriting config file."
    writeFile(CONFIG_FILE_NAME, "purl=" & input)
else:
    videoUrls = ytdlp.getUrlsFromPlaylist(config.url)
    echo "Found ", videoUrls.len, " videos in the playlist."

for url in videoUrls:
    if not filesInCurrentPath.contains(url):
        echo "Downloading: ", url
        ytdlp.downloadMp3(url)

echo "---\nDone. Bye!"