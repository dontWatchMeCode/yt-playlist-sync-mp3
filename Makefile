build:
	nim -o:bin/main -d:release --opt:size --passL:-s c main.nim

build-debug:
	nim -o:bin/main -d:debug c main.nim && cp bin/main ~/.local/bin/yt-pl-sync-debug

build-debug-rm:
	rm ~/.local/bin/yt-pl-sync-debug

# 	## build image ##
# 	docker build . -t debug/yt-playlist-sync-mp3
#
# 	## run image ##
#
#	docker run \
#		--user $(id -u):$(id -g) \
# 		--init \
# 		-it \
# 		--rm \
# 		-v .:/mnt/vdata \
# 		docker.io/debug/yt-playlist-sync-mp3 \
# 		sh -c 'trap "exit 0" SIGINT && yt-dl-pl-sync'