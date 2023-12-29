build:
	nim -o:bin/main -d:release --opt:size --passL:-s c main.nim

build-debug:
	nim -o:bin/main -d:debug c main.nim && cp bin/main ~/.local/bin/yt-dl-pls-debug

docker-build:
	docker build . -t debug/yt-playlist-sync-mp3

# 	## run example ##
#
#	docker run \
#		--user $(id -u):$(id -g) \
# 		--init \
# 		-it \
# 		--rm \
# 		-v .:/mnt/vdata \
# 		docker.io/debug/yt-playlist-sync-mp3 \
# 		sh -c 'trap "exit 0" SIGINT && yt-dl-pl-sync'