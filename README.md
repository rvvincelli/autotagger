# Autotagger

## What is this?

[Some time ago](https://github.com/beetbox/beets/pull/2936) I tried hard to have the `beet`s `discogs` plugin get me accomplish the following: automatically infer the genre and style of a track and archive it into some path representing that.

Logically that could have been a plugin, actually a new one because this can apply to Discogs as well as MusicBrainz, but I just wanted to get stuff done not really investing time in writing a test-passing plugin (sorry Beets committers).

This started as a bunch of scripts badly combined, eventually everything landed in a `Dockerfile` because it is just easier to maintain as the whole world knows, it actually makes testing and debugging easier too.

## Before you run

Before you start download Beets itself and try out the Discogs plugin: this will create the needed `discogs_token.json` (and a pickle which I reference as well even if it does not matter). Well this is basically getting the API token after registering the app (you need a Dogs account for this but it is free).

# Build and Run

Build with:
`docker build -t autotagger .`
make sure you read and understand the `echo`s!

Run with:
`docker run -v `pwd`/source:/source -v /Some/dir/full/of/other/mp3s:/dest autotagger`
This is what happens:
- `/source` will contain the target mp3's to identify and archive
- `/dest` contains your full mp3 collection where the archiving will go

If for example you have:
`source/The\ Prodigy\ -\ Light\ Up\ the\ Sky.mp3`
after running the above you will have:
- `source/Electronic/Breakbeat/The\ Prodigy\ -\ Light\ Up\ the\ Sky.mp3`
- `dest/Electronic/Breakbeat/The\ Prodigy\ -\ Light\ Up\ the\ Sky.mp3` (archive)
- `dest/The\ Prodigy\ -\ Light\ Up\ the\ Sky.mp3` (symlink to archived mp3)

Please notice that if no information is found on Discogs the track will stay uncategorized and end up in the destination dir as an actual file.

# Why all of this

A few reasons:

- Discogs's  genuine community effort can give a MixMag-like name to any kind of electronic gibberish I have

- Docker is not friendly at all for packaging and distribution and I might consider to publish an image if anybody - at least 1body - asks me

- No more: I would really like to spin some acid and I know I have a lot, just not handy to find everything in my virtual dj doujour program
