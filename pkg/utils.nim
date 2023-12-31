import os
import std/json
import std/osproc
import std/strutils

proc checkBins*() =
    var err = false
    var status: int
    let commands = @["yt-dlp -h", "ffmpeg -h", "ffprobe -h"]

    for c in commands:
        status = execCmd(c & " > /dev/null 2>&1")
        if status != 0:
            echo "Error running: ", c, "executabel not found, please install it, or check your PATH."
            err = true

    if err:
        quit(1)

proc getFiles*(): seq[string] =
    echo "Checking files..."

    var files: seq[string]

    for f in walkFiles("./*.mp3"):
        let (stdout, status) = execCmdEx("ffprobe -v quiet -print_format json -show_format -show_streams \"" & f & "\"")
        if status != 0:
            echo "Error running ffprobe on: ", f, "\n---\n", $stdout
            quit(1)

        if stdout.len > 0:
            try:
                let purl = parseJson(stdout)["format"]["tags"]["purl"].getStr()
                files.add(purl)
            except:
                echo f, ": missing purl, skipping"
                continue
        else:
            echo f, ": missing ffprobe data, skipping"

    return files

proc getConfig*(configFile: string): tuple[found: bool, url: string] =
    echo "Loading config..."

    if fileExists(configFile):
        for line in readFile(configFile).split("\n"):
            if line.startsWith("purl="):
                return (true, line.replace("purl=", "").strip())

    echo "No valid config file found."
    return (false, "")

proc setConfig*(configFile: string, url: string) =
    echo "Saving config..."
    writeFile(configFile, "purl=" & url)
