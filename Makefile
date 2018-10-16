crystal ?= $(shell which crystal)
shards ?= $(shell which shards)
bin_dir = bin
doc_dir = doc
executable = franklin
entrypoint = src/cli.cr


clean:
	-rm -rf $(bin_dir) $(doc_dir)
zip: bin/franklin
	$(eval version := $(shell $(bin_dir)/$(executable) --help | grep 'Franklin v' | cut -d 'v' -f2))
	zip $(bin_dir)/$(executable)-$(version).zip $(bin_dir)/$(executable)
install: bin/franklin
	cp $(bin_dir)/$(executable) /usr/local/bin/
bin/franklin: bin shard.lock src/**/*.cr
	$(crystal) build --release --no-debug -o $(bin_dir)/$(executable) $(entrypoint) $(CRFLAGS)
bin:
	mkdir -p $(bin_dir)
shard.lock: shard.yml
	$(shards) prune
	$(shards) install
	touch $@
docs: bin/franklin
	$(crystal) docs
test: shard.lock
	$(crystal) spec

.PHONY : clean install zip
