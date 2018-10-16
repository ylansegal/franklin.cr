crystal ?= $(shell which crystal)
shards ?= $(shell which shards)
bin_dir = bin
doc_dir = doc
executable = franklin
entrypoint = src/cli.cr

test: shard.lock
	$(crystal) spec
bin/franklin: bin shard.lock
	$(crystal) build -o $(bin_dir)/$(executable) $(entrypoint) $(CRFLAGS)
build_for_release: bin shard.lock
	$(crystal) build --release -o $(bin_dir)/$(executable) $(entrypoint) $(CRFLAGS)
	$(eval version := $(shell $(bin_dir)/$(executable) --help | grep 'Franklin v' | cut -d 'v' -f2))
	zip $(bin_dir)/$(executable)-$(version).zip $(bin_dir)/$(executable)
bin:
	mkdir -p $(bin_dir)
shard.lock: shard.yml
	$(shards) prune
	$(shards) install
	touch $@
install: bin/franklin
	cp $(bin_dir)/$(executable) /usr/local/bin/
docs: bin/franklin
	$(crystal) docs

.PHONY : clean install
clean :
	-rm -rf $(bin_dir) $(doc_dir)
