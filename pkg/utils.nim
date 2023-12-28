import os
import std/json
import std/osproc
import std/strutils

proc checkBins*() =
    var err = false
    var status: int
    let commands = @["yt-dlp -h", "ffmpeg -h", "ffprobe -h", "cat --help"]

    for c in commands:
        status = execCmd(c & " > /dev/null 2>&1")
        if status != 0:
            echo "Error running: ", c, "executabel not found, please install it, or check your PATH."
            err = true

    if err:
        quit(1)
    else:
        echo "All executables found."

proc getFiles*(): seq[string] =
    echo "Checking files..."

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

proc getConfig*(configFile: string): tuple[found: bool, url: string] =
    echo "Loading config..."

    var (stdout, status) = execCmdEx("cat \"" & configFile & "\"")
    if status != 0:
        return (false, "")

    var purl = stdout.replace("purl=", "").replace("\n", "").strip()
    if purl.len > 0:
        return (true, purl)

    return (false, "")