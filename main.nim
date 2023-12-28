import os, std/[json, osproc, strutils, sequtils]

const
    CONFIG_FILE_NAME = ".yt-playlist-sync-mp3.config"

proc getYtUrlFromPlaylist(playlistUrl: string): seq[string] =
    let (stdout, status) = execCmdEx("yt-dlp --no-warnings --dump-single-json --flat-playlist \"" & playlistUrl & "\"")
    if status != 0 or stdout.contains("ERROR:"):
        echo "Error loading videos from the playlist.\nPlease check or delete your config file: ", $CONFIG_FILE_NAME, "\n---\n", $stdout
        quit(1)

    return parseJson(stdout)["entries"].mapIt(it["url"].getStr())

proc downloadYtAdMp3(url: string) =
    let status = execCmd("yt-dlp --add-metadata --extract-audio --audio-format mp3 --embed-thumbnail \"" & url & "\"")
    if status != 0:
        echo "Error downloading: ", url
        quit(1)

proc getMp3FilesFromCurrentDir(): seq[string] =
    var files: seq[string]

    for f in walkFiles("./*.mp3"):
        let (stdout, status) = execCmdEx("ffprobe -v quiet -print_format json -show_format -show_streams \"" & f & "\"")
        if status != 0:
            echo "Error running ffprobe on: ", f, "\n---\n", $stdout
            quit(1)

        if stdout.len > 0:
            files.add((parseJson(stdout)["format"]["tags"]["purl"].getStr()))
        else:
            echo f, ": missing purl, skipping"

    return files

proc getConfig(): tuple[found: bool, url: string] =
    var (stdout, status) = execCmdEx("cat \"" & CONFIG_FILE_NAME & "\"")
    if status != 0:
        return (false, "")

    var purl = stdout.replace("purl=", "").replace("\n", "").strip()
    if purl.len > 0:
        return (true, purl)

    return (false, "")

proc main() =
    let filesInCurrentPath = getMp3FilesFromCurrentDir()

    var videoUrls: seq[string]
    let config = getConfig()

    if not config.found:
        echo "No valid config file found.\nPlease enter a playlist URL to create one in the current directory:"
        let input = readLine(stdin).strip()
        videoUrls = getYtUrlFromPlaylist(input)
        echo "Found ", videoUrls.len, " videos in the playlist.\nWriting config file."
        writeFile(CONFIG_FILE_NAME, "purl=" & input)
    else:
        videoUrls = getYtUrlFromPlaylist(config.url)
        echo "Found ", videoUrls.len, " videos in the playlist."

    for url in videoUrls:
        if not filesInCurrentPath.contains(url):
            echo "Downloading: ", url
            downloadYtAdMp3(url)
        else:
            echo "Skipping: ", url

main()
