build:
	nim -o:bin/main -d:release --opt:size --passL:-s c main.nim

build-debug:
	nim -o:bin/main -d:debug c main.nim && cp bin/main ~/.local/bin/yt-dl-pls-debug
