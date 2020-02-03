crystal ?= $(shell which crystal)
shards ?= $(shell which shards)

test: shard.lock
	$(crystal) spec --warnings all --error-on-warnings

clean:
	-rm -rf bin doc

zip: bin/franklin
	$(eval version := $(shell bin/franklin --help | grep 'Franklin v' | cut -d 'v' -f2))
	zip bin/franklin-$(version).zip bin/franklin

install: /usr/local/bin/franklin

/usr/local/bin/franklin: bin/franklin
	cp bin/franklin  /usr/local/bin/

bin/franklin: bin shard.lock src/*.cr src/**/*.cr
	$(crystal) build --release --no-debug -o bin/franklin src/cli.cr $(CRFLAGS)

bin:
	mkdir -p bin

shard.lock: shard.yml
	$(shards) prune
	$(shards) install
	touch $@

docs: bin/franklin
	$(crystal) docs

.PHONY : clean install zip test
