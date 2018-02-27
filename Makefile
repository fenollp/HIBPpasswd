prefix = HIBP-$(shell date --utc --iso-8601)
links = links.txt
warc = $(prefix)-00000.warc.gz
# WARC info: https://github.com/webrecorder/webrecorderplayer-electron

all: $(warc)
$(links):
	python -c 'with open("$@","w") as fd: [fd.write("https://api.pwnedpasswords.com/range/{:05X}\n".format(i)) for i in range(0xFFFFF +1)]'
$(warc): $(links)
	wget --warc-file='$(prefix)' --warc-cdx --input-file='$<' --output-document=/dev/null
