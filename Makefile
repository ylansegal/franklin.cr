crystal ?= $(shell which crystal)
bin_dir = bin
doc_dir = doc
executable = franklin
entrypoint = src/cli.cr

test: dependencies
	$(crystal) spec
build: bin_directory dependencies
	$(crystal) build -o $(bin_dir)/$(executable) $(entrypoint) $(CRFLAGS)
build_for_release: bin_directory dependencies
	$(crystal) build --release -o $(bin_dir)/$(executable) $(entrypoint) $(CRFLAGS)
	$(eval version := $(shell $(bin_dir)/$(executable) --help | grep 'Franklin v' | cut -d 'v' -f2))
	zip $(bin_dir)/$(executable)-$(version).zip $(bin_dir)/$(executable)
bin_directory:
	mkdir -p $(bin_dir)
dependencies: shard.lock
shard.lock: shard.yml
	$(crystal) deps prune
	$(crystal) deps
	touch $@
install: build_for_release
	cp $(bin_dir)/$(executable) /usr/local/bin/
docs: build
	$(crystal) docs

.PHONY : clean
clean :
	-rm -rf $(bin_dir) $(doc_dir)
