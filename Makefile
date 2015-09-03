CR_FILES := $(wildcard src/*.cr src/**/*.cr)

BINARY = fake_smtp

default: $(BINARY)

info:
	echo $(CR_FILES)

$(BINARY): $(CR_FILES)
	crystal build --release -o $@ $<

clean:
	rm -f $(BINARY)
