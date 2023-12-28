import std/strutils

import ./pkg/ytdlp
import ./pkg/utils

const CONFIG_FILE_NAME = ".yt-playlist-sync-mp3.config"

let config = utils.getConfig(CONFIG_FILE_NAME)
let filesInCurrentPath = utils.getFiles()

var videoUrls: seq[string]

utils.checkBins()

if not config.found:
    echo "Please enter a playlist URL to create one in the current directory:"
    let input = readLine(stdin).strip()

    videoUrls = ytdlp.getUrlsFromPlaylist(input)

    utils.setConfig(CONFIG_FILE_NAME, input)
else:
    videoUrls = ytdlp.getUrlsFromPlaylist(config.url)

for url in videoUrls:
    if not filesInCurrentPath.contains(url):
        ytdlp.downloadMp3(url)

echo "---\nDone. Bye!"