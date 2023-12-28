import std/json
import std/osproc
import std/strutils
import std/sequtils

proc getUrlsFromPlaylist*(url: string): seq[string] =
    echo "Loading videos from the playlist..."
    let (stdout, status) = execCmdEx("yt-dlp --no-warnings --dump-single-json --flat-playlist \"" & url & "\"")
    if status != 0 or stdout.contains("ERROR:"):
        echo "Error loading videos from the playlist.\nPlease check or delete your config file\n---\n", $stdout
        quit(1)

    let urls = parseJson(stdout)["entries"].mapIt(it["url"].getStr())
    echo "> Found ", urls.len, " videos in the playlist."
    return urls

proc downloadMp3*(url: string) =
    echo "Downloading: ", url

    let (_, status) = execCmdEx("yt-dlp --add-metadata --extract-audio --audio-format mp3 --audio-quality 0 --embed-thumbnail \"" & url & "\"")
    if status != 0:
        echo "> Error downloading: ", url, " > skipping..."
    else:
        echo "> Download done."